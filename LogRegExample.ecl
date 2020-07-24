IMPORT ML_Core;
IMPORT LogisticRegression;

LogRegDs := $.Datasets.socialDs.Ds;

OUTPUT(LogRegDs);

recordCount := COUNT(LogRegDs);
splitRatio := 0.8;

Shuffler := RECORD(RECORDOF(LogRegDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(LogRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(LogRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(LogRegDs));

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

independent_cols := 2;

X_train := TrainNF(number < independent_cols + 1);
y_train := ML_Core.Discretize.ByRounding(PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

X_test := TestNF(number < independent_cols + 1);
y_test := ML_Core.Discretize.ByRounding(PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

OUTPUT(y_test);

classifier := LogisticRegression.BinomialLogisticRegression(max_iter := 15000).GetModel(X_train, y_train);

predicted := LogisticRegression.BinomialLogisticRegression().Classify(classifier, X_test);

OUTPUT(predicted);

cm := ML_Core.Analysis.Classification.ConfusionMatrix(predicted, y_test);

OUTPUT(cm);

accuracy_values := ML_Core.Analysis.CLassification.Accuracy(predicted, y_test);

OUTPUT(accuracy_values);