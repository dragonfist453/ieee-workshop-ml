// Store all the data required for out project



export dataMod := MODULE
	export dsrecord := RECORD
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
	shared ds2 := DATASET([{1,2,3,4,5,6,7,8,9,10,11,12,13},{14,15,16,17,18,19,20,21,22,23,24,25,26}],dsrecord);
	EXPORT Ds := DATASET('~workshop::house_prices_data.csv',dsrecord,CSV(HEADING(1)));
	
	
	// This is a main function, so this ecl file can be executed
	//export main:= FUNCTION
	//	a := OUTPUT('Hello World');
	//	return Sequential(a);
	//END;
END;

// Invalid code
//OUTPUT(dataMod.Ds);