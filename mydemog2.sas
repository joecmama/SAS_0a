data demographic;
   infile '/home/jchoi50/Desktop/MySAS/Data/mydata.txt';
   input Gender $ Age Height Weight;
run;

title "Gender Frequencies";
proc freq data=demographic;
   tables Gender;
run;

title "Summary Statistics";
proc means data=demographic;
   var Age Height Weight;
run;
*Prgram name: mydemog.sas stored in the location
/home/yourNetID/Desktop/MySAS/Data/ folder.

Purpose: The program reads in data on height and weight
(in inches and pounds, respectively) and computes a body
mass index (BMI) for each subject.

Programmer: Joseph S. Choi
Data Written: July 20, 2016;

data demographic;
   infile '/home/jchoi50/Desktop/MySAS/Data/mydata.txt';
   input Gender $ Age Height Weight;

   *Compute a body madd index(BMI);
   BMI = (Weight / 2.2) / (Height*.0254)**2;
run;

title "Gender Frequencies";
proc freq data=demographic;
   tables Gender;
run;

title "Summary Statistics";
proc means data=demographic;
   var Age Height Weight;
run;

title "Print demographic data set"
proc print data=demographic;
run;
