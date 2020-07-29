#option('outputlimit', 2000);
getsorted := SORT($.persons,zipcode);

OUTPUT(getsorted);
OUTPUT(COUNT(getsorted));