
// This is a record, lets assume everything is all strings right now.
// Dont bother about setting REAL6 or DECIMAL45, the numbers are not important for now
myrecord := RECORD
	REAL experience;
	DECIMAL salary;
END;


// This will load up the dataset, we have to mention that this was a csv file
// We used a '~' to override, but its not necessary, its a personal choice to keep it explicit
mydataset := DATASET('~workshop::salary_data.csv',myRecord,CSV(HEADING(1)));


// Here is an output
OUTPUT(myDataSet);


// Now for some manipulations


// 1. Fetching a part of the whole dataset based on its position

// All these datasets, are *one indexed*. So now, what if you want the first element?
thefirst := mydataset[1];

// fetching the first 20
thefirstfew := mydataset[1..20];


// lets actually name this output, to keep it easier to understand
OUTPUT(thefirst, NAMED('first'));
OUTPUT(thefirstfew, NAMED('first_twenty'));
// names, cannot have spaces, due to internal reasons (you can try it with 'firt twenty')


// 2. Some ways to do filters


// lets say, let's say we are the tax dept, we need some people who earn more than 1,00,000
// we can do it in one line
lotsofmoney := mydataset(salary>100000);

OUTPUT(lotsofmoney,NAMED('lotsofsalary'));