#include <stdio.h>

void display(int , int);

int main(){
	int ageArray[4] = {2, 15, 4, 6};
	int size = sizeof(ageArray) / sizeof(ageArray[0]);

	display(ageArray[0], size);

	return 0;
}

void display(int age, int size){
	printf("%d\n", age);
	printf("Size of the array is %d\n", size);
}
