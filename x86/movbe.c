#include <stdio.h>

int main(int argc, const char *argv[])
{
  int i = 0x12345678;
  printf("%8x\n",i);
  asm ( "movbe %1, %0" 
      : "=r"(i)
      : "r"(i)
      : 
      );
  printf("%8x\n",i);

  return 0;
}
