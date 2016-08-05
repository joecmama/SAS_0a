/* Day 2 Homework for CIRC SAS Summer School
   by Joseph Choi
   (08/02/2016)
*/
data Portfolio;
   infile '/home/jchoi50/Desktop/MySAS/Data/stocks.txt';
   input symbol $ price num_share;

   Value = price * num_share;
run;

title "Summary Statistics";
proc means data=Portfolio;
   var price num_share;
run;
