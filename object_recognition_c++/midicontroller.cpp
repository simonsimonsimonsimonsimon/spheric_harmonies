#include "midicontroller.h"
#include <iostream>
#include <lo/lo.h>

using namespace std;

void mycallback( double deltatime, std::vector< unsigned char > *message, void *userData)
{
  unsigned int nBytes = message->size();
  for ( unsigned int i=0; i<nBytes; i++ )
    std::cout << "Byte " << i << " = " << (int)message->at(i) << ", ";
  if ( nBytes > 0 )
    std::cout << "stamp = " << deltatime << std::endl;
  relief * relObj = (relief *) userData;
  if(message->size() == 3)
  {
    switch(message->at(1))
    {
      case 77:
        relObj->setMVarianceThreshold(message->at(2));
        cout<<"Setting variance threshold to: "<<relObj->getVarianceThreshold()<<"."<<endl;
        break;
      case 78:
        relObj->setMVarianceRange(message->at(2));
        cout<<"Setting variance range to: "<<relObj->getVarianceRange()<<"."<<endl;
        break;
      case 79:
        relObj->setMGaussianSigma(message->at(2));
        cout<<"Setting gaussian sigma to: "<<relObj->getGaussianSigma()<<"."<<endl;
        break;
      case 80:
        relObj->setMGaussRange(message->at(2));
        cout<<"Setting gauss range to: "<<relObj->getGaussRange()<<"."<<endl;
        break;
      case 81:
        relObj->setMGroupLength(message->at(2));
        cout<<"Setting group length to: "<<relObj->getGroupLength()<<"."<<endl;
        break;
      case 82:
        relObj->setMIndVarThreshold(message->at(2));
        cout<<"Setting individual variance threshold to: "
            <<relObj->getIndVarThreshold()<<"."<<endl;
        break;
      case 83:
        relObj->setMIndVarRange(message->at(2));
        cout<<"Setting individual variance range to: "
            <<relObj->getIndVarRange()<<"."<<endl;
        break;
      case 84:
        relObj->setMHSize(message->at(2));
        cout<<"Setting human size to: "
            <<relObj->getHSize()<<"."<<endl;
        break;
      default:
        cout<<"Unused controll encountered."<<endl;
        break;
    }
  }
  else
  {
    cout<<"it doesnt fit"<<endl;
  }
}

midicontroller::midicontroller(relief *rel)
{
  this->rel = rel;
  this->midiin = new RtMidiIn();
  init();
}

midicontroller::~midicontroller()
{
  midiin->closePort();
  delete midiin;
}

void midicontroller::init()
{
  unsigned int nPorts = midiin->getPortCount();
  cout << "nPorts: " + nPorts;
  if ( nPorts == 0 ) {
    std::cout << "No ports available!\n";
  }
  this->midiin->setCallback( &mycallback , rel);
  this->midiin->openPort(portNumber);
}
