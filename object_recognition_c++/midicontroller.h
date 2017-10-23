#ifndef MIDICONTROLLER_H
#define MIDICONTROLLER_H
#include "rtmidi/RtMidi.h"
#include "Relief.h"
class midicontroller
{
  public:
    midicontroller(relief *rel);
    ~midicontroller();
    RtMidiIn *midiin;
  void init();
  private:
  relief *rel;
  unsigned int portNumber=0;
};
#endif
