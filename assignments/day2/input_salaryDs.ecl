dsrecord := RECORD
    REAL YearsExperience;
    INTEGER Salary;
END;

Ds := DATASET('~workshop::salary_data.csv',
                dsrecord,
                CSV(HEADING(1),
                    SEPARATOR(','),
                    TERMINATOR(['\n','\r\n','\n\r'])));

Ds;                    