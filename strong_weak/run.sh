make -f makefile.infinite
sleep 1

sd_strong=10
sd_weak=50

for (( rep=1;rep<=50;rep++))
do
numactl --physcpubind=2 --membind=0 ./infinite $sd_weak 64 &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infinite $sd_strong 64 &
sleep 10
pkill infinite
bash arrange.sh >> data.strong.$sd_strong.weak.$sd_weak
done
sort -n data.strong.$sd_strong.weak.$sd_weak --output=data.strong.$sd_strong.weak.$sd_weak
