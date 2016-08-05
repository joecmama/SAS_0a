*SAS Program to read veggie data file and to produce several reports;


options nocenter nonumber;

data veg;
   infile "/home/jchoi50/Desktop/MySAS/Data/veggies.txt";
   input Name $ Code $ Days Number Price;
   CostPerSeed = Price/Number;
run;

title "List of the Raw Data";
proc print data=veg;
run;

title "Frequency Distribution of Vegetable Names";
proc freq data=veg;
   table Name;
run;

title "Average Cost of Seeds";
proc means data=veg;
   var Price Days;
run;
