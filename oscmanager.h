#ifndef OSCMANAGER_H
#define OSCMANAGER_H

#include <vector>
#include <ip/UdpSocket>
#include "oscmodus.h"
#include "singleperson.h"

class oscmanager
{
public:
  oscmanager();
  ~oscmanager();

  void sendOut(std::list<std::pair<int,int>>::const_iterator b,
	       std::list<std::pair<int,int>>::const_iterator e);
  void switch_modus();
private:
  vector<oscmodus*> *av_modi;
  vector<oscmodus*>::iterator modus_op;

  UdpTransmitSocket* socket;

  const char[] address = "127.0.0.1";
  const unsigned int port = 57120;
  const unsigned int buff_size = 2048;
};
#endif
