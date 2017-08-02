/* 
Create new dataset to store the above observation 
*/
Data A1;
input age gender height weight @@;
cards;
13 1 165 53
15 0 162 55
16 0 158 48
10 0 145 40
11 1 164 45
13 1 169 65 
;
/*Perform log transformation on the age attribute*/
data A2;
set A1;
logAge = log(Age);
/*Delete column and rows*/
Data A3;
set A1;
drop weight;
if age le 12 then delete;
/*Display the age distribution in histogram*/
proc univariate data=A1;
var age;
Histogram age / normal;
title 'Histogram of Age';
run;
/*Import cars from the SAS library and store it in temporary data set cars1*/
data car1;
set sashelp.cars;
run; 
/*Visualize MPG_city using histogram*/
proc univariate data= car1;
var mpg_city;
histogram mpg_city;
title 'Histogram to display MPG on city';
run;
/*perform log transformation on the mpg_city attribute and visualize using histogram*/
data cars2;
set sashelp.cars;
set car1;
logMpgcity = log(mpg_city);
proc univariate data==cars2;
histogram logMpgcity;
title 'Histogram on transformed mpg_city';
run;
/*Use bar chart to display the frequency of the variable type*/
ods graphics on;
proc sgplot data=work.cars;
vbar type;
run;
ods graphics off;
