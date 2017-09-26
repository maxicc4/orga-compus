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

time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 10 -O 10
diff -s tests/american-english-test.txt tests/american-english-output.txt

time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 100 -O 100
diff -s tests/american-english-test.txt tests/american-english-output.txt

time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 1000 -O 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt

time ./tp1 -i tests/american-english -o tests/american-english-test.txt -O 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt

time ./tp1 -i tests/american-english -o tests/american-english-test.txt -I 1000
diff -s tests/american-english-test.txt tests/american-english-output.txt
