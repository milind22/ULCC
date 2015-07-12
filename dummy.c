#include <stdio.h>

extern float val1, val2;

void dummy(unsigned long long int val)
{
printf("%llu %f %f \n",val,val1,val2);
printf("%llu  \n",val);
}
