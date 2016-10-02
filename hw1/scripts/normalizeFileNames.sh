#change all file names timetesty_snaq.log to timetest0y_snaq.log
for y in hw1-snaqTimeTests/log/*st[1,2,3,4,5,6,7,8,9]_snaq.log
do
mv ${y} ${y/timetest/timetest0}
done

#change all file names timetesty_snaq.out to timetest0y_snaq.out
for y in hw1-snaqTimeTests/out/*st[1,2,3,4,5,6,7,8,9]_snaq.out
do
mv ${y} ${y/timetest/timetest0}
done
