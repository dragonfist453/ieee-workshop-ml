IMPORT $.datamod;

dsrecord := RECORDOF(datamod.ds1);
ds1 := DATASET('~workshop::house_prices_data.csv',dsrecord,CSV(HEADING(1)));	
ds2 := DATASET([{1,2,3,4,5,6,7,8,9,10,11,12,13},{14,15,16,17,18,19,20,21,22,23,24,25,26}],dsrecord);

//a function that returns only those house info which have a given number of bedrooms
getroomcount(DATASET(dsrecord) dset,integer number_bedrooms) := FUNCTION
		part := dset(bedrooms=number_bedrooms);
		number := count(part);
		return number;
END;

//call the function
OUTPUT( getroomcount(ds1,1)  ,NAMED('FunctionOut'));

//Gives me the count of houses with given number of bedrooms
getroomcount(ds1,2);
getroomcount(ds2,14);