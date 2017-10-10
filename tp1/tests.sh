for file in tests/input*.txt
do
	name=${file##*/input}
	name=${name%.txt}
	./tp1 -i $file -o "tests/output${name}Test.txt" -I32 -O32
	diff -s "tests/output${name}Test.txt" "tests/output${name}Expected.txt"
done
