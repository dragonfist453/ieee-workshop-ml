IMPORT ML_Core;
IMPORT LearningTrees;
IMPORT $ as root;

RFRegDs := root.Datasets.houseDs.Ds;

OUTPUT(RFRegDs, NAMED('InputDataset')); 

recordCount := COUNT(RFRegDs);
splitRatio := 0.8;

Shuffler := RECORD(RECORDOF(RFRegDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(RFRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(RFRegDs));

OUTPUT(TrainDs, NAMED('TrainDataset'));
OUTPUT(TestDs, NAMED('TestDataset'));

ML_Core.AppendSeqID(TrainDs, id, newTrain);
ML_Core.AppendSeqID(TestDs, id, newTest);

OUTPUT(newTrain, NAMED('TrainDatasetID'));
OUTPUT(newTest, NAMED('TestDatasetID'));

ML_Core.ToField(newTrain, TrainNF);
ML_Core.ToField(newTest, TestNF);

OUTPUT(TrainNF, NAMED('TrainNumericField'));
OUTPUT(TestNF, NAMED('TestNumericField'));

independent_cols := 12;

X_train := TrainNF(number < independent_cols + 1);
y_train := PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

X_test := TestNF(number < independent_cols + 1);
y_test := PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

OUTPUT(y_test, NAMED('ActualY'));

regressor := LearningTrees.RegressionForest(numTrees := 10).GetModel(X_train, y_train);

predicted := LearningTrees.RegressionForest().Predict(regressor, X_test);

OUTPUT(predicted, NAMED('PredictedY'));

accuracy_values := ML_Core.Analysis.Regression.Accuracy(predicted, y_test);
OUTPUT(accuracy_values, NAMED('AccuracyValues'));