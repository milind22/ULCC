nops=10
cl=0
ch=125
sd=100

#solo with ulcc
mkdir data
cp infinite_version_ulcc.s accesses__nops.s
for (( i=10 ; i<=100 ; i=i+10 ))
do
mkdir cmrVScolor_$i
for (( j=0 ; j<=125 ; j=j+5 ))
do
for (( rep=1 ; rep<=25 ; rep++))
do
for (( x=1 ; x <= nops ; x++ ))
do
	sed -i '/.L16:/a\\t nop ' accesses__nops.s
done
echo "$rep"
gcc accesses__nops.s -L../../../src -Wl,-rpath,../../../src -lulcc -lpthread -o accesses
numactl --physcpubind=0 --membind=0 perf stat --output=perf-out --append -B -e cache-misses,cache-references,LLC-prefetches  ./accesses $i 64 $cl $j &
sleep 10
pkill accesses
bash arrange.sh >> data_solo.$i.ulcc.$j
done
sort -n data_solo.$i.ulcc.$j --output=data_solo.$i.ulcc.$j
cmr_mean="$(awk '{ sum+=$5} END {print sum/25}' data_solo.$i.ulcc.$j)"
echo "$cmr_mean" >> cmr_mean$i
acc="$(awk '{ sum+=$2} END {print sum/25}' data_solo.$i.ulcc.$j)"
echo "$acc" >> acc_mean$i
time="$(awk '{ sum+=$3} END {print sum/25}' data_solo.$i.ulcc.$j)"
echo "$time" >> time_mean$i
cmr_med="$(sed -n '13p' data_solo.$i.ulcc.$j)"
echo "$cmr_med" >> median$i
mv data_solo.$i.ulcc.$j cmrVScolor_$i/data_solo.$i.ulcc.$j
done
mv cmr_mean$i data/cmr_mean$i
mv acc_mean$i data/acc_mean$i
mv time_mean$i data/time_mean$i
mv median$i data/median$i
done
