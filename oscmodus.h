#ifndef OSCMODUS_H
#define OSCMODUS_H
#include <list>
#include <utility>
#include <osc/OscOutboundPacketStream>
//abstract
class osc_modus
{
public:
  virtual osc::OutboundPacketStream reset(char *buffer,unsigned int OUTPUT_BUFFER_SIZE) = 0;
  virtual osc::OutboundPacketStream analyse_frame(std::list<std::pair<int,int>>::const_iterator b,
						  std::list<std::pair<int,int>>::const_iterator e,
						  char *buffer,unsigned int OUTPUT_BUFFER_SIZE) = 0;
};
#endif
