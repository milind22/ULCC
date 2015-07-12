ds=20
dw=50
nops=2
stride=64
ch=50
cl=0
cw=62


cp infinite_version_ulcc.s accesses_20_nops.s
for (( i=1 ; i <= nops ; i++ ))
do
	sed -i '/.L23:/a\\t nop ' accesses_20_nops.s
done

gcc accesses_20_nops.s -L../../../src -Wl,-rpath,../../../src -lulcc -lpthread -o accesses

# run PA
numactl --physcpubind=2 --membind=0 ./accesses $dw $stride $ch+1 $cw &
sleep 1
numactl --physcpubind=0 --membind=0 perf stat -e cache-misses,cache-references,L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,LLC-prefetches,instructions ./accesses $ds $stride $cl $ch &
sleep 10

pkill accesses 
