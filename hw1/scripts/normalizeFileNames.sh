for y in hw1-snaqTimeTests/log/*st[1,2,3,4,5,6,7,8,9]_snaq.log
do
mv ${y} ${y/timetest/timetest0}
done

for y in hw1-snaqTimeTests/out/*st[1,2,3,4,5,6,7,8,9]_snaq.out
do
mv ${y} ${y/timetest/timetest0}
done
