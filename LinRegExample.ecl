IMPORT ML_Core;
IMPORT LinearRegression;
IMPORT Visualizer;

/*
LinRegRecord := RECORD
    REAL YearsExperience;
    INTEGER Salary;
END;

LinRegDs := DATASET('~workshop::salary_data.csv',
                 LinRegRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));
*/
LinRegDs := $.Datasets.salaryDs.Ds;

OUTPUT(LinRegDs, NAMED('InDs')); 

recordCount := COUNT(LinRegDs);
splitRatio := 0.8;

Shuffler := RECORD(RECORDOF(LinRegDs))
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(LinRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(LinRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(LinRegDs));

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

regressor := LinearRegression.OLS(X_train, y_train).GetModel;

predicted := LinearRegression.OLS().Predict(X_test, regressor);

OUTPUT(predicted);

accuracy_values := ML_Core.Analysis.Regression.Accuracy(predicted, y_test);
OUTPUT(accuracy_values);

Points := RECORD
    REAL x;
END;

PointDs := DATASET(1200, TRANSFORM(Points, SELF.x := COUNTER/100));
ML_Core.AppendSeqID(PointDs, id, newPoints)
ML_Core.ToField(newPoints, PointNF);

predicted_y := LinearRegression.OLS().Predict(PointNF, regressor);
OUTPUT(predicted_y);

ML_Core.FromField(predicted_y,{UNSIGNED id;Points}, y);
OUTPUT(y);

Line := RECORD(Points)
    REAL y;
END;

LineDs := PROJECT(PointDs, TRANSFORM(Line, SELF.y := y[COUNTER].x, SELF:=LEFT));
OUTPUT(LineDs, NAMED('LinearRegressionPlot'));

viz_line := Visualizer.MultiD.Line('line',, 'LinearRegressionPlot');
viz_line;

viz_scatter := Visualizer.MultiD.Scatter('scatter',, 'InDs');
viz_scatter;