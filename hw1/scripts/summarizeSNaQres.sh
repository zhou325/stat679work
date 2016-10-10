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
