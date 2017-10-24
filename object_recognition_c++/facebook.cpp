#include "facebook.h"

facebook::facebook()
{
  uuid_seed = 0;
  faces = new std::list<face>();
}

facebook::~facebook()
{
  for(std::list<face*>::iterator it=faces->begin();it!=faces->end();it++)
    delete (*it);
  delete faces;
}

void facebook::extractFaces(std::list<std::pair<int,int>>::const_iterator b,std::list<std::pair<int,int>>::const_iterator e)
{
  std::list<face*> *cfaces = new std::list<face*>(faces*);
  for(std::list<std::pair<int,int>>::const_iterator it=b;it!=e;it++)
  {
    face* found_him;
    if(find_closest_face((*it).first,(*it).second),found_him,cfaces))
    {
      //send: transform + delete from custom faces;
    }
    else
    {
      //send: create new + seed++;
    }
  }
  if(!cfaces->empty())
  {
    for(std::list<face*>::iterator it=cfaces->begin();it!=cfaces->end();it++)
    {
      //send: delete;
    }
  }
  return;
}

bool facebook::find_closest_face(int lb,int rb,face* rtn,std::list<face*> *cfaces)
{
  if(!cfaces->empty())
  {
    rtn = cfaces->front();
    double rating = pow(cfaces->front()->l-lb,2)+pow(cfaces->front()->r-rb,2);
    for(std::list<face*>::iterator it=std::next(cfaces->begin());it!=cfaces->end();it++)
    {
      double var = pow((*it)->l-lb,2)+pow((*it)->r-rb,2);
      if(var < rating)
      {
        rtn = (*it);
        rating = var;
      }
    }
    return true;
  }
  return false;
}
