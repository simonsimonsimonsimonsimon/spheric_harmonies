#ifndef FACEBOOK_H
#define FACEBOOK_H
#include <list>
#include <utility>
#include <cmath>
class facebook
{
 public:
  facebook();
  ~facebook();
  void extractFaces(std::list<std::pair<int,int>>::const_iterator b,std::list<std::pair<int,int>>::const_iterator e);
  class command
  {
  };
 private:
  unsigned int uuid_seed;
  class face
  {
    int l;
    int r;
    int dir;
    unsigned int uuid;
  };
  std::list<face*> *faces;
  bool find_closest_face(int lb,int rb,face* rtn,std::list<face*> *cfaces);
};
#endif
