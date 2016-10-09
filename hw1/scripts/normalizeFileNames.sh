#change all file names timetesty_snaq.log to timetest0y_snaq.log, and all file names timetesty_snaq.out to timetest0y_snaq.out
for i in {1..9}
do
mv hw1-snaqTimeTests/log/timetest${i}_snaq.log hw1-snaqTimeTests/log/timetest0${i}_snaq.log
mv hw1-snaqTimeTests/out/timetest${i}_snaq.out hw1-snaqTimeTests/out/timetest0${i}_snaq.out
done

##undo this step
# for i in {1..9}
# do
# mv hw1-snaqTimeTests/log/timetest0${i}_snaq.log hw1-snaqTimeTests/log/timetest${i}_snaq.log
# mv hw1-snaqTimeTests/out/timetest0${i}_snaq.out hw1-snaqTimeTests/out/timetest${i}_snaq.out
# done
