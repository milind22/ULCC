for (( rep=1;rep<=10;rep++))
do
for (( sd=1;sd<=100;sd++))
do
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./accesses $sd 64 
sleep 1
bash arrange.sh >> data_graph/data.$rep
done
#sort -n data_20_60 --output=data_20_60
done
