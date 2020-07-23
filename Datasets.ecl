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
    EXPORT houseDs := MODULE
        dsrecord := RECORD
            UNSIGNED bedrooms;
            REAL bathrooms;
            REAL sqft_living;
            REAL sqft_lot;
            UNSIGNED floors;
            UNSIGNED condition;
            UNSIGNED grade;
            REAL sqft_above;
            REAL sqft_basement;
            UNSIGNED yr_built;
            REAL sqft_living15;
            REAL sqft_lot15;
            REAL price;
        END;
        
        EXPORT Ds := DATASET('~workshop::house_prices_data.csv',
                    dsrecord,
                    CSV(HEADING(1),
                        SEPARATOR(','),
                        TERMINATOR(['\n','\r\n','\n\r'])));
    END;                          
END;                        