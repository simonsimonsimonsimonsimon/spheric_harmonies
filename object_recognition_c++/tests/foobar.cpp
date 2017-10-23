#include <list>
#include <iostream>
using namespace std;
int main(int argc,char **argv)
{
  int i = 5;
  int& x = i;
  cout << (int) x;
  return 0;
}
