#include <stdbool.h>
#include <stdio.h>
#include <stdbool.h>
#include "charIsValid.S"

extern bool charIsValid(int c);

int main(){
  int i = 0;
  int j;
  while(i < 50){
    int c = getc(stdin);
    j = charIsValid(c);
    printf("%d\n",j);
    i++;
  }
}