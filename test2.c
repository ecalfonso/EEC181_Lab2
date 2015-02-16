#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void)
 {
	 int array[1000];
	 int * address = (int *)0xC4000000;
		
	// RAM 00;
	//volatile int * sdram		 		=(int *) 0xC4000000;
	//volatile int * hex_led 			=(int *) 0xFF200028;
	
	while(1) 
	{
		int diff, readtime;
		int start, end;
		
		int i=0;
		while(i<1000)
		{
			array[i]= 1;
			i++;
		}
		start = clock(); //start
		int count=0;
		while(count<1000)
		{
			*(address) =array[count];
			*(address) =*(address) +4;
			count++;
		}
		
		end = clock();
		diff = (end-start)/CLOCKS_PER_SEC;
		printf("write time");
		printf("%d\n", diff);
		
		int y = 0;
		while(y<1000)
		{
			array[y]=*(address);
			*(address) =*(address) +4;
			y++;
		}
		
		int n=0;
		while(n<1000)
		{
			//output= *(sdram[n]);
			printf("%d\n", array[n]);
			n++;
		}
		readtime = (clock()-end)/CLOCKS_PER_SEC;
		printf("Read time");
		printf("%d\n", readtime);
	}
	return 0;
}