#include "singleperson.h"

singleperson::singleperson()
{
  uuid_seed = 0;
  ps = new std::list<p*>();
}

singleperson::~singleperson()
{
  for(std::list<p*>::iterator it=ps->begin();it!=ps->end();it++)
    delete (*it);
  delete ps;
}

osc::OutboundPacketStream singleperson::reset(char *buffer,unsigned int OUTPUT_BUFFER_SIZE)
{
  char name_buffer[50];
  osc::OutboundPacketStream obps(buffer,OUTPUT_BUFFER_SIZE);
  for(std::list<p*>::iterator it=ps->begin();it!=ps->end();it++)
  {
    memset(name_buffer,' ',50);
    snprintf(name_buffer,50,"/person%lu",(*it)->uuid);
    obps << osc::BeginMessage(name_buffer)
         << 'd' << ((*it)->uuid) << 440.00
	 << osc::EndMessage;

    delete (*it);
  }  
  ps->clear();
  return obps;
}

osc::OutboundPacketStream analyse_frame(std::list<std::pair<int,int>>::const_iterator b,
					std::list<std::pair<int,int>>::const_iterator e,
					char *buffer,unsigned int OUTPUT_BUFFER_SIZE)
{
  char name_buffer[50];
  osc::OutboundPacketStream obps(buffer,OUTPUT_BUFFER_SIZE);
  std::list<p*> custom_ps = new std::list<p*>(ps);
  ps->clear();

  obps << BeginBundleImmediate;
  for(std::list<std::pair<int,int>>::const_iterator it=b;it!=e;it++)
  {
    std::list<p*>::iterator found_so = find_closest((*it).first,(*it).second,custom_ps);
    if( found_so != custom_ps->end() )
    {
      (*found_so)->transform((*it).first,(*it).second);

      memset(name_buffer,' ',50);
      snprintf(name_buffer,50,"/person%lu",(*found_so)->uuid);
      obps << osc::BeginMessage(name_buffer)
	   << 't' << ((*found_so)->uuid) << p2freq((*found_so))
	   << osc::EndMessage;
      
      custom_ps->erase(found_so);
      ps->push_back((*found_so));
    }
    else
    {
      p* newp = new p((*it).first,(*it).second,uuid_seed);
      uuid_seed += 1;

      memset(name_buffer,' ',50);
      snprintf(name_buffer,50,"/person%lu",newp->uuid);
      obps << osc::BeginMessage(name_buffer)
	   << 'c' << newp->uuid << p2freq(newp)
	   << osc::EndMessage;

      ps->push_back(newp);
    }
  }
  for(std::list<p*>::iterator it=custom_ps->begin();it!=custom_ps->end();it++)
  {
    memset(name_buffer,' ',50);
    snprintf(name_buffer,50,"/person%lu",(*it)->uuid);
    obps << osc::BeginMessage(name_buffer)
         << 'd' << ((*it)->uuid) << 440.00
	 << osc::EndMessage;

    delete (*it);
  }
  obps << osc::EndBundle;
  delete custom_ps;
  return obps;
}

std::list<p*>::iterator singleperson::find_closest(int lb,int rb,std::list<p*> custom_ps)
{
  if(!custom_ps->empty())
  {
    std::list<p*>::iterator rtn = custom_ps->begin();
    double rating = pow((*rtn)->l-lb,2)+pow((*rtn)->r-rb,2);
    for(std::list<p*>::iterator it=std::next(rtn);it!=custom_ps->end();it++)
    {
      double it_rating = pow((*it).l-lb,2)+pow((*it).r-rb,2);
      if(it_rating < rating)
      {
	rtn = it;
	rating = it_rating;
      }	
    }
    return rtn;
  }
  return custom_ps->end();
}

double singleperson::p2freq(p* ind)
{
  return (((double)p->l)+((double)p->r))*0.5;
}
