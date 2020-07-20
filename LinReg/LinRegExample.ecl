IMPORT ML_Core;
IMPORT LinearRegression;

LinRegRecord := RECORD
    REAL YearsExperience;
    INTEGER Salary;
END;

LinRegDs := DATASET('~workshop::salary_data.csv',
                 LinRegRecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));

OUTPUT(LinRegDs); 

Shuffler := RECORD(LinRegRecord)
  UNSIGNED4 rnd; // A random number
END;

newDs := PROJECT(LinRegDs, TRANSFORM(Shuffler, SELF.rnd := RANDOM(), SELF := LEFT));

shuffledDs := SORT(newDs, rnd);

TrainDs := PROJECT(shuffledDs[1..20], LinRegRecord);
TestDs := PROJECT(shuffledDs[21..30], LinRegRecord);

OUTPUT(TrainDs);
OUTPUT(TestDs);

ToNF := RECORD
    UNSIGNED id;
    LinRegRecord;
END;

newTrain := PROJECT(TrainDs, TRANSFORM(ToNF, SELF.id := COUNTER, SELF := LEFT));
newTest := PROJECT(TestDs, TRANSFORM(ToNF, SELF.id := COUNTER, SELF := LEFT));

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