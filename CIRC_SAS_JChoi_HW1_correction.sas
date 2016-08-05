/* Day 2 Homework for CIRC SAS Summer School
   by Joseph Choi
   (08/02/2016)
*/
data Portfolio;
   infile '/home/jchoi50/Desktop/MySAS/Data/stocks.txt';
   input symbol $ price num_share;

   Value = price * num_share;
run;

title "Listing of Portfolio";
  proc print data=Portfolio noobs;
run;

title "Means and Sums of Portfolio Variables";
proc means data=Portfolio n mean sum maxdec=0;
   var price num_share;
run;
