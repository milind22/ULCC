#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "../../src/ulcc.h"
static unsigned long x=123456789, y=362436069, z=521288629;

unsigned long xorshf96(void) {          //period 2^96-1
unsigned long t;
    x ^= x << 16;
    x ^= x >> 5;
    x ^= x << 1;

   t = x;
   x = y;
   y = z;
   z = t ^ x ^ y;

  return z;
}

char *data_start, *data_end;
const long int size=2048000;
int linesize = 64 / sizeof(int);
int ways; // range 4 - 20
int stride;
void * buffer;
#define num_sets (3*1024*1024)/(12*64)
int dump[100];

unsigned long long int val=0;
float val2=100, val1=100;
void init_buffer()
{
	int i;
	int j, flag;
	cc_cacheregn_t regn;
	char *p;
//	FILE * db= fopen("dump.bin","r");

	buffer = malloc(sizeof(int)*num_sets*ways*linesize);
	printf(" allocating a total of %ldMB \n",sizeof(int)*num_sets*ways*linesize/(1024*1024));

// 	insert ulcc here
	
	data_start = (char *)ULCC_ALIGN_HIGHER((unsigned long)buffer);
	data_end = (char *)ULCC_ALIGN_LOWER((unsigned long)(buffer+(sizeof(int)*num_sets*ways*linesize)));
	printf("done\n");
	
	cc_cacheregn_clr(&regn);
	printf("done\n");
	cc_cacheregn_set(&regn, 0, cc_nr_colors() - 4, 1);
	printf("done\n");

	if(cc_remap((unsigned long *)&data_start, (unsigned long *)&data_end, 1,
			&regn, CC_ALLOC_NOMOVE | CC_MAPORDER_SEQ) < 0) {
		fprintf(stderr, "failed to remap data region 1\n");
		return;
	}
	printf("done %lu\n",ULCC_PAGE_BYTES);
	int count=0;
	printf("%d\n",*data_start);
	printf("%d\n",*data_end);	
	for(p = data_start;p<data_end;p++) {
		*p = 'x';
		count++;
	}
	printf("%d\n",count);
	printf("done\n");
}

#define NUMACCESS 100000000


int main(int argc, char ** argv)
{
	struct timeval t1, t2;
	srandom(time(NULL));
	printf("argc = %d\n",argc);
        if(argc == 3)
        {
                ways = atoi(argv[1]);
		stride=atoi(argv[2]);
        }
	else
	{
		printf("Usage: ways (4-20) \n");
		exit(0);
	}

	gettimeofday(&t1, NULL);
	init_buffer();
	gettimeofday(&t2,NULL);
	printf("%ld useconds \n",(t2.tv_usec - t1.tv_usec + (t2.tv_sec - t1.tv_sec)*1000000));

   //     access_pattern(stride);
       
	printf("done\n"); 
    //    dummy(val);
}

