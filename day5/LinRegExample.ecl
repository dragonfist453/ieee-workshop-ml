IMPORT ML_Core;
IMPORT LinearRegression;
IMPORT Visualizer;
IMPORT $ as root;

/*
// Making a record structure for the input dataset
LinRegRecord := RECORD
    REAL YearsExperience;
    INTEGER Salary;
END;

// Input of dataset as per the record
LinRegDs := DATASET('~workshop::salary_data.csv',
                 LinRegRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));
*/
// Get dataset from module
LinRegDs := root.Datasets.salaryDs.Ds;
OUTPUT(LinRegDs, NAMED('InputDataset')); 

// Get number of records in the dataset. Split ratio of train:test as a decimal.
recordCount := COUNT(LinRegDs);
splitRatio := 0.8;

// Record structure inheriting dataset record containing the randomising number
Shuffler := RECORD(RECORDOF(LinRegDs))
  UNSIGNED4 rnd; // A random number
END;

// Add an attribute to the data containing a random number
newDs := PROJECT(LinRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

// Shuffle by sorting the dataset as per the random number
shuffledDs := SORT(newDs, rnd);

// Split the train and test dataset while taking only the input record attributes
TrainDs := PROJECT(shuffledDs[1..(recordCount * splitRatio)], RECORDOF(LinRegDs));
TestDs := PROJECT(shuffledDs[(recordCount*splitRatio + 1)..recordCount], RECORDOF(LinRegDs));

OUTPUT(TrainDs, NAMED('TrainDataset'));
OUTPUT(TestDs, NAMED('TestDataset'));

// Append sequential ID to both train and test datasets
ML_Core.AppendSeqID(TrainDs, id, newTrain);
ML_Core.AppendSeqID(TestDs, id, newTest);

OUTPUT(newTrain, NAMED('TrainDatasetID'));
OUTPUT(newTest, NAMED('TestDatasetID'));

// Convert the dataset to Numeric Field for the training
ML_Core.ToField(newTrain, TrainNF);
ML_Core.ToField(newTest, TestNF);

OUTPUT(TrainNF, NAMED('TrainNumericField'));
OUTPUT(TestNF, NAMED('TestNumericField'));

// Split the converted Numeric Field datasets as per the number of independent columns to get X and Y for training 
independent_cols := 1;

X_train := TrainNF(number < independent_cols + 1);
y_train := PROJECT(TrainNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

X_test := TestNF(number < independent_cols + 1);
y_test := PROJECT(TestNF(number = independent_cols + 1), TRANSFORM(RECORDOF(LEFT), SELF.number := 1, SELF := LEFT));

OUTPUT(y_test, NAMED('ActualY'));

// Build the regressor by fitting to the model and predict using test dataset
regressor := LinearRegression.OLS(X_train, y_train).GetModel;
predicted := LinearRegression.OLS().Predict(X_test, regressor);

OUTPUT(predicted, NAMED('PredictedY'));

// Generate accuracy values
accuracy_values := ML_Core.Analysis.Regression.Accuracy(predicted, y_test);
OUTPUT(accuracy_values, NAMED('AccuracyValues'));


// VISUALISATION - Can be ignored
// Record structure to store points for visualisation
Points := RECORD
    REAL x;
END;

// Generate points from 0.01 to 12 with steps on 0.01
PointDs := DATASET(1200, TRANSFORM(Points, SELF.x := COUNTER/100));
ML_Core.AppendSeqID(PointDs, id, newPoints)
ML_Core.ToField(newPoints, PointNF);

// Predict as per model on the generated points
predicted_y := LinearRegression.OLS().Predict(PointNF, regressor);
OUTPUT(predicted_y, NAMED('PredictedYPointsNF'));

ML_Core.FromField(predicted_y,{UNSIGNED id;Points}, y);
OUTPUT(y, NAMED('PredictedYPoints'));

// Record structure of lines inheriting points
Line := RECORD(Points)
    REAL y;
END;

// Make dataset of line to visualise
LineDs := PROJECT(PointDs, TRANSFORM(Line, SELF.y := y[COUNTER].x, SELF:=LEFT));
OUTPUT(LineDs, NAMED('LinearRegressionPlot'));

// Output predicted line
viz_line := Visualizer.MultiD.Line('line',, 'LinearRegressionPlot');
viz_line;

// Output actual scatter plot
viz_scatter := Visualizer.MultiD.Scatter('scatter',, 'InDs');
viz_scatter;