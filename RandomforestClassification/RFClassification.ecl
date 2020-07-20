IMPORT ML_Core;
IMPORT LearningTrees;

RFClassRecord := RECORD
    UNSIGNED Age;
    INTEGER EstimatedSalary;
    INTEGER purchased;
END;

RFClassDs := DATASET('~workshop::social_network_ads.csv',
                 RFClassRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));

OUTPUT(RFClassDs);

recordCount := COUNT(RFClassDs);
splitRatio := 0.95;

Shuffler := RECORD(RFClassRecord)
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFClassDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RFClassRecord);
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RFClassRecord);

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

classifier := LearningTrees.ClassificationForest().GetModel(X_train, y_train);

predicted := LearningTrees.ClassificationForest().Classify(classifier, X_test);

OUTPUT(predicted);