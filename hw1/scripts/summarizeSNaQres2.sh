echo "analysis", "hmax", "CPU time" >> results/summarizeSNaQres2.csv
for filename in hw1-snaqTimeTests/log/*.log
do
  a=`echo $filename | grep -Eo "/\w+\." | grep -Eo "\w+"`
  b=`grep "hmax =" $filename | grep -Eo "\d+"`
  c=`cat hw1-snaqTimeTests/out/$a.out | grep -Eo "Elapsed time: \d+" | grep -Eo "\d+"`
  echo $a,$b,$c >> results/summarizeSNaQres2.csv
done
