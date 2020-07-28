IMPORT $.dataMod;

output(dataMod.ds1);
mydataset := dataMod.ds1;

//Get the record of a variable
housingrecord:= RECORDOF(dataMod.ds1);
OUTPUT(mydataset ,NAMED('oldPrices'));

/* Suppose we want to make a small transform
		1. Increment the prices by 10% for everything
	  2. attach the a unique id to it.
*/

//Make a transform function that increments the prices
housingrecord incrementprices( housingrecord L,integer C) := TRANSFORM
		SELF.price := L.price * 1.1;
		SELF := L;
END;

mynewPrices := PROJECT(mydataset,incrementprices(LEFT,COUNTER));
OUTPUT(mynewPrices, NAMED('newPrices'));

//Next, A transform that adds an ID

//first, we need a record that has an id included
//Extend the old record, by adding an id variable
housingrecordwithid := {
	integer id;
	RECORDOF(dataMod.ds1);
};

//Make a transform that increments the prices
housingrecordwithid addid( housingrecord L,integer C) := TRANSFORM
	SELF.id := C;
	SELF := L;
END;

//Now project the myNewPrices using the addid)
houseswithids := PROJECT(mynewprices,addid(LEFT,COUNTER));
OUTPUT(houseswithids ,NAMED('withids'));