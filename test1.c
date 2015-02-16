#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	// RAM 00;
	volatile int * hex		 		=(int *) 0xFF200000;
	volatile int * hex_led 			=(int *) 0xFF200028;
	
	int i, n, len, quit;
	char string[10];
	
	while(1) 
	{
		printf("Enter an integer: ");
		scanf("%s", string);

		len = strlen(string);
		if (len > 10) 
		{
			printf("Please input a number that fits 32-bits\n");
			continue;
		}

		for(n = 0; n < len; n++) 
		{
			if (string[n] < '0' || string[n] > '9') 
			{
				printf("Please input a valid number\n");
				continue;
			}
		}

		i = atoi(string);
		
		// Load into hex register
		*(hex) = i;
		*(hex_led) = i;
		
		printf("Do you want to quit? Yes = 1, No = 0: ");
		scanf("%d", &quit);
		if (quit == 1)
		{
			printf("Cya.\n");
			break;
		}
		else if (quit == 0)
			continue;
		else
			printf("Invalid input. Try again.\n");
			continue;
	}
}