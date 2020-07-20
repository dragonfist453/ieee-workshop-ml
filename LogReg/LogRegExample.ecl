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

Shuffler := RECORD(LogRegRecord)
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(LogRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..360], LogRegRecord);
TestDs := PROJECT(shuffledDs[361..400], LogRegRecord);

OUTPUT(TrainDs);
OUTPUT(TestDs);

ToNF := RECORD
    UNSIGNED id;
    LogRegRecord;
END;

newTrain := PROJECT(TrainDs, TRANSFORM(ToNF, SELF.id := COUNTER, SELF := LEFT));
newTest := PROJECT(TestDs, TRANSFORM(ToNF, SELF.id := COUNTER, SELF := LEFT));

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