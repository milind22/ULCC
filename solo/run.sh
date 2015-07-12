make -f makefile.infinite
sleep 1
sd=10
for (( rep=1;rep<=50;rep++))
do
echo "rep=$rep\n"
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infinite $sd 64 &
sleep 5
pkill infinite
bash arrange.sh >> data.solo.$sd
done
sort -n data.solo.$sd --output=data.solo.$sd
