bufsizes=( 1 1 1 10 10 1 100 100 1000 1000 )

for ((i=0; i<${#bufsizes[@]}; i+=2)); do
  echo "input buffer ${bufsizes[i]} bytes - output buffer ${bufsizes[i+1]} bytes:"
  time ./tp1 -I ${bufsizes[i]} -O ${bufsizes[i+1]} -i tests/input7.txt -o out
  diff tests/output7Expected.txt out
  echo ""
done
cd sh   
