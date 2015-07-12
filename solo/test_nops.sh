d=20
nops=10
stride=64


cp infinite_version.s accesses_20_nops.s
for (( rep=1 ; rep<=50 ; rep++ ))
do
for (( i=1 ; i <= nops ; i++ ))
do
	sed -i '/.L9:/a\\t nop ' accesses_20_nops.s
done

gcc accesses_20_nops.s -o accesses

# run PA
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append  -e cache-misses,cache-references,LLC-prefetches ./accesses $d $stride &
sleep 5
pkill accesses
bash arrange.sh >> data.$d.$nops
done
sort -n data.$d.$nops --output=data.$d.$nops
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $cmr_mean" >> cmr_mean
acc="$(awk '{ sum+=$2} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $acc" >> acc_mean
time="$(awk '{ sum+=$3} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $time" >> time_mean
cmr_med="$(sed -n '26p' data.$d.$nops)"
echo "data.$d.$nops- $cmr_med" >> median

$d=12
cp infinite_version.s accesses_12_nops.s
for (( rep=1 ; rep<=50 ; rep++ ))
do
for (( i=1 ; i <= nops ; i++ ))
do
	sed -i '/.L9:/a\\t nop ' accesses_12_nops.s
done

gcc accesses_20_nops.s -o accesses

# run PA
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append  -e cache-misses,cache-references,LLC-prefetches ./accesses $d $stride &
sleep 5
pkill accesses
bash arrange.sh >> data.$d.$nops
done
sort -n data.$d.$nops --output=data.$d.$nops
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $cmr_mean" >> cmr_mean
acc="$(awk '{ sum+=$2} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $acc" >> acc_mean
time="$(awk '{ sum+=$3} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $time" >> time_mean
cmr_med="$(sed -n '26p' data.$d.$nops)"
echo "data.$d.$nops- $cmr_med" >> median


$d=10
cp infinite_version.s accesses_10_nops.s
for (( rep=1 ; rep<=50 ; rep++ ))
do
for (( i=1 ; i <= nops ; i++ ))
do
	sed -i '/.L9:/a\\t nop ' accesses_10_nops.s
done

gcc accesses_20_nops.s -o accesses

# run PA
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append  -e cache-misses,cache-references,LLC-prefetches ./accesses $d $stride &
sleep 5
pkill accesses
bash arrange.sh >> data.$d.$nops
done
sort -n data.$d.$nops --output=data.$d.$nops
cmr_mean="$(awk '{ sum+=$5} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $cmr_mean" >> cmr_mean
acc="$(awk '{ sum+=$2} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $acc" >> acc_mean
time="$(awk '{ sum+=$3} END {print sum/50}' data.$d.$nops)"
echo "data.$d.$nops- $time" >> time_mean
cmr_med="$(sed -n '26p' data.$d.$nops)"
echo "data.$d.$nops- $cmr_med" >> median
