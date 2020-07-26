IMPORT ML_Core;
IMPORT LearningTrees;
IMPORT $ as root;

RFClassDs := root.Datasets.heartDs.Ds;

OUTPUT(RFClassDs, NAMED('InputDataset'));

recordCount := COUNT(RFClassDs);
splitRatio := 0.8;

Shuffler := RECORD(RECORDOF(RFClassDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFClassDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(RFClassDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(RFClassDs));

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

independent_cols := 13;

X_train := TrainNF(number < independent_cols + 1);
y_train := ML_Core.Discretize.ByRounding(PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

X_test := TestNF(number < independent_cols + 1);
y_test := ML_Core.Discretize.ByRounding(PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT)));

OUTPUT(y_test, NAMED('ActualY'));

classifier := LearningTrees.ClassificationForest().GetModel(X_train, y_train);

predicted := LearningTrees.ClassificationForest().Classify(classifier, X_test);

OUTPUT(predicted, NAMED('PredictedY'));

cm := ML_Core.Analysis.Classification.ConfusionMatrix(predicted, y_test);

OUTPUT(cm, NAMED('ConfusionMatrix'));

accuracy_values := ML_Core.Analysis.CLassification.Accuracy(predicted, y_test);

OUTPUT(accuracy_values, NAMED('AccuracyValues'));