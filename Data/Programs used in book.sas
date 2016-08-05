*--------------------------------------------------------*
| Programs used in this book.  Remember to add a libname |
| statement to create a libref called LEARN and to       |
| edit all the libname statements that are part of the   |
| programs listed here.  You can search for the string:  |
|                                                        |
| c:\books\learning                                      |
|                                                        |
| and replace it with the folder where you are storing   |
| your SAS data sets.                                    |
|                                                        |
| You will need to run the program CREATE_DATASETS.SAS   |
| prior to running programs in this file.                |
|                                                        |
| You also need to modify the INFILE statements to       |
| point to the folder where you located your text files. |                    |
*--------------------------------------------------------*;

*Program 1-1 A sample SAS program;
*SAS Program to read veggie data file and to produce
 several reports;

options nocenter nonumber;

data veg;
   infile "c:\books\learning\veggies.txt";
   input Name $ Code $ Days Number Price;
   CostPerSeed = Price / Number;
run;

title "List of the Raw Data";
proc print data=veg;
run;

title "Frequency Distribution of Vegetable Names";
proc freq data=veg;
   tables Name;
run;

title "Average Cost of Seeds";
proc means data=veg;
   var Price Days;
run;

*Program 2-1 Your first SAS program;
data demographic;
   infile "c:\books\learning\mydata.txt";
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

*Program 2-2;
*Program name: demog.sas. stored in the
 c:\books\learning folder.

 Purpose: The program reads in data on height and weight
 (in inches and pounds, respectively) and computes a body
 mass index (BME) for each subject.

 Programmer: Ron Cody
 Date written: May 2006;
data demographic;
   infile "c:\books\learning\mydata.txt";
   input Gender $ Age Height Weight;
run;

*Program 3-1 Demonstrating list-input with blanks as delimiters;
data demographics;
   infile 'c:\books\learning\mydata.txt';
   input Gender $ Age Height Weight;
run;

*Program 3-2 Adding PROC PRINT to list the observations in the data set;
title "Listing of data set DEMOGRAPHICS";
proc print data=demographics;
run;

*Program 3-3 Reading data from a comma-separated variables (csv) file;
data demographics;
   infile 'c:\books\learning\mydata.csv' dsd;
   input Gender $ Age Height Weight;
run;

*Program 3-4 Using a FILENAME statement to identify an external file;
filename preston 'c:\books\learning\mydata.csv';

data demographics;
   infile preston dsd;
   input Gender $ Age Height Weight;
run;

*Program 3-5 Demonstrating the DATALINES statement;
data demographic;
   input Gender $ Age Height Weight;
datalines;
M 50 68 155
F 23 60 101
M  65  72 220
F 35 65 133
M 15 71 166
;

*Program 3-6 Using INFILE options with DATALINES;
data demographics;
   infile datalines dsd;
   input Gender $ Age Height Weight;
datalines;
"M",50,68,155
"F",23,60,101
"M",65,72,220
"F",35,65,133
"M",15,71,166
;

*Program 3-7 Demonstrating column input;
data financial;
   infile 'c:\books\learning\bank.txt';
   input Subj     $   1-3
         DOB      $  4-13
         Gender   $    14
         Balance    15-21;
run;

*Program 3-8 Demonstrating formatted input;
data financial;
   infile 'c:\books\learning\bank.txt';
   input @1  Subj         $3.
         @4  DOB    mmddyy10.
         @14 Gender       $1. 
         @15 Balance       7.;
run;

*Program 3-9 Demonstrating a format statement;
title "Listing of FINANCIAL";
proc print data=financial;
   format DOB     mmddyy10. 
          Balance dollar11.2;
run;

*Program 3-10 Rerunning program Program 3 9 with a different format;
title "Listing of FINANCIAL";
proc print data=financial;
   format DOB     date9. 
          Balance dollar11.2;
run;

*Program 3-11 Using INFORMATS with List Input ;
data list_example;
   infile 'c:\books\learning\list.csv' dsd;
   input Subj   :       $3.
         Name   :      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

*Program 3-12 Supplying an INFORMAT with List Input;
data list_example;
   informat Subj        $3.
            Name       $20.
            DOB   mmddyy10.
            Salary dollar8.;
   infile 'c:\books\learning\list.csv' dsd;
   input Subj
         Name
         DOB
         Salary;
   format DOB date9. Salary dollar8.;
run;

*Program 3-13 Demonstrating the ampersand modifier for list input;
data list_example;
   infile 'c:\books\learning\list.txt';
   input Subj   :       $3.
         Name   &      $20.
         DOB    : mmddyy10.
         Salary :  dollar8.;
   format DOB date9. Salary dollar8.;
run;

*Program 4-1 Creating a permanent SAS data set;
libname mozart 'c:\books\learning';

data mozart.test_scores;
   length ID $ 3 Name $ 15;
   input ID $ Score1-Score3 Name $;
datalines;
1 90 95 98 Cody
2 78 77 75 Preston
3 88 91 92 Russell
;

*Program 4-2 Using PROC CONTENTS to examine the 
 descriptor portion of a SAS data set;
title "The Descriptor Portion of Data Set TEST_SCORES";
proc contents data=Mozart.test_scores;
run;

*Program 4-3 Demonstrating the VARNUM option of PROC CONTENTS;
title "The Descriptor Portion of Data Set TEST_SCORES";
proc contents data=Mozart.test_scores varnum;
run;

*Program 4-4 Using a LIBNAME in a new SAS session;
libname proj99 'c:\books\learning';

title "Descriptor Portion of Data Set TEST_SCORES";
proc contents data=proj99.test_scores varnum;
run;

*Program 4-5 Using PROC CONTENTS to list the names of
 all the SAS data sets in a SAS library;
title "Listing All the SAS Data Sets in a Library";
proc contents data=Mozart._all_ nods;
run;

*Program 4-6 Using PROC PRINT to list the data 
 portion of a SAS data set;
title "Listing of TEST_SCORES";
proc print data=Mozart.test_scores;
run;

*Program 4-7 Using observations from a SAS data set
 as input to a new SAS data set;
libname learn 'c:\books\learning';

data new;
   set learn.test_scores;
   AveScore = mean(of score1-score3);
run;

title "Listing of Data Set NEW";
proc print data=new;
   var ID Score1-Score3 AveScore;
run;

*Program 4-8 Demonstrating a DATA _NULL_ DATA step;
data _null_;
   set learn.test_scores;
   if score1 ge 95 or score2 ge 95 or score3 ge 95 then
      put ID= Score1= Score2= Score3=;
run;

*Program 5-1 Adding labels to variables in a SAS data set;
libname learn 'c:\books\learning';

data learn.test_scores;
   length ID $ 3 Name $ 15;
   input ID $ Score1-Score3;
   label ID = 'Student ID'
         Score1 = 'Math Score'
         Score2 = 'Science Score'
         Score3 = 'English Score';
datalines;
1 90 95 98
2 78 77 75
3 88 91 92
;

*Program 5-2 Using PROC FORMAT to create user-defined formats;
proc format;
   value $gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
run;

*Program 5-3 Adding a FORMAT statement in PROC PRINT;
title "Data Set SURVEY with Formatted Values";
proc print data=learn.survey;
   id ID;
   var Gender Age Salary Ques1-Ques5;
   format Gender      $gender.
          Age         age.
          Ques1-Ques5 $likert.
          Salary      dollar11.2;
run;

*Program 5-4 Regrouping values using a format;
proc format;
   value $three '1','2' = 'Disagreement'
                '3'     = 'No opinion'
                '4','5' = 'Agreement';
run;

*Program 5-5 Applying the new format to several variables with PROC FREQ;
proc freq data=learn.survey;
   title "Question Frequencies Using the $three Format";
   tables Ques1-Ques5;
   format Ques1-Ques5 $three.;
run;

*Program 5-6 Creating a permanent format library;
libname myfmts 'c:\books\learning\formats';

proc format library=myfmts;
   value $gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
run;

*Program 5-7 Adding label and format statements in the DATA step;
libname learn 'c:\books\learning';
/**************************************************
libname myfmts 'c:\books\learning\formats';
options fmtsearch=(myfmts);
***************************************************/
options fmtsearch=(learn);

data learn.survey;
   infile 'c:\books\learning\survey.txt' pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(: $1.);
   format Gender      $gender.
          Age         age.
          Ques1-Ques5 $likert.
          Salary      dollar10.0;
   label ID     = 'Subject ID'
         Gender = 'Gender'
         Age    = 'Age as of 1/1/2006'
         Salary = 'Yearly Salary'
         Ques1  = 'The governor doing a good job?'
         Ques2  = 'The property tax should be lowered'
         Ques3  = 'Guns should be banned'
         Ques4  = 'Expand the Green Acre program'
         Ques5  = 'The school needs to be expanded';
run;

*Program 5-8 Running PROC CONTENTS on a data set with labels and formats;
title "Data set SURVEY";
proc contents data=learn.survey varnum;
run;

*Program 5-9 Using a user-defined format;
libname learn 'c:\books\learning';
libname myfmts 'c:\books\learning\formats';
options fmtsearch=(myfmts);

title "Using User-defined Formats";
proc freq data=learn.survey;
   tables Ques1-Ques5 / nocum;
run;

*Program 5-10 Displaying format definitions in a user-created library;
title "Format Definitions in the MYFMTS Library";
proc format library=myfmts fmtlib;
run;

*Program 5-11 Demonstrating a SELECT statement with PROC FORMAT;
proc format library=myfmts;
   select age $likert;
run;

*Program 6-1 Using PROC PRINT to list the first 4 observations
 in a data set;
/*************************************************** 
   Note: you need to use the IMPORT Wizard first to
   create the data set WAGES_TEMPORARY
title "The First 4 Observations of WAGES_TEMPORARY";
proc print data=wages_temporary(obs=4);
run;
****************************************************/

*Program 6-2 Using the FIRSTOBS and OBS options together;
*Note: project.verybig is a fictitious data set;
/**********************************************************
title "Observations 100 through 110 in VERYBIG";
proc print data=project.verybig(firstobs=100 obs=110);
run;
***********************************************************/

*Program 6-3 Reading a spreadsheet using a XLS engine;
libname readit 'c:\books\learning\wages.xls';
title "Statistics from Sales Spreadsheet";
proc means data=readit.'Permanent$'n mean;
   var Wage Hours_Worked;
run;

*Program 6-4 Using ODS to convert a SAS data set into a 
 CSV file (to be read by Excel);
libname learn 'c:\books\learning';

ods csv file='c:\books\learning\odsexample.csv';

proc print data=learn.survey noobs;
run;

ods csv close;

*Program 7-1 First attempt to group ages into age groups (incorrect);
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Age lt 20 then AgeGroup = 1;
   if Age ge 20 and Age lt 40 then AgeGroup = 2;
   if Age ge 40 and Age lt 60 then AgeGroup = 3;
   if Age ge 60 then AgeGroup = 4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of CONDITIONAL";
proc print data=conditional noobs;
run;

*Program 7-2 Corrected program to group ages in to age groups;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Age lt 20 and not missing(age) then AgeGroup = 1;
   else if Age ge 20 and Age lt 40 then AgeGroup = 2;
   else if Age ge 40 and Age lt 60 then AgeGroup = 3;
   else if Age ge 60 then AgeGroup = 4;
datalines;

*Program 7-3 An alternative to Program 7-2;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then AgeGroup = .;
      else if Age lt 20 then AgeGroup = 1;
      else if Age lt 40 then AgeGroup = 2;
      else if Age lt 60 then AgeGroup = 3;
      else if Age ge 60 then AgeGroup = 4;
datalines;

*Program 7-4 Demonstrating a subsetting IF statement;
data females;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   if Gender eq 'F';
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F  . .  76
59 F 95 A+ 97
15 M 88 .  93
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "Listing of FEMALES";
proc print data=Females noobs;
run;

*Program 7-5 Demonstrating a SELECT statement when a select-expression
 is missing;
data conditional;
   length Gender $ 1
          Quiz   $ 2;
   input Age Gender Midterm Quiz FinalExam;
   select;
      when (missing(Age)) AgeGroup = .;
      when (Age lt 20) AgeGroup = 1;
      when (Age lt 40) AgeGroup = 2;
      when (Age lt 60) AgeGroup = 3;
      when (Age ge 60) Agegroup = 4;
      otherwise;
   end;
datalines;

*Program 7-6 Combining various Boolean operators;
title "Example of Boolian Expressions";
proc print data=learn.medical;
   where Clinic eq 'HMC' and 
         (DX in ('7' '9') or 
         Weight gt 180);
   id Patno;
   var Patno Clinic DX Weight VisitDate;
run;

*Program 7-7 A caution on the use of multiple OR's;
data believe_it_or_not;
   input X;
   if X = 3 or 4 then Match = 'Yes';
   else Match = 'No';
datalines;
3
7
.
;
title "Listing of BELIEVE_IT_OR_NOT";
proc print data=believe_it_or_not noobs;
run;

*Program 7-8 Using a WHERE statement to subset a SAS data set;
data females;
   set conditional;
   where Gender eq 'F';
run;

*Program 8-1 Example of a program that does not use a DO group;
data grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGrp $ 13;
   infile 'c:\books\learning\grades.txt' missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then Agegrp = 'Younger group';
   if Age le 39 then Grade  = .4*Midterm + .6*FinalExam;
   if Age gt 39 then Agegrp = 'Older group';
   if Age gt 39 then Grade  = (Midterm + FinalExam)/2;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

*Program 8-2 Demonstrating a DO group;
data grades;
   length Gender $ 1
          Quiz   $ 2
          AgeGrp $ 13;
   infile 'c:\books\learning\grades.txt' missover;
   input Age Gender Midterm Quiz FinalExam;
   if missing(Age) then delete;
   if Age le 39 then do;
      Agegrp = 'Younger group';
      Grade = .4*Midterm + .6*FinalExam;
   end;
   else if Age gt 39 then do;
      Agegrp = 'Older group';
      Grade = (Midterm + FinalExam)/2;
   end;
run;

title "Listing of GRADES";
proc print data=grades noobs;
run;

*Program 8-3 Attempt to create a cumulative total 
 (Note: this program does not work);
data revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;

*Program 8-4 Adding a RETAIN statement to Program 8-3;
data revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   Total = Total + Revenue; /* Note: this does not work */
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;

*Program 8-5 Third attempt to create cumulative total ;
data revenue;
   retain Total 0;
   input Day : $3.
         Revenue : dollar6.;
   if not missing(Revenue) then Total = Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;

*Program 8-6 Using a SUM statement to create a cumulative total;
data revenue;
   input Day : $3.
         Revenue : dollar6.;
   Total + Revenue;
   format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed  .     
Thu $2,000
Fri $3,000
;

*Program 8-7 Using a SUM statement to create a counter;
data test;
   input x;
   if missing(x) then MissCounter + 1;
datalines;
2
.
7
.
;

*Program 8-8 Program without iterative loops;
data compound;
   Interest = .0375;
   Total = 100;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   Year + 1;
   Total + Interest*Total;
   output;

   format Total dollar10.2;
run;

title "Listing of COMPOUND";
proc print data=compound noobs;
run;

*Program 8-9 Demonstrating in iterative DO loop;
data compound;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 3;
      Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-10 Using an iterative Do loop to make a table
 of squares and square roots;
data table;
   do n = 1 to 10;
      Square = n*n;
      SquareRoot = sqrt(n);
      output;
   end;
run;

title "Table of Squares and Square Roots";
proc print data=table noobs;
run;

*Program 8-11 Using an iterative DO loop to graph an equation;
data equation;
   do X = -10 to 10 by .01;
      Y = 2*x**3 - 5*X**2 + 15*X -8;
      output;
   end;
run;

symbol value=none interpol=sm width=2;
title "Plot of Y versus X";
proc gplot data=equation;
   plot Y * X;
run;

*Program 8-12 Using character values for DO loop index values;
data easyway;
   do Group = 'Placebo','Active';
      do Subj = 1 to 5;
         input Score @;
         output;
      end;
   end;
datalines;
250 222 230 210 199
166 183 123 129 234
;

*Program 8-13 Demonstrating a DO UNTIL loop;
data double;
   Interest = .0375;
   Total = 100;
   do until (Total ge 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
   
title "Listing of DOUBLE";
proc print data=double noobs;
run;

*Program 8-14 Demonstrating that a DO UNTIL loop always 
 executes at least once;
data double;
   Interest = .0375;
   Total = 300;
   do until (Total gt 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-15 Demonstrating a DO WHILE statement;
data double;
   Interest = .0375;
   Total = 100;
   do while (Total le 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;
   
proc print data=double noobs;
   title "Listing of DOUBLE";
run;

*Program 8-16 Demonstrating that DO WHILE loops are evaluated at the top;
data double;
   Interest = .0375;
   Total = 300;
   do while (Total lt 200);
      Year + 1;
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-17 Combining a DO UNTIL and iterative DO loop;
data double;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total gt 200);
      Total = Total + Interest*Total;
      output;
   end;
   format Total dollar10.2;
run;

*Program 8-18 Demonstrating the LEAVE statement;
data leave_it;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100;
      Total = Total + Interest*Total;
      output;
      if Total ge 200 then leave;
   end;
   format Total dollar10.2;
run;

*Program 8-19 Demonstrating a CONTINUE statement;
data continue_on;
   Interest = .0375;
   Total = 100;
   do Year = 1 to 100 until (Total ge 200);
      Total = Total + Interest*Total;
      if Total le 150 then continue;
      output;
   end;
   format Total dollar10.2;
run;

*Program 9-1 Program to read dates from raw data;
data four_dates;
   infile 'c:\books\learning\dates.txt' truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
run;

*Program 9-2 Adding a format statement to format each of the date values;
data four_dates;
   infile 'c:\books\learning\dates.txt' truncover;
   input @1  Subject   $3.
         @5 DOB       mmddyy10.
         @16 VisitDate mmddyy8.
         @26 TwoDigit  mmddyy8.
         @34 LastDate  date9.;
   format DOB VisitDate date9.
          TwoDigit LastDate mmddyy10.;
run;

*Program 9-3 Compute a person's age in years;
data ages;
   set four_dates;
   Age = yrdif(DOB,VisitDate,'Actual');
run;

title "Listing of AGES";
proc print data=ages;
   id Subject;
   var DOB VisitDate Age;
run;

*Program 9-4 Demonstrating a date constant;
data ages;
   set four_dates;
   Age = yrdif(DOB,'01Jan2006'd,'Actual');
run;

title "Listing of AGES";
proc print data=ages;
   id Subject;
   var DOB Age;
   format Age 5.1;
run;

*Program 9-5 Using the TODAY function to return the current date;
data ages;
   set four_dates;
   Age = yrdif(DOB,today(),'Actual');
run;

*Program 9-6 Extracting the day of the week, day of the month,
 month and year from a SAS date;
data extract;
   set four_dates;
   Day = weekday(DOB);
   DayOfMonth = day(DOB);
   Month = Month(DOB);
   Year = year(DOB);
run;

title "Listing of EXTRACT";
proc print data=extract noobs;
   var DOB Day -- Year;
run;

*Program 9-7;
data mdy_example;
   set learn.month_day_year;
   Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
run;

*Program 9-8 Substituting the 15th of the month when a day value is missing;
data substitute;
   set learn.month_day_year;
   if missing(day) then Date = mdy(Month,15,Year);
   else Date = mdy(Month,Day,Year);
   format Date mmddyy10.;
run;

*Program 9-9 Demonstrating the INTCK function;
data frequency;
   set learn.hosp(keep=AdmitDate 
                  where=(AdmitDate between '01Jan2003'd and
                        '30Jun2006'd));
   Quarter = intck('qtr','01Jan2003'd,AdmitDate);
run;

title "Frequency of Admissions";
proc freq data=frequency noprint;
   tables Quarter / out=admit_per_quarter;
run;

goptions ftitle=swiss ftext=swiss;
symbol v=dot i=sm color=black width=2;
title height=2 "Frequency of Admissions From";
title2 height=2 "January 1, 2003 and June 30, 2006";

proc gplot data=admit_per_quarter;
   plot Count * Quarter;
run;
quit;

*Program 9-10 Using the INTNX function to compute dates
 6 months after discharge;
data followup;
   set learn.discharge;
   FollowDate = intnx('month',DischrDate,6);
   format FollowDate date9.;
run;

*Program 9-11 Demonstrating the SAMEDAY alignment with the INTNX function;
data followup;
   set learn.discharge;
   FollowDate = intnx('month',DischrDate,6,'sameday');
   format FollowDate date9.;
run;

*Program 10-1 Subsetting a SAS data set using a WHERE statement;
data females;
   set learn.survey;
   where gender = 'F';
run;

*Program 10-2 Demonstrating a DROP= data set option;
data females;
   set learn.survey(drop=Salary);
   where gender = 'F';
run;

*Program 10-3 Creating two data sets in one DATA step;
data males females;
   set learn.survey;
   if gender = 'F' then output females;
   else if gender = 'M' then output males;
run;

*Program to create temporary SAS data sets ONE, TWO, and THREE;
data one;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
7 Adams 210
1 Smith 190
2 Schneider 110
4 Gregory 90
;
data two;
   length ID $ 3 Name $ 12;
   input ID Name Weight;
datalines;
9 Shea 120
3 O'Brien 180
5 Bessler 207
;
data three;
   length ID $ 3 Gender $ 1. Name $ 12;
   Input ID Gender Name;
datalines;
10 M Horvath
15 F Stevens
20 M Brown
;

*Program 10-4 Using a SET statement to combine observations
 from two data sets;
data one_two;
   set one two;
run;

*Program 10-5 Setting two data sets containing different variables;
data one_three;
   set one three;
run;

*Program 10-6 Interleaving data sets;
proc sort data=one;
   by ID;
run;

proc sort data=two;
   by ID;
run;

data interleave;
   set one two;
   by ID;
run;

*Program 10-7 Combining detail and summary data: Conditional SET statement;
proc means data=learn.blood noprint;
   var Chol;
   output out = means(keep=AveChol)
          mean = AveChol;
run;

data percent;
   set learn.blood(keep=Subject Chol);
   if _n_ = 1 then set means;
   PerChol = Chol / AveChol;
   format PerChol percent8.;
run;

*Program to-create two temporary SAS data sets EMPLOYEE and HOURS;
data employee;
   length ID $ 3 Name $ 12;
   input ID Name;
datalines;
7 Adams
1 Smith
2 Schneider
4 Gregory
5 Washington
;

data hours;
   length ID $ 3 JobClass $ 1;
   input ID 
         JobClass
         Hours;
datalines;
1 A 39
4 B 44
9 B 57
5 A 35
;

*Program 10-8 Merging two SAS data sets;
proc sort data=employee;
   by ID;
run;

proc sort data=hours;
   by ID;
run;

data combine;
   merge employee hours;
   by ID;
run;

*Program 10-9 Demonstrating the IN= data set option;
data new;
   merge employee(in=InEmploy)
         hours   (in=InHours);
   by ID;
   file print;
   put ID= InEmploy= InHours= Name= JobClass= Hours=;
run;

*Program 10-10 Using the IN= variables to select ID's 
 that are in both data sets;
data combine;
   merge employee(in=InEmploy)
         hours(in=InHours);
   by ID;
   if InEmploy and InHours;
run;

*Program 10-11 More examples of using the IN= variables;
data in_both 
     missing_name(drop = Name);
   merge employee(in=InEmploy)
         hours(in=InHours);
   by ID;
   if InEmploy and InHours then output in_both;
   else if InHours and not InEmploy then 
      output missing_name;
run;

*Program 10-12 Demonstrating when a DATA step ends;
data short;
   input x;
datalines;
1
2
;
data long;
   input x;
datalines;
3
4
5
6
;
data new;
   set short;
   output;
   set long;
   output;
run;

*Program to create temporary SAS data sets BERT and ERNIE;
data bert;
   input ID $ X;
datalines;
123 90
222 95
333 100
;
data ernie;
   input EmpNo $ Y;
datalines;
123 200
222 205
333 317
;

*Program 10-13 Merging two data sets, rename a variable in one data set;
data sesame;
   merge bert
         ernie(rename=(EmpNo = ID));
   by ID;
run;

*Program to create temporary SAS data sets DIVISION1 and DIVISION2;
Data division1;
   input SS
         DOB : mmddyy10.
         Gender : $1.;
   format DOB mmddyy10.;
datalines;
111223333 11/14/1956 M
123456789 5/17/1946 F
987654321 4/1/1977 F
;

data division2;
   input SS : $11.
         JobCode : $3.
         Salary : comma8.0;
datalines;
111-22-3333 A10 $45,123
123-45-6789 B5 $35,400
987-65-4321 A20 $87,900
;

*Program 10-14 Merging two data sets where the BY variables
 are different data types;
data division1c;
   set division1(rename=(SS = NumSS));
   SS = put(NumSS,ssn11.);
   drop NumSS;
run;
data both_divisions;
   ***Note: Both data sets already in order
      of BY variable;
   merge division1c division2;
   by SS;
run;

*Program 10-15 An alternative to Program 10 14;
data division2n;
   set division2(rename=(SS = CharSS));
   SS = input(compress(CharSS,'-'),9.);
   ***Alternative:
   SS = input(CharSS,comma11.);
   drop CharSS;
run;

*Program to create temporary SAS data set OSCAR used in chapter 10;
data oscar;
   input ID $ Y;
datalines;
123  200
123  250
222  205
333  317
333  400
333  500
;

*Program to create temporary SAS data sets PRICES and NEW15DEC2006
 used in chapter 10;
data prices;
   Length ItemCode $ 3 Description $ 17;
   input ItemCode Description & Price;
datalines;
150 50 foot hose  19.95
175 75 foot hose  29.95
200 greeting card  1.99
204 25 lb. grass seed  18.88
208 40 lb. fertilizer  17.98
;

data new15dec2005;
   Length ItemCode $ 3;
   input ItemCode Price;
datalines;
204 17.87
175 25.11
208 .
;

*Program 10-16 Updating a master file from a transaction file:
 UPDATE statement;
proc sort data=prices;
   by ItemCode;
run;
proc sort data=new15dec2005;
   by ItemCode;
run;

data prices_15dec2005;
   update prices new15dec2005;
   by ItemCode;
run;

*Program 11-1 Demonstrating the ROUND and INT truncation functions;
data truncate;
   input Age Weight;
   Age = int(Age);
   WtKg = round(Weight/2.2,.1);
   Weight = round(Weight);
datalines;
18.8 100.7
25.12 122.4
64.99 188
;

title "Listing of TRUNCATE";
proc print data=truncate noobs;
run;


*Program 11-2 Testing for numeric and character missing values
 (without the missing function);
data test_miss;
   set learn.blood;
   if Gender = ' ' then MissGender + 1;
   if WBC = . then MissWBC + 1;
   if RBC = . then MissWBC + 1;
   if Chol lt 200 and Chol ne . then Level = 'Low ';
   else if Chol ge 200 then Level = 'High';
run;

*Program 11-3 Demonstrating the MISSING function;
data test_miss;
   set learn.blood;
   if missing(Gender) then MissGender + 1;
   if missing(WBC) then MissWBC + 1;
   if missing(RBC) then MissWBC + 1;
   if Chol lt 200 and not missing(Chol) then 
      Level = 'Low ';
   else if Chol ge 200 then Level = 'High';
run;

*Program 11-4 Demonstrating the N, MEAN, MIN, and MAX functions;
data psych;
   input ID $ Q1-Q10;
   if n(of Q1-Q10) ge 7 then Score = mean(of Q1-Q10);
   MaxScore = max(of Q1-Q10);
   MinScore = min(of Q1-Q10);
datalines;
001 4 1 3 9 1 2 3 5 . 3
002 3 5 4 2 . . . 2 4 .
003 9 8 7 6 5 4 3 2 1 5
;

*Program 11-5 Finding the sum of the three largest values in a 
 list of variables;
data three_large;
   set psych(keep=ID Q1-Q10);
   SumThree = sum(largest(1,of Q1-Q10),
                  largest(2,of Q1-Q10),
                  largest(3,of Q1-Q10));
run;

*Program 11-6 Using the SUM function to compute totals;
data sum;
   set learn.EndOfYear;
   Total = sum(0, of Pay1-Pay12, of Extra1-Extra12);
run;

*Program 11-7 Demonstrating the ABS, SQRT, EXP, and LOG functions;
data math;
   input x @@;
   Absolute = abs(x);
   Square = sqrt(x);
   Exponent = exp(x);
   Natural = log(x);
datalines;
2 -2 10 100
;

*Program 11-8 Computing some useful constants with the CONSTANT function;
data constance;
   Pi = constant('pi');
   e = constant('e');
   Integer3 = constant('exactint',3);
   Integer4 = constant('exactint',4);
   Integer5 = constant('exactint',5);
   Integer6 = constant('exactint',6);
   Integer7 = constant('exactint',7);
   Integer8 = constant('exactint',8);
run;

*Program 11-9 Using the RANUNI function to randomly select observations;
data subset;
   set learn.blood;
   if ranuni(1347564) le .1;
run;

*Program 11-10 Using PROC SURVEYSELECT to obtain a random sample;
proc surveyselect data=learn.blood 
                  out=subset 
                  method=srs
                  sampsize=100;
run;

*Program 11-11 Using the INPUT function to perform a 
 character-to-numeric conversion;
data learn.chars;
   input Height $ Weight $ Date : $10.;
datalines;
58 155 10/21/1950
63 200 5/6/2005
45 79 11/12/2004
;

data nums;
   set learn.chars (rename=
                   (Height = Char_Height
                    Weight = Char_Weight
                    Date   = Char_Date));
   Height = input(Char_Height,8.);
   Weight = input(Char_Weight,8.);
   Date   = input(Char_Date,mmddyy10.);
   drop Char_Height Char_Weight Char_Date;
run;

*Program 11-12 Demonstrating the PUT function;
proc format;
   value agefmt low-<20 = 'Group One'
                20-<40  = 'Group Two'
                40-high = 'Group Three';
run;

data convert;
   set learn.numeric;
   Char_Date = put(Date,date9.);
   AgeGroup = put(Age,agefmt.);
   Char_Cost = put(Cost,dollar10.);
   drop Date Cost;
run;

*Program 11-13 Demonstrating the LAG and LAGn functions;
data look_back;
   input Time Temperature;
   Prev_temp = lag(Temperature);
   Two_back = lag2(Temperature);
datalines;
1 60
2 62
3 65
4 70
;

*Program 11-14 Demonstrating what happens when you execute a
 LAG function conditionally;
data laggard;
   input x @@;
   if X ge 5 then Last_x = lag(x);
datalines;
9 8 7 1 2 12
;

*Program 11-15 Using the LAG function to compute
 inter-observation differences;
data diff;
   input Time Temperature;
   Diff_temp = Temperature - lag(Temperature);
datalines;
1 60
2 62
3 65
4 70
;

*Program 11-16 Demonstrating the DIF function;
data diff;
   input Time Temperature;
   Diff_temp = dif(Temperature);
datalines;
1 60
2 62
3 65
4 70
;

*Program 12-1 Determining the length of a character value;
data long_names;
   set learn.sales;
   if lengthn(Name) gt 12;
run;

*Program 12-2 Changing values to uppercase;
data mixed;
   set learn.mixed;
   Name = upcase(Name);
run;

data both;
   merge mixed
         learn.upper;
   by Name;
run;

*Program 12-3 Converting multiple blanks to a single blank
 and demonstrating the PROPCASE function;
data standard;
   set learn.address;
   Name = compbl(propcase(Name));
   Street = compbl(propcase(Street));
   City = compbl(propcase(City));
   State = upcase(State);
run;

*Program 12-4 Demonstrating the concatenation functions;
title "Demonstrating the Concatenation Functions";

data _null_;
   Length Join Name1-Name4 $ 15;
   First = 'Ron   ';
   Last = 'Cody   ';
   Join = ':' || First || ':';
   Name1 = First || Last;
   Name2 = cat(First,Last);
   Name3 = cats(First,Last);
   Name4 = catx(' ',First,Last);
   file print;
   put Join= /
       Name1= /
       Name2= /
       Name3= /
       Name4= /;
run;

*Program 12-5 Demonstrating the TRIM, LEFT, and STRIP functions;
data blanks;
   String = '   ABC  ';
   ***There are 3 leading and 2 trailing blanks in String;
   JoinLeft = ':' || left(String) || ':';
   JoinTrim = ':' || trim(String) || ':';
   JoinStrip = ':' || strip(String) || ':';
run;

*Program 12-6 Using the COMPRESS function to remove characters
 from a string;
data phone;
   length PhoneNumber $ 10;
   set learn.phone;
   PhoneNumber = compress(Phone,' ()-.');
   drop Phone;
run;

*Program 12-7 Demonstrating the COMPRESS modifiers;
data phone;
   length PhoneNumber $ 10;
   set learn.phone;
   PhoneNumber = compress(Phone,,'kd');
   *Keep only digits;
   drop Phone;
run;

*Program 12-8 Demonstrating the FIND and COMPRESS functions ;
data English;
   set learn.mixed_nuts(rename=
                       (Weight = Char_Weight
                        Height = Char_Height));
   if find(Char_Weight,'lb','i') then
      Weight = input(compress(Char_Weight,,'kd'),8.);
   else if find(Char_Weight,'kg','i') then
      Weight = 2.2*input(compress(Char_Weight,,'kd'),8.);
   if find(Char_Height,'in','i') then
      Height = input(compress(Char_Height,,'kd'),8.);
   else if find(Char_Height,'cm','i') then
      Height = input(compress(Char_Height,,'kd'),8.)/2.54;
   drop Char_:;
run;

*Program 12-9 Demonstrating the FINDW functions;
data look_for_roger;
   input String $40.;
   if indexw(String,'Roger') then Match = 'Yes';
   else Match = 'No';
   *Note: FINDW is available in SAS 9.2 and later;
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
;

*Program 12-10 Demonstrating the ANYDIGIT function;
data only_alpha mixed;
   infile 'c:\books\learning\id.txt' truncover;
   input ID $10.;
   if anydigit(ID) then output mixed;
   else output only_alpha;
run;

*Program 12-11 Demonstrating the "NOT" functions for data cleaning;
title "Data Cleaning Application";
data _null_;
   file print;
   set learn.cleaning;
   if notalpha(trim(Letters))  then put Subject= Letters=;
   if notdigit(trim(Numerals)) then put Subject= Numerals=;
   if notalnum(trim(Both))     then put Subject= Both=;
run;

*Program 12-12 Using the VERIFY function for data cleaning;
data errors valid;
   input ID $  Answer : $5.;
   if verify(Answer,'ABCDE') then output errors;
   else output valid;
datalines;
001 AABDE
002 A5BBD
003 12345
;

*Program 12-13 Using the SUBSTR function to extract substrings;
data extract;
   input ID : $10. @@;
   length State $ 2 Gender $ 1 Last $ 5;
   State = substr(ID,1,2);
   Number = input(substr(ID,3,2),3.);
   Gender = substr(ID,5,1);
   Last = substr(ID,6);
datalines;
NJ12M99 NY76F4512 TX91M5
;

*Program 12-14 Demonstrating the SCAN function;
data original;
   input Name $ 30.;
datalines;
Jeffrey Smith
Ron Cody
Alan Wilson
Alfred E. Newman
;
data first_last;
   set original;
   length First Last $ 15;
   First = scan(Name,1,' ');
   Last = scan(Name,2,' ');
run;

*Program 12-15 Using the SCAN function to extract the last name ;
data last;
   set original;
   length LastName $ 15;
   LastName = scan(Name,-1,' ');
run;
proc sort data=last;
   by LastName;
run;

title "Alphabetical list of names";
proc print data=last noobs;
   var Name;
run;   

*Program 12-16 Demonstrating the COMPARE function;
data diagnosis;
   input Code $10.;
   if compare(Code,'V450','i:') eq 0 then Match = 'Yes';
   else Match = 'No';
datalines;
V450
v450
v450.100
V900
;

*Program 12-17 Clarifying the use of the colon modifier with
 the COMPARE function;
data _null_;
   String1 = 'ABC   ';
   String2 = 'ABCXYZ';
   Compare1 = compare(String1,String2,':');
   Compare2 = compare(trim(String1),String2,':');
   put String1= String2= Compare1= Compare2=;
run;

*Program 12-18 Using the SPEDIS function to perform a fuzzy match;
data fuzzy;
   input Name $20.;
   Value = spedis(Name,'Friedman');
datalines;
Friedman
Freedman
Xriedman
Freidman
Friedmann
Alfred
FRIEDMAN
;

*Program 12-19 Demonstrating the TRANSLATE function;
data trans;
   input Answer : $5.;
      Answer = translate(Answer,'ABCDE','12345');
datalines;
14325
AB123
51492
;

*Program 12-20 Using the TRANWRD function to standardize an address;
data address;
   infile datalines dlm=' ,';
   *Blanks or commas are delimiters;
   input #1 Name $30.
         #2 Line1 $40.
         #3 City & $20. State : $2. Zip : $5.;

   Name = tranwrd(Name,'Mr.',' ');
   Name = tranwrd(Name,'Mrs.',' ');
   Name = tranwrd(Name,'Dr.',' ');
   Name = tranwrd(Name,'Ms.',' ');
   Name = left(Name);

   Line1 = tranwrd(Line1,'Street','St.');
   Line1 = tranwrd(Line1,'Road','Rd.');
   Line1 = tranwrd(Line1,'Avenue','Ave.');
datalines;
Dr. Peter Benchley
123 River Road
Oceanside, NY 11518
Mr. Robert Merrill
878 Ocean Avenue
Long Beach, CA 90818
Mrs. Laura Smith
80 Lazy Brook Road
Flemington, NJ 08822
;

*Program 13-1 Converting values of 999 to a SAS missing 
 value - without using arrays;
data new;
   set learn.SPSS;
   if Height = 999 then Height = .;
   if Weight = 999 then Weight = .;
   if Age    = 999 then Age    = .;
run;

*Program 13-2 Converting values of 999 to a SAS missing value
 - using arrays;
data new;
   set learn.SPSS;
   array myvars{3} Height Weight Age;
   do i = 1 to 3;
      if myvars{i} = 999 then myvars{i} = .;
   end;
   drop i;
run;

*Program 13-3 Rewriting Program 13 2 using the CALL MISSING routine;
data new;
   set learn.SPSS;
   array myvars{3} Height Weight Age;
   do i = 1 to 3;
      if myvars{i} = 999 then call missing(myvars{i});
   end;
   drop i;
run;

*Program 13-4 Converting values of NA and ? to a character missing values;
data learn.chars;
   input A $ B $ x y Ques $;
datalines;
NA ? 3 4 ABC
AAA BBB 8 . ?
NA NA 9 8 NA
; 
data missing;
   set learn.chars;
   array char_vars{*} $ _character_;
   do loop = 1 to dim(char_vars);
      if char_vars{loop} in ('NA' '?') then
      call missing(char_vars{loop});
   end;
   drop loop;
run;

*Program 13-5 Converting all character values in a SAS data
 set to lowercase;
data lower;
   set learn.careless;
   array all_chars{*} _character_;
   do i = 1 to dim(all_chars);
      all_chars{i} = lowcase(all_chars{i});
   end;
   drop i;
run;

*Program 13-6 Using an array to create new variables;
data temp;
   input Fahren1-Fahren24 @@;
   array Fahren[24];
   array Celsius[24] Celsius1-Celsius24;
   do Hour = 1 to 24;
      Celsius{Hour} = (Fahren{Hour} - 32)/1.8;
   end;
   drop Hour;
datalines;
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75
72 66 55 53 52 50 45
;

*Program 13-7 Changing the array bounds;
data account;
   input ID Income1999-Income2006;
   array income{1999:2006} Income1999-Income2006;
   array taxes{1999:2006} Taxes1999-Taxes2006;
   do Year = 1999 to 2006;
      Taxes{Year} = .25*Income{Year};
   end;
   drop Year;
   format Income1999-Income2006 
          Taxes1999-Taxes2006 dollar10.;

datalines;
001 45000 47000 47500 48000 48000 52000 53000 55000
002 67130 68000 72000 70000 65000 52000 49000 40100
;

*Program 13-8 Using a temporary array to score a test;
data score;
   array ans{10} $ 1;
   array key{10} $ 1 _temporary_ 
      ('A','B','C','D','E','E','D','C','B','A');
   input ID (Ans1-Ans10)($1.);
   RawScore = 0;
   do Ques = 1 to 10;
      RawScore + (key{Ques} eq Ans{Ques});
   end;
   Percent = 100*RawScore/10;
   keep ID RawScore Percent;
datalines;
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;

*Program 13-9 Loading the initial values of a temporary array
 from a raw data file;
data score;
   array ans{10} $ 1;
   array key{10} $ 1 _temporary_;
   /* Load the temporary array elements */
   if _n_ = 1 then do Ques = 1 to 10;
      input key{Ques} $1. @;
   end;

   input ID (Ans1-Ans10)($1.);
   RawScore = 0;

   /* Score the test */
   do Ques = 1 to 10;
      RawScore + (key{Ques} eq Ans{Ques});
   end;
   Percent = 100*RawScore/10;
   keep ID RawScore Percent;
datalines;
ABCDEEDCBA
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;

*Program 13-10 Loading a two-dimensional, temporary array with data values;
data look_up;
   /******************************************************
      Create the array, the first index is the year and
      it ranges from 1944 to 1949. The second index is
      the job code (we're using 1-5 to represent job codes
      A through E).
   *******************************************************/
   array level{1944:1949,5} _temporary_;
   /* Populate the array */
   if _n_ = 1 then do Year = 1944 to 1949;
      do Job = 1 to 5;
         input level{Year,Job} @; 
      end;
   end;

   set learn.expose;
   /* Compute the job code index from the JobCode value */
   Job = input(translate(Jobcode,'12345','ABCDE'),1.);
   Benzene = level{Year,Job};
   drop Job;
datalines;
220 180 210 110 90
202 170 208 100 85
150 110 150 60 50
105 56 88 40 30
60 30 40 20 10
45 22 22 10 8
;

*Program 14-1 PROC PRINT using all the defaults;
title "Listing of SALES";
proc print data=learn.sales;
run;

*Program 14-2 Controlling which variables appear in the listing;
title "Listing of SALES";
proc print data=learn.sales;
   var EmpID Customer TotalSales;
run;
   
*Program 14-3 Using an ID statement to omit the Obs column;
title "Listing of SALES";
proc print data=learn.sales;
   id EmpID;
   var Customer TotalSales;
run;

*Program 14-4 Adding a FORMAT statement to PROC PRINT;
proc print data=learn.sales;
   title "Listing of SALES";
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-5 Controlling which observations appear in the listing
 (WHERE statement);
title "Listing of SALES with Quantities greater than 400";
proc print data=learn.sales;
   where Quantity gt 400;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;
 
*Program 14-6 Using the IN operator in a WHERE statement;
title "Listing of SALES with Quantities greater than 400";
proc print data=learn.sales;
   where EmpID in ('1843' '0177');
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-7 Adding titles and footnotes to your listing;
title1 "The XYZ Company";
title3 "Sales Figures for Fiscal 2006";
title4 "Prepared by Roger Rabbit";
title5 "-----------------------------";
footnote "All sales figures are confidential";

proc print data=learn.sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Cancel footnotes;
footnote;

*Program 14-8 Using PROC SORT to change the order of your observations;
proc sort data=learn.sales;
   by TotalSales;
run;

title "Listing of SALES";
proc print data=learn.sales;
   id EmpID;
   var Customer Quantity TotalSales;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-9 Demonstrating the DESCENDING option of PROC SORT;
proc sort data=learn.sales;
   by descending TotalSales;
run;

*Program 14-10 Sorting by more than one variable;
proc sort data=learn.sales out=sales;
   by EmpID descending TotalSales;
run;

title "Sorting by More than One Variable";
proc print data=sales;
   id EmpID;
   var TotalSales Quantity;
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-11 Using labels as column headings with PROC PRINT;
title "Using Labels as Column Headings";
proc print data=sales label;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-12 Using a BY statement in PROC PRINT ;
proc sort data=learn.sales out=sales;
   by Region;
run;

title "Using Labels as Column Headings";
proc print data=sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-13 Adding totals and subtotals to your listing;
proc sort data=learn.sales out=sales;
   by Region;
run;

title "Adding Totals and Subtotals to Your Listing";
proc print data=sales label;
   by Region;
   id EmpID;
   var TotalSales Quantity;
   sum Quantity TotalSales;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-14 Using an ID and BY statement in PROC PRINT;
proc sort data=learn.sales out=sales;
   by EmpID;
run;

title "Using the Same Variable in an ID and BY Statement";
proc print data=sales label;
   by EmpID;
   id EmpID;
   var Customer TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-15 Demonstrating the N option with PROC PRINT;
title "Demonstrating the N option of PROC PRINT";
proc print data=sales n="Total number of Observations:";
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-16 Double spacing your listing;
title "Double Spacing Your Listing";
proc print data=sales double;
   id EmpID;
   var TotalSales Quantity;
   label EmpID = "Employee ID"
         TotalSales = "Total Sales"
         Quantity = "Number Sold";
   format TotalSales dollar10.2 Quantity comma7.;
run;

*Program 14-17 Listing the first 5 observations of your data set;
title "First 5 Observations from SALES";
proc print data=learn.sales(obs=5);
run;

*Program 14-18 Forcing variable labels to print horizontally;
title "First 5 Observations from SALES";
proc print data=learn.sales(obs=5) heading=horizontal;
run;

*Program 15-1 Listing of MEDICAL using PROC PRINT;
title "Listing of Data Set MEDICAL from PROC PRINT";
proc print data=learn.medical;
   id Patno;
run;

*Program 15-2 Using PROC REPORT (all defaults);
title "Using the PROC REPORT";
proc report data=learn.medical nowd;
run;

*Program 15-3 Adding a COLUMN statement to PROC REPORT;
title "Adding a COLUMN Statement";
proc report data=learn.medical nowd;
   column Patno DX HR Weight;
run;

*Program 15-4 Using PROC REPORT with only numeric variables;
title "Report with Only Numeric Variables";
proc report data=learn.medical nowd;
   column HR Weight;
run;

*Program 15-5 Using DEFINE statements to define a display usage;
title "Display Usage for Numeric Variables";
proc report data=learn.medical nowd;
   column HR Weight;
   define HR / display "Heart Rate" width=5; 
   define Weight / display width=6;
run;

*Program 15-6 Specifying a GROUP usage to create a summary report;
title "Demonstrating a GROUP Usage";
proc report data=learn.medical nowd;
   column Clinic HR Weight;
   define Clinic / group width=11;
   define HR / analysis mean "Average Heart Rate" width=12 
               format=5.; 
   define Weight / analysis mean "Average Weight" width=12 
                   format=6.;
run;

*Program 15-7 Demonstrating the FLOW option with PROC REPORT;
title "Demonstrating the FLOW Option";
proc report data=learn.medical nowd headline 
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / "Patient Number" width=7;
   define VisitDate / "Visit Date" width=9 format=date9.;
   define DX        / "DX Code" width=4 right;
   define HR        / "Heart Rate" width=6;
   define Weight    / width=6;
   define Comment   / width=30 flow;
run;

*Program 15-8 Explicitly defining usage for every variable;
title "Demonstrating the FLOW Option";
proc report data=learn.medical nowd headline 
            split=' ' ls=74;
   column Patno VisitDate DX HR Weight Comment;
   define Patno     / display "Patient Number" width=7;
   define VisitDate / display "Visit Date" width=9
                      format=date9.;
   define DX        / display "DX Code" width=4 right;
   define HR        / display "Heart Rate" width=6;
   define Weight    / display width=6;
   define Comment   / display width=30 flow;
run;

*Program 15-9 Demonstrating the effect of two variables with GROUP usage;
title "Multiple GROUP Usages";
proc report data=learn.bicycles nowd headline ls=80;
   column Country Model Units TotalSales;
   define Country  / group width=14;
   define Model    / group width=13;
   define Units    / sum "Number of Units" width=8 
                     format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)" 
                       width=15 format=dollar10.;
run;

*Program 15-10 Reversing the order of variables in the COLUMN statement;
title "Multiple GROUP Usages";
proc report data=learn.bicycles nowd headline ls=80;
   column Model Country Manuf Units TotalSales;
   define Country  / group width=14;
   define Model    / group width=13;
   define Manuf    / width=12;
   define Units    / sum "Number of Units" width=8 
                     format=comma8.;
   define TotalSales / sum "Total Sales (in thousands)" 
                       width=15 format=dollar10.;
run;

*Program 15-11 Demonstrating the ORDER usage of PROC REPORT;
title "Listing from SALES in EmpID Order";
proc report data=learn.sales nowd headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define Quantity / width=8 format=comma8.;
   define TotalSales / "Total Sales" width=9 
                       format=dollar9.;
run;

*Program 15-12 Applying the ORDER usage for two variables;
title "Applying the ORDER Usage for Two Variables";
proc report data=learn.sales nowd headline;
   column EmpID Quantity TotalSales;
   define EmpID / order "Employee ID" width=11;
   define TotalSales / descending order "Total Sales" 
                       width=9 format=dollar9.;
   define Quantity / width=8 format=comma8.;
run;

*Program 15-13 Creating a multi-column report;
title "Random Assignment - Three Groups";
proc report data=learn.assign nowd panels=99 
            headline ps=16;
   columns Subject Group;
   define Subject / display width=7;
   define Group / width=5;
run;

*Program 15-14 Requesting a report break (RBREAK statement);
title "Producing Report Breaks";
proc report data=learn.sales nowd headline;
   column Region Quantity TotalSales;
   define Region / width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9 
                       format=dollar9.;
   rbreak after / dol dul summarize;
run;

*Program 15-15 Demonstrating the BREAK statement of PROC REPORT;
title "Producing Report Breaks";
proc report data=learn.sales nowd headline;
   column Region Quantity TotalSales;
   define Region / order width=6;
   define Quantity / sum width=8 format=comma8.;
   define TotalSales / sum "Total Sales" width=9 
                       format=dollar9.;
   break after region / ol summarize skip; 
run;

*Program 15-16 Using a non-printing variable to order the rows of a report;
data temp;
   set learn.sales;
   length LastName $ 10;
   LastName = scan(Name,-1,' ');
run;

title "Listing Ordered by Last Name";
proc report data=temp nowd headline;
   column LastName Name EmpID TotalSales;
   define LastName / group noprint;
   define Name / group width=15;
   define EmpID / "Employee ID" group width=11;
   define TotalSales / sum "Total Sales" width=9 
                       format=dollar9.;
run;

*Program 15-17 Computing a new variable with PROC REPORT;
title "Computing a New Variable";
proc report data=learn.medical nowd;
   column Patno Weight WtKg;
   define Patno / display "Patient Number" width=7;
   define Weight / display noprint width=6;
   define WtKg / computed "Weight in Kg" 
                 width=6 format=6.1;
   compute WtKg;
      WtKg = Weight / 2.2;
   endcomp;
run;

*Program block on page 309;
title "Creating a Character Variable in a COMPUTE Block";
proc report data=learn.medical nowd;
   column Patno HR Weight Rate;
   define Patno / display "Patient Number" width=7;
   define HR / display "Heart Rate" width=5;
   define Weight / display noprint width=6;
   define Rate / computed width=6;
   Compute Rate / character length=6;
      if HR gt 75 then Rate = 'Fast';
     else if HR gt 55 then Rate = 'Normal';
     else if not missing(HR) then Rate = 'Slow';
   endcomp;
run;


*Program 15-18 Demonstrating an ACROSS usage in PROC REPORT;
***Demonstrating an Across Usage;
title "Demonstrating an ACROSS Usage";
proc report data=learn.bicycles nowd headline ls=80;
   column Model,Units Country;
   define Country    / group width=14;
   define Model      / across "Model";
   define Units      / sum "# of Units" width=14
                       format=comma8.;
run;

*Program on page 312;
title "Averate Blood Counts by Age Group";
proc report data=learn.blood nowd headline;
   column Gender BloodType AgeGroup,WBC AgeGroup,RBC;
   define Gender    / group width=8;
   define BloodType / group width=8 "Blood Group";
   define AgeGroup  / across "- Age Group -";
   define WBC       / analysis mean format=comma8.;
   define RBC       / analysis mean format=8.2;
run;

*Program 16-1 PROC MEANS with all the defaults;
title "PROC MEANS With All the Defaults";
proc means data=learn.blood;
run;

*Program 16-2 Adding a VAR statement and requesting specific
 statistics with PROC MEANS;
title "Selected Statistics Using PROC MEANS";
proc means data=learn.blood n nmiss mean median 
                            min max maxdec=1;
   var RBC WBC;
run;

*Program 16-3 Adding a BY statement to PROC MEANS;
proc sort data=learn.blood out=blood;
   by Gender;
run;

title "Adding a BY Statement to PROC MEANS";
proc means data=blood n nmiss mean median 
                            min max maxdec=1;
   by Gender;
   var RBC WBC;
run;

*Program 16-4 Using a CLASS statement with PROC MEANS;
title "Using a CLASS Statement with PROC MEANS";
proc means data=learn.blood n nmiss mean median 
                            min max maxdec=1;
   class Gender;
   var RBC WBC;
run;

*Program 16-5 Demonstrating the effect of a formatted CLASS variable;
proc format;
   value chol_group
     low -< 200 = 'Low'
     200 - high = 'High';
run;

proc means data=learn.blood n nmiss mean median 
           maxdec=1;
   title "Using a CLASS Statement with PROC MEANS";
   class Chol;
   format Chol chol_group.;
   var RBC WBC;
run;

*Program 16-6 Creating a summary data set using PROC MEANS;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = my_summary 
          mean = MeanRBC MeanWBC;
run;

title "Listing of MY_SUMMARY";
proc print data=my_summary noobs;
run;

*Program 16-7 Outputting more than one statistics with PROC MEANS;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = many_stats 
          mean     = M_RBC M_WBC
          n        = N_RBC N_WBC
          nmiss    = Miss_RBC Miss_WBC
          median   = Med_RBC Med_WBC;
run;

*Program 16-8 Demonstrating the OUTPUT option AUTONAME;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out = many_stats 
          mean     =
          n        =
          nmiss    =
          median   = / autoname;
run;

*Program 16-9 Adding a BY statement to PROC MEANS;
proc sort data=learn.blood out=blood;
   by Gender;
run;

proc means data=blood noprint;
   by Gender;
   var RBC WBC;
   output out = by_gender 
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

*Program 16-10 Adding a CLASS statement to PROC MEANS;
proc means data=blood noprint;
   class Gender;
   var RBC WBC;
   output out = with_class 
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

*Program 16-11 Adding the NWAY option to PROC MEANS;
proc means data=blood noprint nway;
   class Gender;
   var RBC WBC;
   output out = with_class 
          mean = MeanRBC MeanWBC
          n    = N_RBC N_WBC;
run;

*Program 16-12 Using two CLASS variables with PROC MEANS;
proc means data=learn.blood noprint;
   class Gender AgeGroup;
   var RBC WBC;
   output out = summary 
          mean =
          n = / autoname;
run;

*Program 16-13 Adding the CHARTYPE procedure option to PROC MEANS;
proc means data=learn.blood noprint chartype;
   class Gender AgeGroup;
   var RBC WBC;
   output out = summary 
          mean =
          n = / autoname;
run;

*Program 16-14 Using the _TYPE_ variable to select cell means;
title "Statistics Broken Down by Gender";
proc print data=summary(drop = _freq_) noobs;
   where _TYPE_ = '10';
run;

*Program 16-15 Using a DATA step to create separate summary data sets;
data grand(drop = Gender AgeGroup) 
     by_gender(drop = AgeGroup)
     by_age(drop = Gender)
     cellmeans;
   set summary;
   drop _type_;
   rename _freq_ = Number;
   if _type_ = '00' then output grand;
   else if _type_ = '01' then output by_age;
   else if _type_ = '10' then output by_gender;
   else if _type_ = '11' then output cellmeans;
run;

*Program 16-16 Selecting different statistics for each variable
 using PROC MEANS;
proc means data=learn.blood noprint nway;
   class Gender AgeGroup;
   output out = summary(drop = _:) 
          mean(RBC WBC) = 
          n(RBC WBC Chol) = 
          median(Chol) = / autoname;
run;

*Program 17-1 Counting frequencies: one-way tables using PROC FREQ;
title "PROC FREQ with all the Defaults";
proc freq data=learn.survey;
run;

*Program 17-2 Adding a TABLES statement to PROC FREQ;
title "Adding a TABLES Statement";
proc freq data=learn.survey;
   tables Gender Ques1-Ques3 / nocum;
run;

*Program 17-3 Adding formats to Program 17 2;
proc format;
   value $gender 
      'F' = 'Female'
      'M' = 'Male';
   value $likert 
      '1' = 'Strongly disagree'
      '2' = 'Disagree'
      '3' = 'No opinion'
      '4' = 'Agree'
      '5' = 'Strongly agree';
run;

title "Adding Formats";
proc freq data=learn.survey;
   tables Gender Ques1-Ques3 / nocum;
   format Gender $gender.
          Ques1-Ques3 $likert.;
run;

*Program 17-4 Using formats to group values;
proc format;
   value agegroup
      low-<30  = 'Less than 30'
      30-<60   = '30 to 59'
      60-high  = '60 and higher';
   value $agree_disagree
      '1','2' = 'Generally disagree'
      '3'     = 'No opinion'
      '4','5' = 'Generally agree';
run;

title "Using Formats to Create Groups";
proc freq data=learn.survey;
   tables Age Ques5 / nocum nopercent;
   format Age agegroup.
          Ques5 $agree_disagree.;
run;

*Program 17-5 Demonstrating a problem in how PROC FREQ groups values;
proc format;
   value two 
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      other = 'Other values';
run;

title "Grouping Values (First Try)";
proc freq data=learn.grouping;
   tables X / nocum nopercent;
   format X two.;
run;

*Program 17-6 Fixing the grouping problem;
proc format;
   value two 
      low-3 = 'Group 1'
      4-5   = 'Group 2'
      .     = 'Missing'
      other = 'Other values';
run;

*Program 17-7 Demonstrating the effect of the MISSING option of PROC FREQ;
title "PROC FREQ Using the MISSING Option";
proc freq data=learn.grouping;
   tables X / missing;
   format X two.;
run;

title "PROC FREQ Without the MISSING Option";
proc freq data=learn.grouping;
   format X two.;
   tables X;
run;

*Program 17-8 Demonstrating the ORDER= option of PROC FREQ;
proc format;
   value darwin 
      1 = 'Yellow'
      2 = 'Blue'
      3 = 'Red'
      4 = 'Green'
      . = 'Missing';
run;

data test;
   input Color @@;
datalines;
3 4 1 2 3 3 3 1 2 2
;

title "Default Order (Internal)";
proc freq data=test;
   tables Color / nocum nopercent missing;
   format Color darwin.;
run;

*Program 17-9 Demonstrating the ORDER= formatted, data, and freq options;
title "ORDER = formatted";
proc freq data=test order=formatted;
   tables Color / nocum nopercent;
   format Color darwin.;
run;

title "ORDER = data";
proc freq data=test order=data;
   tables Color / nocum nopercent;
   format Color darwin.;
run;

title "ORDER = freq";
proc freq data=test order=freq;
   tables Color / nocum nopercent;
   format Color darwin.;
run;

*Program 17-10 Requesting a two-way table;
title "A Two-way Table of Gender by Blood Type";
proc freq data=learn.blood;
   tables Gender * BloodType;
run;

*Program 17-11 Requesting a three-way table with PROC FREQ;
title "Example of a Three-way Table";
proc freq data=learn.blood;
   tables Gender * AgeGroup * BloodType / 
          nocol norow nopercent;
run;

*Program 18-1 PROC TABULATE with all the defaults and a single
 CLASS variable;
title "All Defaults with One CLASS Variable";
proc tabulate data=learn.blood;
   class Gender;
   table Gender;
run;

*Program 18-2 Demonstrating concatenation with PROC TABULATE;
title "Demonstrating Concatenation";
proc tabulate data=learn.blood format=6.;
   class Gender BloodType;
   table Gender BloodType;
run;

*Program 18-3 Demonstrating table dimensions with PROC TABULATE;
title "Demonstrating Table Dimensions";
proc tabulate data=learn.blood format=6.;
   class Gender BloodType;
   table Gender,
         BloodType;
run;

*Program 18-4 Demonstrating the nesting operator with PROC TABULATE;
title "Demonstrating Nesting";
proc tabulate data=learn.blood format=6.;
   class Gender BloodType;
   table Gender * BloodType;
run;

*Program 18-5 Adding the keyword ALL to your table request;
title "Adding the Keyword ALL to the TABLE Request";
proc tabulate data=learn.blood format=6.;
   class Gender BloodType;
   table Gender ALL,
         BloodType ALL;
run;

*Program 18-6 Using PROC TABULATE to produce descriptive statistics;
title "Demonstrating Analysis Variables";
proc tabulate data=learn.blood;
   var RBC WBC;
   table RBC WBC;
run;

*Program 18-7 Specifying statistics on analysis variable
 with PROC TABULATE;
title "Specifying Statistics";
proc tabulate data=learn.blood;
   var RBC WBC;
   table RBC*mean WBC*mean;
run;

*Program 18-8 Specifying more than one descriptive statistic
 with PROC TABULATE;
title "Specifying More than One Statistic";
proc tabulate data=learn.blood format=comma9.2;
   var RBC WBC;
   table (RBC WBC)*(mean min max);
run;

*Program 18-9 Combining categorical and analysis variables in a table;
title "Combining Categorical and Analysis Variables";
proc tabulate data=learn.blood format=comma11.2;
   class Gender AgeGroup;
   var RBC WBC Chol;
   table (Gender ALL)*(AgeGroup All),
          (RBC WBC Chol)*mean;
run;

*Program 18-10 Associating a different format with each variable in a table;
title "Specifying Formats";
proc tabulate data=learn.blood;
   var RBC WBC;
   table RBC*mean*f=7.2 WBC*mean*f=comma7.;
run;

*Program 18-11 Renaming keywords with PROC TABULATE;
title "Specifying Formats and Renaming Keywords";
proc tabulate data=learn.blood;
   class Gender;
   var RBC WBC;
   table Gender ALL,
         RBC*(mean*f=9.1 std*f=9.2)
         WBC*(mean*f=comma9. std*f=comma9.1);
   keylabel ALL  = 'Total'
            mean = 'Average'
            std  = 'Standard Deviation';
run;

*Program 18-12 Eliminating the 'N' column in a PROC TABULATE table;
title "Eliminating the 'N' Row from the Table";
proc tabulate data=learn.blood format=6.;
   class Gender;
   table Gender*n=' ';
run;

*Program 18-13 Demonstrating a more complex table;
title "Combining Categorical and Analysis Variables";
proc tabulate data=learn.blood format=comma9.2 noseps;
   class Gender AgeGroup;
   var RBC WBC Chol;
   table (Gender=' ' ALL)*(AgeGroup=' ' All),
          RBC*(n*f=3. mean*f=5.1)
          WBC*(n*f=3. mean*f=comma7.)
          Chol*(n*f=4. mean*f=7.1);
   keylabel ALL = 'Total';
run;

*Program 18-14 Computing percentages in a one-dimensional table;
title "Counts and Percentages";
proc tabulate data=learn.blood format=6.;
   class BloodType;
   table BloodType*(n pctn);
run;

*Program 18-15 Improving the appearance of output from Program 18 14.;
proc format;
   picture pctfmt low-high='009.9%';
run;

title "Counts and Percentages";
proc tabulate data=learn.blood;
   class BloodType;
   table (BloodType ALL)*(n*f=5. pctn*f=pctfmt7.1);
   keylabel n    = 'Count'
            pctn = 'Percent';
run;

*Program 18-16 Counts and percentages in a two-dimensional table;
proc format;
   picture pctfmt low-high='009.9%';
run;

title "Counts and Percentages";
proc tabulate data=learn.blood noseps;
   class Gender BloodType;
   table (BloodType ALL),
         (Gender ALL)*(n*f=5. pctn*f=pctfmt7.1) /RTS=25;
   keylabel ALL  = 'Both Genders'
            n    = 'Count'
            pctn = 'Percent';
run;

*Program 18-17 Using COLPCTN to compute column percentages;
title "Percents on Column Dimension";
proc tabulate data=learn.blood noseps;
   class Gender BloodType;
   table (BloodType ALL='All Blood Types'),
         (Gender ALL)*(n*f=5. colpctn*f=pctfmt7.1) /RTS=25;
   keylabel All     = 'Both Genders'
            n       = 'Count'
            colpctn = 'Percent';
run;

*Program 18-18 Computing percentages on a numerical value;
title "Computing Percentages on a Numerical Value";
proc tabulate data=learn.sales;
   class Region;
   var TotalSales;
   table (Region ALL),
          TotalSales*(n*f=6. sum*f=dollar8. 
                      pctsum*f=pctfmt7.);
         
   keylabel ALL     = 'All Regions'
            n       = 'Number of Sales'
            sum     = 'Average'
            pctsum  = 'Percent';
   label TotalSales = 'Total Sales';
run;

*Program 18-19 Demonstrating the effect of missing values
 on CLASS variables;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=learn.missing format=4.;
   class A B;
   table A ALL,B ALL;
run;

*Program 18-20 Missing values on a CLASS variable that is
 not used in the table;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=learn.missing format=4.;
   class A B C;
   table A ALL,B ALL;
run;

*Program 18-21 Adding the PROC TABULATE procedure option MISSING;
title "The Effect of Missing Values on CLASS variables";
proc tabulate data=learn.missing format=4. missing;
   class A B;
   table A ALL,B ALL;
run;

*Program 18-22 Demonstrating the MISSTEXT= TABLES option;
title "Demonstrating the MISSTEXT TABLES Option";
proc tabulate data=learn.missing format=7. missing;
   class A B;
   table A ALL,B ALL / misstext='no data';
run;

*Program 19-1 Sending SAS output to an HTML file;
ods html file='c:\books\learning\sample.html';

title "Listing of TEST_SCORES";
proc print data=learn.test_scores;
   title2 "Sample of HTML Output - all defaults";
   id ID;
   var Name Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=learn.test_scores n mean min max;
   var Score1-Score3;
run;

ods html close;

*Program 19-2 Creating a table of contents for HTML output;
ods html body = 'body_sample.html' 
        contents = 'contents_sample.html'
        frame = 'frame_sample.html'
        path = 'c:\books\learning' (url=none);
title "Using ODS to Create a Table of Contents";
proc print data=learn.test_scores;
   id ID;
   var Name Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=learn.test_scores n mean min max;
   var Score1-Score3;
run;
ods html close;

*Program 19-3 Choosing a style for HTML output;
ods html file = 'c:\books\learning\styles.html' 
                style=FancyPrinter;
title "Listing of TEST_SCORES";
proc print data=learn.test_scores;
   id ID;
   var Name Score1-Score3;
run;
ods html close;

*Program 19-4 Using an ODS SELECT statement to restrict
 PROC UNIVARIATE output;
ods select extremeobs;
title "Extreme Values of RBC";
proc Univariate data=learn.blood;
   id Subject;
   var RBC;
run;

*Program 19-5 Using the ODS TRACE statement to identify output objects;
ods trace on;
title "Extreme Values of RBC";
proc Univariate data=learn.blood;
   id Subject;
   var RBC;
run;
ods trace off;

*Program 19-6 Using ODS to send procedure output to a SAS data set;
ods listing close;
ods output ttests=t_test_data;

proc ttest data=learn.blood;
   class Gender;
   var RBC WBC Chol;
run;

ods listing;
title "Listing of T_TEST_DATA";
proc print data=t_test_data;
run;

*Program 19-7 Using an output data set to create a simplified report;
title "T-Test Results - Using Equal Variance Method";
proc report data=t_test_data nowd headline;
   where Variances = "Equal";
   columns Variable tValue ProbT;
   define Variable / width=8;
   define tValue / "T-Value" width=7 format=7.2;
   define ProbT / "P-Value" width=7 format=7.5;
run;

*Program 20-1 Producing a simple bar chart using PROC GCHART;
title "Distribution of Blood Types";
pattern value=empty;

proc gchart data=learn.blood;
   vbar BloodType;
run;
quit;

*Program 20-2 Creating a simple Pie Chart;
title "Creating a Pie Chart";
pattern value=pempty;
proc gchart data=learn.blood;
   pie BloodType / noheading;
run;
quit;

*Program 20-3 Creating a bar chart for a continuous variable;
pattern value=empty;
proc gchart data=learn.blood;
   vbar WBC;
run;

*Program 20-4 Selecting your own midpoints for the chart;
pattern value=L2;
title "Distribution of WBC's";
proc gchart data=learn.blood;
   vbar WBC / midpoints=4000 to 11000 by 1000;
   format WBC comma6.;
run;

*Program 20-5 Demonstrating the need for the DISCRETE
 option of PROC GCHART;
data day_of_week;
   set learn.hosp;
   Day = weekday(AdmitDate);
run;

title "Visits by Day of Week";
pattern value=R1;
proc gchart data=day_of_week;
   vbar Day;
run;

*Program 20-6 Demonstrating the DISCRETE option of PROC GCHART;
title "Visits by Month of the Year";
pattern value=R1;
proc gchart data=day_of_week;
   vbar Day / discrete;
run;

*Program 20-7 Creating a bar chart where the height of the
 bars represents sums;
title "Total Sales by Region";
pattern1 value=L1;
axis1 order=('North' 'South' 'East' 'West');
proc gchart data=learn.sales;
   vbar Region / sumvar=TotalSales 
                 type=sum
                 maxis=axis1;
   format TotalSales dollar8.;
run;
quit;

*Program 20-8 Creating a bar chart where the height of the
 bars represent means;
title "Average Cholesterol by Gender";
pattern1 value=L1;
proc gchart data=learn.blood;
   vbar Gender / sumvar=Chol 
                 type=mean;
run;
quit;

*Program 20-9 Adding another variable to the chart;
title "Average Cholesterol by Gender";
pattern1 value=L1;
proc gchart data=learn.blood;
   vbar Gender / sumvar=Chol 
                 type=mean
                 group=BloodType;
run;
quit;

*Program 20-10 Demonstrating the SUBGROUP option;
title "Average Cholesterol by Gender";
pattern1 value=L1;
pattern2 value=R3;
proc gchart data=learn.blood;
   vbar BloodType / subgroup=Gender;
run;
quit;

*Program 20-11 Creating a simple scatter plot using all the defaults;
title "Scatter Plot of SBP by DBP";
proc gplot data=learn.clinic;
   plot SBP * DBP;
run;

*Program 20-12 Changing the plotting symbol and controlling
 the axis ranges;
title "Scatter Plot of SBP by DBP";
symbol value=dot;
proc gplot data=learn.clinic;
   plot SBP * DBP / haxis=70 to 120 by 5
                    vaxis=100 to 220 by 10;
run;

*Program 20-13 Joining the points with straight lines (first attempt);
title "Scatter Plot of SBP by DBP";
title2 h=1.2 "Interpolation Methods";
symbol value=dot interpol=join width=2;
proc gplot data=learn.clinic;
   plot SBP * DBP;
run;

*Program 20-14 Using the JOIN option on a sorted data set;
proc sort data=learn.clinic out=clinic;
   by DBP;
run;

title "Scatter Plot of SBP by DBP";
title2 h=1.2 "Interpolation Methods";
symbol value=dot interpol=join width=2;
proc gplot data=clinic;
   plot SBP * DBP;
run;

*Program 20-15 Drawing a smooth line through your data points;
title "Scatter Plot of SBP by DBP";
title2 h=1.2 "Interprelation Methods";
symbol value=dot interpol=sms line=1 width=2;
proc gplot data=learn.clinic;
   plot SBP * DBP;
run;

*Program 21-1 Missing values at the end of a line with list input;
data missing;
   infile 'c:\books\learning\missing.txt';
   input x y z;
run;

*Program 21-2 Reading a raw data file with short records;
data short;
   infile 'c:\books\learning\short.txt';
   input Subject  $ 1-3
         Name     $ 4-19
         Quiz1      20-22
         Quiz2      23-25
         Quiz3      26-28;
run;

*Program 21-3 Demonstrating the INFILE PAD option;
data short;
   infile 'c:\books\learning\short.txt' pad;
   input Subject  $ 1-3
         Name     $ 4-19
         Quiz1      20-22
         Quiz2      23-25
         Quiz3      26-28;
run;

*Program 21-4 Demonstrating the END= option on the INFILE statement;
data _null_;
   file print;
   infile 'c:\books\learning\month.txt' end=Last;
   input @1 Month $3.
         @5 MonthTotal 4.;
   YearTotal + MonthTotal;
   if last then 
      put "Total for the year is" YearTotal dollar8.;
run;

*Program 21-5 Demonstrating the OBS= INFILE option to read
 the first 3 lines of data;
data readthree;
   infile 'c:\books\learning\month.txt' obs=3;
   input @1 Month $3.
         @5 MonthTotal 4.;
run;

*Program 21-6 Using the OBS= and FIRSTOBS= INFILE options together;
data read5to7;
   infile 'c:\books\learning\month.txt' firstobs=5 obs=7;
   input @1 Month $3.
         @5 MonthTotal 4.;
run;

*Program 21-7 Using the END= option to read data from multiple files;
/*********************************************************
 Note: Not a complete program

data combined;
   if finished = 0 then infile 'alpha.txt' end=finished;
   else infile 'beta.txt';
   input . . .;
   . . .
run;
***********************************************************/

*Program 21-8 Reading external file names from an external file;
/*********************************************************
 Note: Not a complete program
data readmany;
   infile 'c:\books\learning\filenames.txt';
   input ExternalNames $ 40.;
   infile dummy filevar=ExternalNames end=Last;
   do until (last);
      input . . .;
      output;
   end;
run;
***********************************************************/

*Program 21-9 Reading external file names using a DATALINES statement;
/*********************************************************
 Note: Not a complete program

data readmany;
   input ExternalNames $ 40.;
   infile dummy filevar=ExternalNames end=Last;
   do until (last);
      input . . .;
      output;
   end;
datalines;
c:\books\learning\data1.txt
c:\books\learning\moredata.txt
c:\books\learning\fred.txt
;
***********************************************************/

*Program 21-10 Reading multiple lines of data to create one observation;
data health;
   infile 'c:\books\learning\health.txt' pad;
   input #1 @1  Subj      $3.
            @4  DOB mmddyy10.
            @14 Weight     3.
         #2 @4  HR         3.
            @7  SBP        3.
            @10 DBP        3.;
   format DOB mmddyy10.;
run;

*Program 21-11 Using an alternate method of reading multiple
 lines of data to form one SAS observation;
data health;
   infile 'c:\books\learning\health.txt' pad;
   input  @1  Subj      $3.
          @4  DOB mmddyy10.
          @14 Weight     3. /
          @4  HR         3.
          @7  SBP        3.
          @10 DBP        3.;
   format DOB mmddyy10.;
run;

*Program 21-12 Incorrect attempt to read file of mixed record types;
data survey;
   infile 'c:\books\learning\survey56.txt' pad;
   input @9 year $4.;
   if year = '2005' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q3
            @7 Q4;
   else if year = '2006' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q2B
            @7 Q3
            @8 Q4;
run;

*Program 21-13 Using a trailing @ to read a file with mixed record types;
data survey;
   infile 'c:\books\learning\survey56.txt' pad;
   input @9 Year $4. @;
   if Year = '2005' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q3
            @7 Q4;
   else if Year = '2006' then
      input @1 Number
            @4 Q1
            @5 Q2
            @6 Q2B
            @7 Q3
            @8 Q4;
run;

*Program 21-14 Another example of a trailing @ sign;
data females;
   infile 'c:\books\learning\bank.txt' pad;
   input @14 Gender $1. @;
   if Gender ne 'F' then delete;
   input @1  Subj         $3.
         @4  DOB    mmddyy10.
         @15 Balance       7.;
run;

*Program 21-15 Creating one observation from one line of data;
data pairs;
   input X Y;
datalines;
1 2
3 4
5 7
8 9
11 14
13 18
21 27
30 40
;

*Program 21-16 Creating several observations from one line of data;
data pairs;
   input X Y @@;
datalines;
1 2  3 4  5 7  8 9  11 14  13 18  21 27
30 40
;

*Program 22-1 Using a format to recode a variable;
proc format;
   value agefmt  0 - <20  = '< 20'
                20 - <40  = '20 to 39'
                40 - <60  = '40 to 59'
                60 - high = '60+';
run;

title "Using a Format to Recode a Variable";
proc freq data=learn.survey;
   tables Age / nocum nopercent;
   format Age agefmt.;
run;

*Program 22-2 Using a format and a PUT function to create a new variable;
proc format;
   value agefmt  0 - <20  = '< 20'
                20 - <40  = '20 to 39'
                40 - <60  = '40 to 59'
                60 - high = '60+';
run;

data survey;
   set learn.survey;
   AgeGroup = put(Age,agefmt.);
run;

*Program 22-3 Demonstrating a user-written INFORMAT;
proc format;
   invalue convert 'A+' = 100
                    'A'  = 96     
                    'A-' = 92
                    'B+' = 88
                    'B'  = 84
                    'B-' = 80
                    'C+' = 76
                    'C'  = 72
                    'F'  = 65;
run;

data grades;
   input @1 ID          $3.
         @4 Grade convert2.;
datalines;
001A-
002B+
003F
004C+
005A
;

*Program 22-4 Demonstrating INFORMAT options UPCASE and JUST;
proc format;
   invalue convert(upcase just)
           'A+' = 100
           'A'  = 96     
           'A-' = 92
           'B+' = 88
           'B'  = 84
           'B-' = 80
           'C+' = 76
           'C'  = 72
           'F'  = 65
         other  =  .;
run;

data grades;
   input @1 ID          $3.
         @4 Grade convert2.;
datalines;
001A-
002b+
003F
004c+
005 A
006X
;

title "Listing of GRADES";
proc print data=grades noobs;
run;

*Program 22-5 A traditional approach to reading a combination
 of character and numeric data;
data temperatures;
   input Dummy $ @@;
   if upcase(Dummy) = 'N' then Temp = 98.6;
   else Temp = input(Dummy,8.);
   drop dummy;
datalines;
101 N 97.3 n N 104.5
;

*Program 22-6 Using an enhanced numeric informat to read 
 a combination of character and numeric data;
proc format;
   invalue readtemp(upcase)
                96 - 106 = _same_
                'N'      = 98.6
                other    = .;
run;
data temperatures;
   input Temp : readtemp5. @@;
datalines;
101 N 97.3 n N 67 104.5
;

*Program 22-7 Another example of an enhanced numeric informat;
proc format;
   invalue readgrade(upcase)
      'A' = 95
      'B' = 85
      'C' = 75
      'F' = 65
      other = _same_;
run;

data school;
   input Grade : readgrade3. @@;
datalines;
97 99 A C 72 f b
;

*Program 22-8 Using formats and informats to perform a table look-up;
proc format;
   value namelookup
     122 = 'Salt'
     188 = 'Sugar'
     101 = 'Cereal'
     755 = 'Eggs'
   other = ' ';
   invalue pricelookup
     'Salt'   = 3.76
     'Sugar'  = 4.99
     'Cereal' = 5.97
     'Eggs'   = 2.65
      other   = .;
run;

data grocery;
   input ItemNumber @@;
   Name = put(ItemNumber,namelookup.);
   Price = input(Name,pricelookup.);
datalines;
101 755 122 188 999 755
;

*Program 22-9 Creating a test data set that will be used
 to make a CNTLIN data set;
data learn.codes;
   input ICD9 : $5. Description & $21.;
datalines;
020 Plague
022 Anthrax
390 Rheumatic fever
410 Myocardial infarction
493 Asthma
540 Appendicitis
;

*Program 22-10 Creating a CNTLIN data set from an existing SAS data set;
data control;
   set learn.codes(rename=
                   (ICD9 = Start
                    Description = Label));
   retain Fmtname '$ICDFMT'
          Type 'C';
run;

title "Demonstrating a Input Control Data Set";
options ls=80;
proc format cntlin=control fmtlib;
run;

*Program 22-11 Using the CNTLIN= created data set;
data disease;
   input ICD9 : $5. @@;
datalines;
020 410 500 493
;
title "Listing of DISEASE";
proc print data=disease noobs;
   format ICD9 $ICDFMT.;
run;

*Program 22-12 Adding an OTHER category to your format;
data control / view=control;
   set learn.codes(rename=
                   (ICD9 = Start
                   Description = Label))
                   end = last;
   retain Fmtname '$ICDFMT'
          Type 'C';
   output;
   if last then do;
      Start = ' ';
      Hlo = 'o';
      Label = 'Not Found';
      output;
   end;
run;

title "Listing of CONTROL";
proc print data=control;
run;

*Program 22-13 Updating an existing format using a CNTLOUT data set;
proc format cntlout=control_out;
   select $ICDFMT;
run;

data new_control;
   length Label $ 21;
   set control_out end=Last;
   output;
   if Last then do;
      Hlo = ' ';
      Start = '427.5';
      End = Start;
      Label = 'Cardiac Arrest';
      output;
      Start = '466';
      End = Start;
      Label = 'Bronchitis';
      output;
   end;
run;

proc format cntlin=new_control;
   select $ICDFMT;
run;

*Program 22-14 Demonstrating nested formats;
proc format;
   value registration low - <'15Jul2005'd = 'Not Open'
              '15Jul2005'd - '31Dec2006'd = [mmddyy10.]
              '01Jan2007'd - high         = 'Too Late';
run;

*Program 22-15 Using the nested format in a DATA step;
data conference;
   input @1  Name $10.
         @11 Date mmddyy10.;
   format Date registration.;
datalines;
Smith     10/21/2005
Jones     06/13/2005
Harris    01/03/2007
Arnold    09/12/2005
;

*Program 22-16 Creating a MULTILABEL format;
proc format;
   value agegroup (multilabel)
    0 - <20   = '0 to <20'
    20 - <40  = '20 to <40'
    40 - <60  = '40 to <60'
    60 - <80  = '60 to <80'
    80 - high = '80 +'

    0 - <50   = 'Less than 50'
    50 - high = '> or = to 50';
run;

*Program 22-17 Using a MULTILABEL format with PROC MEANS;
title "Demonstrating a Multilabel Format";
title2 "PROC MEANS Example";
proc means data=learn.survey;
   class Age / MLF;
   var Salary;
   format Age agegroup.;
run;

*Program 22-18 Using the PRELOADFMT, PRINTMISS, and MISSTEXT
 options with PROC TABULATE;
title "Demonstrating a Multilabel Format";
title2 "PROC TABULATE Example";
proc tabulate data=learn.survey;
   class Age Gender / MLF preloadfmt;
   table Age , 
         Gender / printmiss  misstext=' ';
   format Age agegroup.;
run;
quit;

*Program 22-19 Partial program showing how to create several informats;
/************************************************************
Note: Note a complete program

proc format;
   invalue exp1944fmt (upcase)
     'A' = 220
     'B' = 180
     'C' = 210
     'D' = 110
     'E' = 90
   other = .;
   invalue exp1945fmt (upcase)
     'A' = 202
     'B' = 170
     'C' = 208
     'D' = 100
     'E' = 85
   other = .;
   invalue exp1946fmt (upcase)
     'A' = 150
      . . .
run;
************************************************************/

*Program 22-20 Creating several informats with a single CNTLIN data set;
data exposure;
   retain Type 'I' Hlo 'U';
   do Year = 1944 to 1949;
      Fmtname = cats('exp',Year,'fmt');
      do Start = 'A','B','C','D','E';
         End = Start;
         input Label : $3. @;
         output;
      end;
   end;
   drop Year;
datalines;
220   180   210   110   90
202   170   208   100   85
150   110   150    60   50
105    56    88    40   30
 60    30    40    20   10
 45    22    22    10    8
;

title "Creating the Exposure Format";
proc format cntlin=exposure fmtlib;
run;

*Program 22-21 Using a SELECT statement to display the contents
 of two informats;
proc format;
   select @exp1944fmt @exp1945fmt;
run;

*Program 22-22 Using user-defined informats to perform a table
 look-up,  using the INPUTN function;
data read_exp;
   input Worker $ Year JobCode $;
   Exposure = inputn(JobCode,cats('exp',Year,'fmt8.'));
datalines;
001 1944 B
002 1948 E
003 1947 C
005 1945 A
006 1948 d
;

*Program 23-1 Creating a data set with several observations
 per subject from a data set with one observation per subject;
data learn.manyper;
   set learn.oneper;
   array Dx{3};
   do Visit = 1 to 3;
      if missing(Dx{Visit}) then leave;
      Diagnosis = Dx{Visit};
      output;
   end;
   keep Subj Diagnosis Visit;
run;

*Program 23-2 Creating a data set with one observation per 
 subject from a data set with several observations per subject;
proc sort data=learn.manyper out=manyper;
   by Subj Visit;
run;

data oneper;
   set manyper;
   by Subj Visit;
   array Dx{3};
   retain Dx1-Dx3;
   if first.Subj then call missing(of Dx1-Dx3);
   Dx{Visit} = Diagnosis;
   if last.Subj then output;
   keep Subj Dx1-Dx3;
run;

*Program 23-3 Using PROC TRANSPOSE to convert a data set with one
 observation per subject into a data set with several observations
 per subject (first attempt);
***Note: data set already in Subject order;
proc transpose data=learn.oneper 
               out=manyper;
   by Subj;
   var Dx1-Dx3;
run;

*Program 23-4 Using PROC TRANSPOSE to convert a data set with one
 observation per subject into a data set with several observations
 per subject;
proc transpose data=learn.oneper 
               out=t_manyper(rename=(col1=Diagnosis)
                          drop=_name_
                          where=(Diagnosis is not null));
   by Subj;
   var Dx1-Dx3;
run;

*Program 23-5 Using PROC TRANSPOSE to convert a SAS data set with
 several observations per subject into one with one observation
 per subject;
proc transpose data=learn.manyper prefix=Dx
               out=oneper(drop=_NAME_);
   by Subj;
   id Visit;
   var Diagnosis;
run;

*Program 24-1 Creating FIRST. and LAST. variables;
options fmtsearch=(learn);

proc sort data=learn.clinic out=clinic;
   by ID VisitDate;
run;

data last;
   set clinic;
   by ID;
   put ID= VisitDate= First.ID= Last.ID=;
   if last.ID;
run;

*Program 24-2 Counting the number of visits per patient using a DATA step;
data count;
   set clinic;
   by ID;
   *Initialize counter at first visit;
   if first.ID then N_visits = 0;
   *Increment the visit counter;
   N_visits + 1;
   *Output an observation at the last visit;
   if last.ID then output;
run;

*Program 24-3 Using PROC FREQ to count the number of observations
 in a BY group;
proc freq data=learn.clinic noprint;
   tables ID / out=counts;
run;
 
*Program 24-4 Using the RENAME and DROP data set options to
 control the output data set;
proc freq data=clinic noprint;
   tables ID / out=counts (rename=(count = N_Visits)
                           drop=percent);
run;

data clinic;
   merge learn.clinic counts;
   by ID;
run;

*Program 24-5 Using PROC MEANS to count the number of observations
 in a BY group;
proc means data=learn.clinic nway noprint;
   class ID;
   output out=counts(rename=(_freq_ = N_Visits)
                     drop= _type_);
run;

*Program 24-6 Computing differences between observations;
data difference;
   set clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;
   Diff_HR = HR - lag(HR);
   Diff_SBP = SBP - lag(SBP);
   Diff_DBP = DBP - lag(DBP);
   if not first.ID then output;
run;
 
*Program 24-7 Computing differences between the first and last
 observation in a BY group;
data first_last;
   set clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;
   if first.ID or last.ID then do;
      Diff_HR = HR - lag(HR);
      Diff_SBP = SBP - lag(SBP);
      Diff_DBP = DBP - lag(DBP);
   end;
   if last.ID then output;
run;

*Program 24-8 Demonstrating the use of retained variables;
data first_last;
   set clinic;
   by ID;
   *Delete patients with only one visit;
   if first.ID and last.ID then delete;

   retain First_HR First_SBP First_DBP;

   if first.ID then do;
      First_HR = HR;
      First_SBP = SBP;
      First_DBP = DBP;
   end;   

   if last.ID then do;
      Diff_HR = HR - First_HR;
      Diff_SBP = SBP - First_SBP;
      Diff_DBP = DBP - First_DBP;
      output;
   end;
   drop First_: ;
run;

*Program 24-9 Using a retained variable to "remember" a previous value;
data hypertension;
   set learn.clinic;
   by ID;
   retain HighBP;
   if first.ID then HighBP = 'No ';
   if SBP gt 140 then HighBP = 'Yes';
   if last.ID then output;
run;

*Program 25-1 Using an automatic macro variable to include a date
 and time in a title;
title "The Date is &sysdate9 - the Time is &systime";
proc print data=learn.test_scores noobs;
run;

*Program 25-2 Assigning a value to a macro variable with a %LET statement;

%let var_list = RBC WBC Chol;

title "Using a Macro Variable List";
proc means data=learn.blood n mean min max maxdec=1;
   var &var_list;
run;

*Program 25-3 Another example of using a %LET statement;
%let n = 3;

data generate;
   do Subj = 1 to &n;
      x = int(100*ranuni(0) + 1);
      output;
   end;
run;
title "Data Set with &n Random Numbers";
proc print data=generate noobs;
run;

*Program 25-4 Writing a simple macro;
%macro gen(n,Start,End);
   data generate;
      do Subj = 1 to &n;
         x = int((&End - &Start + 1)*ranuni(0) + &Start);
         output;
      end;
   run;
   proc print data=generate noobs;
      title "Randomly Generated Data Set with &n Obs";
      title2 "Values are integers from &Start to &End";
   run;
%mend gen;

*Program 25-5 Program 25 4 with documentation added;
%macro gen(n,     /* number of random numbers */
           Start, /* Starting value           */
           End,   /* Ending value             */);
   /********************************************
   Example: To generate 4 random numbers from
   1 to 100 use:
   %gen(4,1,100)
   *********************************************/
   data generate;
      do Subj = 1 to &n;
         x = int((&End - &Start + 1)*ranuni(0) + &Start);
         output;
      end;
   run;
   proc print data=generate noobs;
      title "Randomly Generated Data Set with &n Obs";
      title2 "Values are integers from &Start to &End";
   run;
%mend gen;

*Program 25-6 Demonstrating a problem with resolving a macro variable;
%let prefix = abc;

data &prefix123;
   x = 3;
run;

*Program 25-7 Program 25 6 corrected;
%let prefix = abc;

data &prefix.123;
   x = 3;
run;

*Program 25-8 Using a macro variable as a prefix (incorrect version);
%let libref = learn;

proc print data=&libref.survey;
   title "Listing of SURVEY";
run;

*Program 25-9 Using a macro variable as a prefix (corrected version);
%let libref = learn;

proc print data=&libref..survey;
   title "Listing of SURVEY";
run;

*Program 25-10 Using macro variables to transfer value from one
 data step to another;
proc means data=learn.blood noprint;
   var RBC WBC;
   output out=means mean= M_RBC M_WBC;
run;

data _null_;
   set means;
   call symput('AveRBC',M_RBC);
   call symput('AveWBC',M_WBC);
run;

data new;
   set learn.blood(obs=5 keep=Subject RBC WBC);
   Per_RBC = RBC / &AveRBC;
   Per_WBC = WBC / &AveWBC;
   format Per_RBC Per_WBC percent8.;
run;

*Program 26-1 Demonstrating a simple query from a single data set;
title "Subjects from HEALTH with Height > 65";
proc sql;
   select Subj,
          Height,
          Weight
   from learn.health
   where Height gt 66;
quit;

*Program 26-2 Using an asterisk to select all the variables in a data set;
proc sql;
   select *
   from learn.health
   where Height gt 66;
quit;

*Program 26-3 Using PROC SQL to create a SAS data set;
proc sql;
   create table height65 as
   select *
   from learn.health
   where Height gt 66;
quit;

*Program 26-4 Joining two tables (Cartesian Product);
*Note: You need to create this data set since there
 is another permanent SAS data set called DEMOGRAPHIC
 used earlier in the book;
data learn.demographic;
   input Subj : $3.
         DOB : mmddyy10.
         Gender : $1.
         Name : $20.;
   format DOB mmddyy10.;
datalines;
001 10/15/1960 M Friedman
002 8/1/1955 M Stern
003 12/25/1988 F McGoldrick
005 5/28/1949 F Chien
;

title "Demonstrating a Cartesian Product";
proc sql;
   select health.Subj,
          demographic.Subj,
          Height,
          Weight,
          Name,
          Gender
   from learn.health,
        learn.demographic;
quit;

*Program 26-5 Renaming the two Subj variables;
title "Renaming the Two Subj Variables";
proc sql;
   select health.Subj as Health_Subj,
          demographic.Subj as Demog_Subj,
          Height,
          Weight,
          Name,
          Gender
   from learn.health,
        learn.demographic;
quit;

*Program 26-6 Using aliases to simplify naming variables;
proc sql;
   select h.Subj as Subj_Health,
          d.Subj as Subj_Demog,
          Height,
          Weight,
          Name,
          Gender
   from learn.health as h,
        learn.demographic as d
   where h.Subj eq d.Subj;
quit;

*Program 26-7 Performing an INNER JOIN ;
title "Demonstrating an Inner Join (Merge)";
proc sql;
   select h.Subj as Subj_Health,
          d.Subj as Subj_Demog,
          Height,
          Weight,
          Name,
          Gender
   from learn.health as h inner join
        learn.demographic as d
   on h.Subj eq d.Subj;
quit;

*Program 26-8 Demonstrating a Left, Right, and Full Join;
proc sql;
   title "Left Join";
   select h.Subj as Subj_Health,
          d.Subj as Subj_Demog,
          Height,
          Gender
   from learn.health as h left join
        learn.demographic as d
   on h.Subj eq d.Subj;

   title "Right Join";
   select h.Subj as Subj_Health,
          d.Subj as Subj_Demog,
          Height,
          Gender
   from learn.health as h right join
        learn.demographic as d
   on h.Subj eq d.Subj;

   title "Full Join";
   select h.Subj as Subj_Health,
          d.Subj as Subj_Demog,
          Height,
          Gender
   from learn.health as h full join
        learn.demographic as d
   on h.Subj eq d.Subj;

quit;

*Program 26-9 Concatenating two tables;
proc sql;
   create table demog_complete as
   select *
   from learn.demographic union all corresponding
   select *
   from learn.new_members
quit;

*Program 26-10 Using a summary function in PROC SQL;
proc sql;
   select Subj,
          Height,
          Weight,
          mean(Height) as Ave_Height,
          100*Height/calculated Ave_Height as
             Percent_Height
   from learn.health
quit;

*Program 26-11 Demonstrating an ORDER clause;
proc sql;
   title "Listing in Height Order";
   select Subj,
          Height,
          Weight
   from learn.health
   order by Height;
quit;

*Program 26-12 Using PROC SQL to perform a "Fuzzy Match";
proc sql;
   title "Example of a Fuzzy Match";
   select Subj, 
          h.Name as health_name,
          i.Name as insurance_name
   from learn.demographic as h,
        learn.insurance as i
   where spedis(health_name,insurance_name) le 25;
quit;


