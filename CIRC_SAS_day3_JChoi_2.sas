libname My1stLib '/home/jchoi50/Desktop/MySAS/Data/';

data My1stlib.demog;
  infile "/home/jchoi50/Desktop/MySAS/Data/mydata.txt";
  input Gender $ Age Height Weight;
run;
