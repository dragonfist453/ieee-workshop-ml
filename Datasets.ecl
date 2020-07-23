EXPORT Datasets := MODULE
    // Module to obtain dataset of salary_data.csv
    EXPORT salaryDs := MODULE
        SHARED dsrecord := RECORD
            REAL YearsExperience;
            INTEGER Salary;
        END;

        EXPORT Ds := DATASET('~workshop::salary_data.csv',
                        dsrecord,
                        CSV(HEADING(1),
                            SEPARATOR(','),
                            TERMINATOR(['\n','\r\n','\n\r'])));
    END;

    // Module to obtain dataset of social_network_ads.csv
    EXPORT socialDs := MODULE
        dsrecord := RECORD
            UNSIGNED Age;
            INTEGER EstimatedSalary;
            INTEGER purchased;
        END;

        EXPORT Ds := DATASET('~workshop::social_network_ads.csv',
                 dsrecord,
                 CSV(HEADING(1),
                     SEPARATOR(','),
                     TERMINATOR(['\n','\r\n','\n\r'])));
    END;

    // Module to obtain dataset of placement_data.csv                         
END;                        