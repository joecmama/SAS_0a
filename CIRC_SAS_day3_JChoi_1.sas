libname My1stLib '/home/jchoi50/Desktop/MySAS/Data/';

proc sort data=My1stLib.binary out=My1stLib.binary;
   by admit;
run;

title "Proc Means for the binary Data Set";
proc means data=My1stLib.binary
