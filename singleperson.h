#ifndef SINGLEPERSON_H
#define SINGLEPERSON_H
#include <list>
#include <cstring>
#include <cstdio>
#include "oscmodus.h"
class singleperson : public oscmodus
{
public:
  singleperson();
  ~singleperson();
private:
  unsigned int uuid_seed;
  class p
  {
  public:
    p(int l2,int r2,int uuid2) : l(l2) , r(r2) , uuid(uuid2) {}
    void transform(int l2,int r2)
    {
      l = l2;
      r = r2;
    }
    int l;
    int r;
    unsigned int uuid;
  };
  std::list<p*> *ps;
  std::list<p*>::iterator find_closest(int lb,int rb,std::list<p*> custom_ps);
  double p2freq(p* ind);
};
#endif
