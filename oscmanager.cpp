#include "oscmanager.h"

oscmanager::oscmanager()
{
  av_modi = new vector<oscmodus*>();
  av_modi->push_back(new singleperson());
  
  modus_op = av_modi->begin();

  socket = new UdpTransmitSocket( IpEndpointName(address,port) );
}

oscmanager::~oscmanager()
{
  for(vector<oscmodus*>::iterator it=av_modi->begin();it!=av_modi->end();it++)
    delete (*it);
  delete av_modi;
  delete socket;
}

void oscmanager::sendOut(std::list<std::pair<int,int>>::const_iterator b,
			 std::list<std::pair<int,int>>::const_iterator e)
{
  char buffer[buff_size];
  osc::OutboundPacketStream obps = (*modus_op)->analyse_frame(b,e,buffer,buff_size);
  socket.Send( obps.Data() , obps.Size() );
}

void oscmanager::switch_modus()
{
  char buffer[buff_size];
  osc::OutboundPacketStream obps = (*modus_op)->reset(buffer,buff_size);
  socket.Send( obps.Data() , obps.Size() );
  
  modus_op++;
  if(modus_op == av_modi->end())
    modus_op = av_modi->begin();
  return;
}
