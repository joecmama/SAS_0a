  libname My1stLib '/home/jchoi50/Desktop/MySAS/Data/';

proc sort data=My1stLib.binary out=My1stLib.binary;
  by admit;
run;

title "Proc Freq for the binary Data Set";
proc freq data=My1stLib.binary;
  tables rank admit admit*rank;
run;

title "Proc Logistic";
proc logistic data=My1stLib.binary descending;
  class rank / param=ref;
  model admit = gre gpa rank;
run;
