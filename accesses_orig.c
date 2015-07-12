#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
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

const long int size=2048000;
int linesize = 64 / sizeof(int);
int ways; // range 4 - 20
int stride;
void * buffer;
#define num_sets (3*1024*1024)/(12*64)

unsigned long long int val=0;
float val2=100, val1=100;
void init_buffer()
{
	int i;
	int j, flag;
	int *p;

	buffer = malloc(sizeof(int)*num_sets*ways*linesize);
	printf(" allocating a total of %ldMB \n",sizeof(int)*num_sets*ways*linesize/(1024*1024));

	srand(time(NULL));

	p=(int *)buffer;
	for(i=0;i<num_sets*ways*linesize;i++)
		p[i] = rand()%128;
}
#define NUMACCESS 100000000

void access_pattern(int stride)
{
  unsigned int i,j,jj,st;
  int flag;
  int cnt=1;
  int *p = (int *)buffer;


  for(cnt=1;cnt<NUMACCESS;cnt+=ways*num_sets)
  {
      for(i=0;i<ways;i++)
      {
        for(st=0;st<=stride-1;st++)
        {
		  for(j=1;j<num_sets/stride;j++)
		  {
			jj = st + (j-1) * stride;		
            val += p[(i*num_sets + jj)*linesize];
		  }
        }
      }
  }
}


int main(int argc, char ** argv)
{
	struct timeval t1, t2;
	srandom(time(NULL));
	printf("argc = %d\n",argc);
        if(argc == 3)
        {
                ways = atoi(argv[1]);
		stride=atoi(argv[2]);
		//colors =atoi(argv[3]);
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

	access_pattern(stride);
       
	printf("done\n"); 
}
//typcast *p=*buffer
