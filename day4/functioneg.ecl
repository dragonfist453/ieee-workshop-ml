IMPORT $.datamod;

dsrecord := RECORDOF(datamod.ds1);
ds1 := DATASET('~workshop::house_prices_data.csv',dsrecord,CSV(HEADING(1)));	
ds2 := DATASET([{1,2,3,4,5,6,7,8,9,10,11,12,13},{14,15,16,17,18,19,20,21,22,23,24,25,26}],dsrecord);


//a function that returns only those house info which have a given number of bedrooms
getroomwords(DATASET(dsrecord) dset,integer number_bedrooms) := FUNCTION
		part := dset(bedrooms=number_bedrooms);
		return part;
END;


//call the function
OUTPUT( getroomwords(ds1,1)  ,NAMED('FunctionOut'));
getroomwords(ds1,2);

getroomwords(ds2,14);
