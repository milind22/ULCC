make -f makefile.infiniteULCC
sleep 1

sd_strong=20
sd_weak=50

for (( rep=1;rep<=50;rep++))
do
numactl --physcpubind=2 --membind=0 ./infinite $sd_weak 64 62 62 &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infinite $sd_strong 64 0 60 &
sleep 10
pkill infinite
bash arrange.sh >> data_strong.$sd_strong.60.weak.$sd_weak.1.ULCC
done
sort -n data_strong.$sd_strong.60.weak.$sd_weak.1.ULCC --output=data_strong.$sd_strong.60.weak.$sd_weak.1.ULCC
