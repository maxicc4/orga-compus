./tp0 -i tests/input1.txt -o tests/output1Test.txt
diff -s tests/output1Test.txt tests/output1Expected.txt

./tp0 -i tests/input2.txt -o tests/output2Test.txt
diff -s tests/output2Test.txt tests/output2Expected.txt

./tp0 -i tests/input3.txt -o tests/output3Test.txt
diff -s tests/output3Test.txt tests/output3Expected.txt

./tp0 -i tests/input4.txt -o tests/output4Test.txt
diff -s tests/output4Test.txt tests/output4Expected.txt

./tp0 -i tests/input5.txt -o tests/output5Test.txt
diff -s tests/output5Test.txt tests/output5Expected.txt