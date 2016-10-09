echo "analysis", "hmax", "CPU time" >> results/summarizeSNaQres.csv
for filename in hw1-snaqTimeTests/log/*.log
do
  a=`echo $filename | grep -Eo "/\w+\." | grep -Eo "\w+"` #get the file name root
  b=`grep "hmax =" $filename | grep -Eo "\d+"` #get hmax
  c=`cat hw1-snaqTimeTests/out/$a.out | grep -Eo "Elapsed time: \d+\.\d+"| grep -Eo "\d+\.\d+"` #get CPU time
  echo $a,$b,$c >> results/summarizeSNaQres.csv
done
