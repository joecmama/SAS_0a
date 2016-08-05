*Chapter 2 - Problem 2;
data prob2;
   input ID $ 
         Height /* in inches */
         Weight /* in pounds */
         SBP    /* systolic BP  */
         DBP    /* diastolic BP */;

< place your statements here >

datalines;
001 68 150 110 70
002 73 240 150 90
003 62 101 120 80
;
title "Listing of PROB2";
proc print data=prob2;
run;

*Chapter 4 - Problem 1;
libname learn 'c:\your-folder-name';

data learn.perm;
   input ID : $3. Gender : $1. DOB : mmddyy10.
         Height Weight;
   label DOB = 'Date of Birth'
         Height = 'Height in inches'
         Weight = 'Weight in pounds';
   format DOB date9.;
datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
003 M 5/11/1981 72 175
004 M 7/4/1983 70 128
005 F 12/25/2005 30 40
;

*Chapter 4 - Problem 3;
data -fill in your data set name here- ;
   input Age Gender $ (Ques1-Ques5)($1.);
   /* See Chapter 21, Section 14 for a discussion
      of variable lists and format lists used above */
datalines;
23 M 15243
30 F 11123
42 M 23555
48 F 55541
55 F 42232
62 F 33333
68 M 44122
;

* Write your libname statement here;
proc means data= - insert the correct data set name -;
   var Age;
run;

*Chapter 5 - Problem 1;
data voter;
   input Age Party : $1. (Ques1-Ques4)($1. + 1);
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;

*Chapter 5 - Problem 3;
data colors;
   input Color : $1. @@;
datalines;
R R B G Y Y . . B G R B G Y P O O V V B
;

*Chapter 6 - Problem 2;
data soccer;
   input Team : $20. Wins Losses;
datalines;
Readington 20 3
Raritan 10 10
Branchburg 3 18
Somerville 5 18
;
options nodate nonumber;
title;
ods listing close;
ods csv file='c:\books\learning\soccer.csv';
proc print data=soccer noobs;
run;
ods csv close;
ods listing;

*Chapter 7 - Problem 1;
data school;
   input Age Quiz : $1. Midterm Final;
   /* Add you statements here */
datalines;
12 A 92 95
12 B 88 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;

*Chapter 8 - Problem 1;
data vitals;
   input ID    : $3.
         Age      
         Pulse    
         SBP
         DBP;
   label SBP = "Systolic Blood Pressure"
         DBP = "Diastolic Blood Pressure";
datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007  . 82 140 100
;

*Chapter 8 - Problem 2;
data monthsales;
   input month sales @@;
   /* add your line(s) here */
datalines;
1 4000 2 5000 3 . 4 5500 5 5000 6 6000 7 6500 8 4500
9 5100 10 5700 11 6500 12 7500
;

*Chapter 8 - Problem 3;
data test;
   input Score1-Score3;
   /* add your line(s) here */
datalines;
90 88 92
75 76 88
88 82 91
72 68 70
;

*Chapter 8 - Problem 8;
goptions reset=all 
         ftext='arial' 
         htext=1.0 
         ftitle='arial/bo'
         htitle=1.5
         colors=(black);
symbol v=none i=sm;
title "Logit Plot";
proc gplot data=logitplot;
   plot Logit * p;
run;
quit;

*Chapter 8 - Problem 10
 the 3 lines of data below should be placed
 after your datalines statement;
/**************************************
250 255 256 300 244 268 301 322 256 333
267 275 256 320 250 340 345 290 280 300
350 350 340 290 377 401 380 310 299 399
***************************************/

*Chapter 8 - Problem 11
 Copy the data from inside the comment;
/***************************************
80 81 82 83 84 84 87 88 89 89 
91 93 93 95 96 97 99 95 92 90 88
86 84 80 78 76 77 78
80 81 82 82 86 
88 90 92 92 93 96 94 92 90
88 84 82 78 76 74
****************************************/

*Chapter 9 - Problem 1
 Copy the data from inside the comment;
/***************************************
0011021195011Nov2006
0020102195525May2005
0031225200525Dec2006
****************************************/

*Chapter 9 - Problem 2
 Copy the data from inside the comment;
/***************************************
01/03/1950 01/03/1960 03Jan1970
05/15/2000   05/15/2002   15May2003
10/10/1998 11/12/2000    25Dec2005
****************************************/

*Chapter 9 - Problem 3
 Copy the data from inside the comment;
/***************************************
01/01/11
02/23/05
03/15/15
05/09/06
****************************************/

*Chapter 9 - Problem 8
 Copy the data from inside the comment;
/***************************************
25 12 2005
1    1   1960
21   10   1946
****************************************/

*Chapter 9 - Problem 9
 Copy the data from inside the comment;
/***************************************
25 12 2005
.  5  2002
12 8     2006
****************************************/

*Chapter 10 - Problem 8;
data markup;
   input manuf : $10. Markup;
datalines;
Cannondale 1.05
Trek 1.07
;

*Chapter 11 - Problem 12;
goptions reset=all colors=(black) ftext=swiss htitle=1.5;
symbol1 v=dot i=smooth;
title "Plot of Daily Price Differences";

proc gplot data=difference;
   plot Diff*Date;
run;
quit;

*Chapter 11 - Problem 13;
goptions reset=all colors=(black) ftext=swiss htitle=1.5;
symbol1 v=dot line=1 i=smooth;
symbol2 v=square line=2 i=smooth;
title "Plot of Price and Moving Average";

proc gplot data=smooth;
   plot Price*Date
        Average*Date / overlay;
run;
quit;

*Chapter 12 - Problem 1;
data storage;
   length A $ 4 B $ 4;
   Name = 'Goldstein';
   AandB = A || B;
   Cat = cats(A,B);
   if Name = 'Smith' then Match = 'No';
      else Match = 'Yes';
        Substring = substr(Name,5,2);
run;

*Chapter 13 - Problem 5
 Copy the data from inside the comment;
/*************************************
001   90 88 92 95 90
002   64 64 77 72 71
003   68 69 80 75 70
004   88 77 66 77 67
**************************************/

*Chapter 16 - Problem 2
 Run this program to create the necessary formats;
proc format;
   value $yesno 'Y','1' = 'Yes'
                'N','0' = 'No'
                ' '     = 'Not Given';
   value $size 'S' = 'Small'
               'M' = 'Medium'
               'L' = 'Large'
                ' ' = 'Missing';
   value $gender 'F' = 'Female'
                 'M' = 'Male'
                 ' ' = 'Not Given';
run;

*Chapter 18 - all problems
 Run the program above (Chapter 16 - 2) to
 create the necessary formats;

*Chapter 19 - Problem 1;
title "Sending Output to an HTML File";
proc print data=learn.college(obs=8) noobs;
run;

proc means data=learn.college n mean maxdec=2;
   var GPA ClassRank;
run;

*Chapter 22 - Problem 6
 Use the line of data between
 the comments;
/**********************************
A 6.7 X b c a 10.9 11.6 C
***********************************/

*Chapter 25 - Problem 2;
data sqrt_table;
   do n = 1 to 5;
      Sqrt_n = sqrt(n);
      output;
   end;
run;

title "Square Root Table from 1 to 5";
proc print data=sqrt_table noobs;
run;

*Chapter 25 - Problem 3;
title "Listing of the first 5 Observations from "
      "Data set STOCKS";
proc print data=learn.stocks(obs=5) noobs;
run;

*Chapter 25 - Problem 4;
title "Statistics from data set learn.bibycles";

proc means data=bicycles n mean min max maxdec=1;
   class Country;
   var Units TotalSales;
run;

*Chapter 26 - Problem 10;
data xxx;
   input NameX : $15. PhoneX : $13.;
datalines;
Friedman (908)848-2323
Chien (212)777-1324
;
data yyy;
   input NameY : $15. PhoneY : $13.;
datalines;
Chen (212)888-1325
Chambliss (830)257-8362
Saffer (740)470-5887
;



