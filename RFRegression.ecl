IMPORT ML_Core;
IMPORT LearningTrees;

/*
RFRegRecord := RECORD
    REAL YearsExperience;
    INTEGER Salary;
END;

RFRegDs := DATASET('~workshop::salary_data.csv',
                 RFRegRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));
*/
RFRegDs := $.Datasets.salaryDs.Ds;

OUTPUT(RFRegDs); 

recordCount := COUNT(RFRegDs);
splitRatio := 0.8;

Shuffler := RECORD(RECORDOF(RFRegDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(RFRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(RFRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(RFRegDs));

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

X_train := TrainNF(number < 2);
y_train := PROJECT(TrainNF(number = 2), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

X_test := TestNF(number < 2);
y_test := PROJECT(TestNF(number = 2), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

OUTPUT(y_test);

regressor := LearningTrees.RegressionForest().GetModel(X_train, y_train);

predicted := LearningTrees.RegressionForest().Predict(regressor, X_test);

OUTPUT(predicted);

accuracy_values := ML_Core.Analysis.Regression.Accuracy(predicted, y_test);
OUTPUT(accuracy_values);