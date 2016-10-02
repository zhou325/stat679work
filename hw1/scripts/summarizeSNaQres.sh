#find the file name root
echo "analysis" >> results/1.csv
for file in hw1-snaqTimeTests/out/*.out
do
  t=${file/beif\/out\//}
  analysis="${t%.*}"
  echo $analysis >> results/1.csv #write the file name root into the file 1.csv
done

#find the hmax
echo "h" >> results/2.csv
for file in hw1-snaqTimeTests/log/*.log
do
  t="$(grep "hmax =" $file)" #find the hmax from all '.log' files.
  d="${t/hmax = /}"
  echo ${d/,/} >> results/2.csv #write only the number of hmax into the file 2.csv
done

#find CPU time
echo "CPUtime" >> results/3.csv
for file in hw1-snaqTimeTests/out/*.out
do
  t="$(grep -i "elapsed" $file)" #find the elapsed time from all '.out' files.
  d="${t/Elapsed time: /}"
  echo ${d/ seconds in 10 successful runs/} >> results/3.csv #write only the number of elapsed time into the file 3.csv
done

#combine three '.csv' files together
paste -d "," results/1.csv results/2.csv results/3.csv >> results/summarizeSNaQres.csv

#remove intermediate files
for file in results/[123].csv
do
  rm $file
done
