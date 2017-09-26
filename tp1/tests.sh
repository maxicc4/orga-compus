./tp1 -i tests/input1.txt -o tests/output1Test.txt
diff -s tests/output1Test.txt tests/output1Expected.txt

./tp1 -i tests/input2.txt > tests/output2Test.txt
diff -s tests/output2Test.txt tests/output2Expected.txt

cat tests/input3.txt | ./tp1 -o tests/output3Test.txt
diff -s tests/output3Test.txt tests/output3Expected.txt

cat tests/input4.txt | ./tp1 > tests/output4Test.txt
diff -s tests/output4Test.txt tests/output4Expected.txt

cat tests/input5.txt | ./tp1 -i - -o - > tests/output5Test.txt
diff -s tests/output5Test.txt tests/output5Expected.txt

cat tests/input6.txt | ./tp1 -o tests/output6Test.txt
diff -s tests/output6Test.txt tests/output6Expected.txt

echo "input buffer 1 byte - output buffer 1000 bytes:"
time ./tp1 -i tests/american-english -o tests/american-english-test.txt -O 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt

echo "input buffer 1000 bytes - output buffer 1 byte:"
time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt

echo "input buffer 10 bytes - output buffer 10 bytes:"
time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 10 -O 10
diff -s tests/american-english-test.txt tests/american-english-output.txt

echo "input buffer 100 bytes - output buffer 100 bytes:"
time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 100 -O 100
diff -s tests/american-english-test.txt tests/american-english-output.txt

echo "input buffer 1000 bytes - output buffer 1000 bytes:"
time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 1000 -O 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt

echo "Test buffer demasiado grande:"
./tp1 -I 200000000 2> tests/mallocerrorOutput.txt
diff -s tests/mallocerrorOutput.txt tests/mallocerror.txt
