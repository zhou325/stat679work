# Homework 1

## Document

This directory contains the following document:

* `hw1-snaqTimeTests`: contains all data files
    * `out`: for the main output
    * `log`: to record the parameter values and details on the individual runs of a single analysis
* `script`: contains all shell scripts
    * `normalizeFileNames.sh`: for normalizing file names
    * `summarizeSNaQres.sh`: for creating a summary table for `ex2`
* `results`: contains all result files
    * `summarizeSNaQres.csv`: a summary table for `ex2`

* `README.md`: gives higher-level explanations and all the tools (commands) to reproduce my results

working directory: `hw1`

## Instructions

### exercise 1

To change the working directory to `hw1` and run the following code:
`bash scripts/normalizeFileNames.sh`
will reproduce the results of `ex1`, which change all file names from `timetesty_snaq.log` and `timetesty_snaq.out` to `timetest0y_snaq.log` and `timetest0y_snaq.out`

**Code snapshoot:**
```shell
for i in {1..9}
do
mv hw1-snaqTimeTests/log/timetest${i}_snaq.log hw1-snaqTimeTests/log/timetest0${i}_snaq.log
mv hw1-snaqTimeTests/out/timetest${i}_snaq.out hw1-snaqTimeTests/out/timetest0${i}_snaq.out
done
```

### exercise 2 and exercise 3

To change the working directory to `hw1` and run the following code:
`bash scripts/summarizeSNaQres.sh`
will reproduce the correct results of `ex2` and `ex3`, which will give a summary table of several variables.

**Code snapshoot:**
```shell
echo "analysis","h","CPUtime","Nruns","Nfail","fabs","frel","xabs","xrel","seed","under3460","under3450","under3440" > results/summarizeSNaQres.csv
for filename in hw1-snaqTimeTests/log/*.log
do
  a=`basename -s ".log" $filename` #find the file name root
  b=`grep "hmax =" $filename | grep -Eo "\d+"` #find hmax
  c=`cat hw1-snaqTimeTests/out/$a.out | grep -Eo "Elapsed time: \d+\.\d+"| grep -Eo "\d+\.\d+"` #find CPU time
  d=`grep -Eo "\d+ runs" $filename | sed -E 's/([0-9]+).*/\1/'` #find the number of runs
  e=`grep -Eo "failed proposals = \d+" $filename | gsed -E 's/.*=\s([0-9]+)/\1/'` #find Nfail
  f=`grep -Eo "ftolAbs=.*" $filename | sed -E 's/ftolAbs=(.*),/\1/'` #find fabs
  g=`grep -Eo "ftolRel=.*" $filename | sed -E 's/ftolRel=(.*), fto.*/\1/'` #find frel
  h=`grep -Eo "xtolAbs=.*" $filename | sed -E 's/xtolAbs=(.*), xto.*/\1/'` #find xabs
  i=`grep -Eo "xtolRel=.*" $filename | sed -E 's/xtolRel=(.*)\./\1/'` #find xrel
  j=`grep -Eo "main seed.*" $filename | gsed -E 's/.*\s([0-9]+)/\1/'` #find the main seed
  k=`grep -Eo "loglik=\d+\.\d+" $filename | sed -E 's/.*=([0-9]+)\..*/\1/'`
  #find all the loglik in one .log file, because the '-lt' expression requires an integer, I only extract the interger part of loglik values.
  z1=0 #set the initial value of the number of under3460
  z2=0 #set the initial value of the number of under3450
  z3=0 #set the initial value of the number of under3440
  for y in $k
  #for each value in the variable k
  do
    if [ $y -lt 3460 ]
    then
      ((z1+=1)) #if y is less than 3460, add 1 to z1
    fi
    if [ $y -lt 3450 ]
    then
      ((z2+=1)) #if y is less than 3450, add 1 to z2
    fi
    if [ $y -lt 3440 ]
    then
      ((z3+=1)) #if y is less than 3440, add 1 to z3
    fi
  done
  echo $a,$b,$c,$d,$e,$f,$g,$h,$i,$j,$z1,$z2,$z3 >> results/summarizeSNaQres.csv
  #write all the variables of interest into a summary table
done
```

**Output table:**

|analysis       |h   |CPUtime         |Nruns|Nfail|fabs  |frel  |xabs  |xrel |seed |under3460|under3450|under3440|
|---------------|----|----------------|-----|-----|------|------|------|-----|-----|---------|---------|---------|
|bT1            |0   |103354.760381735|10   |100  |1.0e-6|1.0e-5|0.0001|0.001|66077|0        |0        |0        |
|net1_snaq      |1   |11648.984309726 |10   |100  |1.0e-6|1.0e-5|0.0001|0.001|3322 |1        |1        |0        |
|newtry1        |1   |88579.306341032 |10   |100  |1.0e-6|1.0e-5|0.0001|0.001|36252|4        |4        |2        |
|timetest01_snaq|1   |16688.01510346  |10   |10   |1.0e-6|1.0e-5|0.0001|0.001|30312|2        |1        |0        |
|timetest02_snaq|1   |37137.96354747  |10   |25   |1.0e-6|1.0e-5|0.0001|0.001|28669|4        |1        |0        |
|timetest03_snaq|1   |12630.994448551 |10   |100  |0.1   |0.1   |0.0001|0.001|66086|0        |0        |0        |
|timetest04_snaq|1   |21942.346502542 |10   |100  |0.01  |0.01  |0.0001|0.001|62366|0        |0        |0        |
|timetest05_snaq|1   |23949.375026384 |10   |100  |0.005 |0.005 |0.0001|0.001|3888 |2        |1        |0        |
|timetest06_snaq|1   |39287.796202476 |10   |25   |1.0e-6|1.0e-5|0.0001|0.001|14351|4        |3        |3        |
|timetest07_snaq|1   |29822.147601027 |10   |100  |0.005 |0.005 |0.0001|0.001|14351|5        |5        |0        |
|timetest08_snaq|1   |51589.342317181 |10   |100  |1.0e-6|1.0e-5|0.001 |0.1  |15989|3        |2        |1        |
|timetest09_snaq|1   |34831.465925074 |10   |50   |0.0001|1.0e-5|0.0001|0.001|45123|1        |0        |0        |
|timetest10_snaq|1   |29394.463493788 |10   |50   |1.0e-5|0.0001|0.0001|0.001|37792|0        |0        |0        |
|timetest11_snaq|1   |67926.502059791 |10   |50   |5.0e-6|1.0e-5|0.0001|0.001|25765|2        |2        |0        |
|timetest12_snaq|1   |18935.630572383 |10   |50   |1.0e-6|1.0e-5|0.01  |0.1  |39416|4        |0        |0        |
|timetest13_snaq|1   |31456.993676184 |10   |100  |1.0e-5|1.0e-5|0.01  |0.1  |38112|3        |1        |1        |
