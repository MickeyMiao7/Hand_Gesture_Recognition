#!/usr/bin/env sh
DATA=data/myimgs/
MY=examples/myfile

echo "Create train.txt..."
rm -rf $MY/train.txt
for i in 1 2 3 4 5 6 7 8 9 10 A B C D E G H I K M N O P Q R T U W 
do
find $DATA/train -name $i*.jpg | cut -d '/' -f4-5 | sed "s/$/ $i/">>$MY/train.txt
done
echo "Create test.txt..."
rm -rf $MY/test.txt
for i in 1 2 3 4 5 6 7 8 9 10 A B C D E G H I K M N O P Q R T U W 
do
find $DATA/test -name $i*.jpg | cut -d '/' -f4-5 | sed "s/$/ $i/">>$MY/test.txt
done
echo "All done"