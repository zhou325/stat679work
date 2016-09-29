#find the file name root
echo "analysis" >> results/1.csv
for file in hw1-snaqTimeTests/out/*.out
do
  t=${file/beif\/out\//}
  analysis="${t%.*}"
  echo $analysis >> results/1.csv
done

#find the hmax
echo "h" >> results/2.csv
for file in hw1-snaqTimeTests/log/*.log
do
  t="$(grep "hmax =" $file)"
  d="${t/hmax = /}"
  echo ${d/,/} >> results/2.csv
done

#find CPU time
echo "CPUtime" >> results/3.csv
for file in hw1-snaqTimeTests/out/*.out
do
  t="$(grep -i "elapsed" $file)"
  d="${t/Elapsed time: /}"
  echo ${d/ seconds in 10 successful runs/} >> results/3.csv
done

#combine three files together
paste -d "," results/1.csv results/2.csv results/3.csv >> results/summarizeSNaQres.csv

#remove intermediate result
for file in results/[123].csv
do
  rm $file
done
