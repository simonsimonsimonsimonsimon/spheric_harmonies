CC = g++
CFLAGS = -Wall -D__UNIX_JACK__

miditest: miditest.cpp ../../rtmidi/RtMidi.h ../../rtmidi/RtMidi.cpp
	$(CC) $(CFLAGS) miditest.cpp ../../rtmidi/RtMidi.cpp -o miditest -ljack

run:
	./miditest

clean:
	rm miditest
