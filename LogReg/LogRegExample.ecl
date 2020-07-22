IMPORT ML_Core;
IMPORT LogisticRegression;

LogRegRecord := RECORD
    UNSIGNED Age;
    INTEGER EstimatedSalary;
    INTEGER purchased;
END;

LogRegDs := DATASET('~workshop::social_network_ads.csv',
                 LogRegRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));

OUTPUT(LogRegDs);

recordCount := COUNT(LogRegDs);
splitRatio := 0.8;

Shuffler := RECORD(LogRegRecord)
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(LogRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], LogRegRecord);
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], LogRegRecord);

OUTPUT(TrainDs);
OUTPUT(TestDs);

ML_Core.AppendSeqID(TrainDs, id, newTrain);
ML_Core.AppendSeqID(TestDs, id, newTest);

OUTPUT(newTrain);
OUTPUT(newTest);

ML_Core.ToField(newTrain, TrainNF);
ML_Core.ToField(newTest, TestNF);

OUTPUT(TrainNF);
OUTPUT(TestNF);

X_train := TrainNF(number < 3);
y_train := ML_Core.Discretize.ByRounding(PROJECT(TrainNF(number = 3), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

X_test := TestNF(number < 3);
y_test := ML_Core.Discretize.ByRounding(PROJECT(TestNF(number = 3), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

OUTPUT(y_test);

classifier := LogisticRegression.BinomialLogisticRegression(max_iter := 15000).GetModel(X_train, y_train);

predicted := LogisticRegression.BinomialLogisticRegression().Classify(classifier, X_test);

OUTPUT(predicted);

cm := ML_Core.Analysis.Classification.ConfusionMatrix(predicted, y_test);

OUTPUT(cm);

accuracy_values := ML_Core.Analysis.CLassification.Accuracy(predicted, y_test);

OUTPUT(accuracy_values);