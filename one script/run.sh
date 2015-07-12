make -f makefile.infinite
sleep 1
make -f makefile.infiniteULCC

sdStrong[0]=10
sdStrong[1]=12
sdStrong[2]=20

sdWeak[0]=50
sdWeak[1]=100


#solo
for i in "${sdStrong[@]}"
do
for (( rep=1;rep<=50;rep++))
do
echo "$rep"
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infinite $i 64 &
sleep 10
pkill infinite
bash arrange.sh >> data_solo.$i
done
sort -n data_solo.$i --output=data_solo.$i
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data_solo.$i)"
echo "data_solo.$i- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data_solo.$i)"
echo "data_solo.$i- $cmr_med" >> median
done

#solo with ulcc
#50 colors
for i in "${sdStrong[@]}"
do
for (( rep=1;rep<=50;rep++))
do
echo "$rep"
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infiniteULCC $i 64 0 50 &
sleep 10
pkill infinite
bash arrange.sh >> data_solo.$i.ulcc.50
done
sort -n data_solo.$i.ulcc.50 --output=data_solo.$i.ulcc.50
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data_solo.$i.ulcc.50)"
echo "data_solo.$i.ulcc.50- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data_solo.$i.ulcc.50)"
echo "data_solo.$i.ulcc.50- $cmr_med" >> median
done

#60 colors
for i in "${sdStrong[@]}"
do
for (( rep=1;rep<=50;rep++))
do
echo "$rep"
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infiniteULCC $i 64 0 60 &
sleep 10
pkill infinite
bash arrange.sh >> data_solo.$i.ulcc.60
done
sort -n data_solo.$i.ulcc.60 --output=data_solo.$i.ulcc.60
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data_solo.$i.ulcc.60)"
echo "data_solo.$i.ulcc.60- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data_solo.$i.ulcc.60)"
echo "data_solo.$i.ulcc.60- $cmr_med" >> median
done

#strong with weak
for i in "${sdStrong[@]}"
do
for j in "${sdWeak[@]}"
do
for (( rep=1;rep<=50;rep++))
do
numactl --physcpubind=2 --membind=0 ./infinite $j 64 &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infinite $i 64 &
sleep 10
pkill infinite
bash arrange.sh >> data.strong.$i.weak.$j
done
sort -n data.strong.$i.weak.$j --output=data.strong.$i.weak.$j
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data.strong.$i.weak.$j)"
echo "data.strong.$i.weak.$j- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data.strong.$i.weak.$j)"
echo "data.strong.$i.weak.$j- $cmr_med" >> median
done
done

#strong with weak and ulcc
#50-10 colors
for i in "${sdStrong[@]}"
do
for j in "${sdWeak[@]}"
do
for (( rep=1;rep<=50;rep++))
do
numactl --physcpubind=2 --membind=0 ./infiniteULCC $j 64 51 60 &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infiniteULCC $i 64 0 50 &
sleep 10
pkill infinite
bash arrange.sh >> data_strong.$i.50.weak.$j.10.ULCC
done
sort -n data_strong.$i.50.weak.$j.10.ULCC --output=data_strong.$i.50.weak.$j.10.ULCC
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data_strong.$i.50.weak.$j.10.ULCC)"
echo "data_strong.$i.50.weak.$j.10.ULCC- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data_strong.$i.50.weak.$j.10.ULCC)"
echo "data_strong.$i.50.weak.$j.10.ULCC- $cmr_med" >> median
done
done

#60-1 colors
for i in "${sdStrong[@]}"
do
for j in "${sdWeak[@]}"
do
for (( rep=1;rep<=50;rep++))
do
numactl --physcpubind=2 --membind=0 ./infiniteULCC $j 64 62 62 &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./infiniteULCC $i 64 0 60 &
sleep 10
pkill infinite
bash arrange.sh >> data_strong.$i.60.weak.$j.1.ULCC
done
sort -n data_strong.$i.60.weak.$j.1.ULCC --output=data_strong.$i.60.weak.$j.1.ULCC
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data_strong.$i.60.weak.$j.1.ULCC)"
echo "data_strong.$i.60.weak.$j.1.ULCC- $cmr_mean" >> mean
cmr_med="$(sed -n '26p' data_strong.$i.60.weak.$j.1.ULCC)"
echo "data_strong.$i.60.weak.$j.1.ULCC- $cmr_med" >> median
done
done
