libname My1stLib '/home/jchoi50/Desktop/MySAS/Data/';

data My1stLib.demog;
  infile "/home/jchoi50/Desktop/MySAS/Data/mydata.txt";
  input Gender $ Age Height Weight;
run;

title "My 1st Library";
proc print data=My1stLib.demog;
run;

data My1stLib.MySAS_Perm;
  set My1syLib.demographic;
run;

title "Turning a temp work dataset into a permanent one";
proc print data=My1stLib.MySAS_Perm;
run;


title "The Descriptor Portion of Data Set demog";
proc contents data=My1stLib.demog;
run;

title "The Descriptor Portion of Data Set demog";
proc contents data=My1stLib.demog varnum;   *list in order variables are stored instead of alphabetically;
run;

title "Complete Listing of My1stLib.demog";
proc print data=My1stLib.demog;
run;

title "Select Listing of My1stLib.demog";
proc print data=My1stLib.demog noobs;
  var Gender Age Weight;
  Where Gender="M";
run;


data equation;
  do X = -10 to 10 by .01;
    Y = 2*x**3 - 5*x**2 + 15*x -8;
    output;
  end;
run;

symbole value=none interpol=sm width=2;
title "Plot of Y vs. X";
proc gplot data=equation;
  plot Y * X;
run;


title "Distribution of Bicycle Sales by Country";
pattern value=empty;

proc gchart data=My1stLib.Bicycles;
   vbar Country / sumvar=TotalSales
                  type=sum;
run;
quit;
libname My1stLib '/home/jchoi50/Desktop/MySAS/Data/';

data My1stLib.demog;
  infile "/home/jchoi50/Desktop/MySAS/Data/mydata.txt";
  input Gender $ Age Height Weight;
run;

title "My 1st Library";
proc print data=My1stLib.demog;
run;

data My1stLib.MySAS_Perm;
  set My1syLib.demographic;
run;

title "Turning a temp work dataset into a permanent one";
proc print data=My1stLib.MySAS_Perm;
run;


title "The Descriptor Portion of Data Set demog";
proc contents data=My1stLib.demog;
run;

title "The Descriptor Portion of Data Set demog";
proc contents data=My1stLib.demog varnum;   *list in order variables are stored instead of alphabetically;
run;

title "Complete Listing of My1stLib.demog";
proc print data=My1stLib.demog;
run;

title "Select Listing of My1stLib.demog";
proc print data=My1stLib.demog noobs;
  var Gender Age Weight;
  Where Gender="M";
run;


data equation;
  do X = -10 to 10 by .01;
    Y = 2*x**3 - 5*x**2 + 15*x -8;
    output;
  end;
run;

symbol value=none interpol=sm width=2;
title "Plot of Y vs. X";
proc gplot data=equation;
  plot Y * X;
run;


title "Distribution of Bicycle Sales by Country";
pattern value=empty;

proc gchart data=My1stLib.Bicycles;
*Appears to sum over "TotalSales" column for each "Country" column values;
   vbar Country / sumvar=TotalSales
                  type=sum;
run;
quit;


*Use PROC Means expanded;
title "Proc Means for the binary Data Set";
proc means data=My1stLib.binary n nmiss mean median min max maxdec=1;
  var gre gpa;
run;
