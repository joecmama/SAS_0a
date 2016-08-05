Data conditional;
  Length Gender $ 1
         Quiz   $ 2;
  input Age Gender Midterm Quiz FinalExam;
  if Age lt 20 and not missing(age) then AgeGroup = 1;
  else if Age ge 20 and Age lt 40 then AgeGroup = 2;
  else if Age ge 40 and Age lt 60 then AgeGroup = 3;
  else if Age ge 60 then AgeGroup = 4;
Datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F .  .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
;

Title 'Listing of Conditional';
Proc print data=conditional noobs;
  var Age Gender Midterm Quiz FinalExam AgeGroup;
run;

Data grades;
  Length Gender $ 1
         Quiz   $ 2
         AgeGrp $ 13;
  infile '/home/jchoi50/Desktop/MySAS/Data/grades.txt';
  input Age Gender Midterm Quiz FinalExam;
  if missing(age) then delete;
    if Age le 39 then do;
      AgeGrp = 'Younger Group';
      Grade  = .4*Midterm + .6*FinalExam;
    end;
  else if Age gt 39 then do;
    AgeGrp = 'Older Group';
    Grade  = (Midterm + FinalExam)/2;
  end;
run;

Title 'Listing of Grades';
Proc print data=grades noobs;
  var Age Gender Midterm Quiz FinalExam AgeGrp Grade;
run;

Data table;
  do n = 1 to 10;
    Square = n*n;
    SquareRoot = sqrt(n);
    output;
  end;
run;

Title "Table of Squares and Square Roots";
Proc print data=table;* noobs;
run;


Data double;
  Interest = .0375;
  Total = 100;
  do while (Total le 200);
    Year + 1;
    Total = Total + Interest*Total;
    output; *Using OUTPUT without arguments causes the current observation to be written to all data sets that are named in the DATA statement;
  end;
  format Total dollar10.2;
run;

Title "Output for Do While Loop Interest";
Proc print data=double noobs;
run;


data clintrial;
  length center $4;
  do center = "UofR", "UCLA", "YALE";
    do id = 1 to 4;
      if ranuni(222777) > 0.5 then group = 'D';
      else group = 'P';
      output;
    end;
  end; run;
run;

title "Clinical Trial Randomization";
proc print data=clintrial;
run;
