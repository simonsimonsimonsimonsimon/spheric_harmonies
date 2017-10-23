/* Start the server and the ProxySpace */
(
s.boot;
p = ProxySpace.push(s);
)
/* Server tools */
s.plotTree;
s.freeAll;

/* Quarks */
Quarks.gui;
/*
freq: frequency
att: attack
sus: sustain
rel: release
dec: decay
fb: phase feedback
amp: amplitude
out: output bus
pan: stereo panning
*/
(
  SynthDef(\asdf, {
    arg freq=200, pan=0, amp=0.8, out=0, t_gate=0;
    var sig, env;
    env = XLine.kr(1,0.1,1,t_gate, doneAction:0);
    freq = XLine.kr(880,110,1,doneAction:0);
    sig = SinOsc.ar(freq);
    sig = sig * env;
    Out.ar(out, Pan2.ar(sig, pan, amp))
  }).add;
)
a = Synth.new(\asdf);
a.set(\t_gate, 1);
a.free;

b=XLine.kr(1,0.1,1).plot

Line.kr(1,0,1).plot

Env.linen(1, 2, 3, 0.6, 'sine').test.plot;
Env.linen(1, 2, 3, 0.6, 'welch').test.plot;


(
SynthDef(\gray,
  {arg outBus = 0, freq = 400, amp = 1, dur = 1;
	var env, src, fdbin, fdbout;
	env = EnvGen.kr(Env([0, 1, 0], [0.05, 0.95], \sin), timeScale: dur, levelScale: amp, doneAction: 2);
	src = LPF.ar(GrayNoise.ar(amp), freq, env);
	Out.ar(outBus, Pan2.ar(src, Rand.new(-0.7, 0.7)));
  }).load(s);
)

(
c = TempoClock(1.5); // create a new clock with 1.5 beats-per-second, ie: 1.5 * 60 = 90bpm
c.schedAbs(
	1, // time delay from evaluation (in beats)
	{arg ...args;
		[c.bar, args[0], args[1]].postln; // post current bar, current beat nr and elapsed time
		Synth(\gray); // make some sound
	2.0}); // repeat every second beat
)

c.tempo_(3); // double the tempo
c.elapsedBeats.postln; // you can also ask what the current beat nr is
c.elapsedBeats.ceil; // or get the next beat
c.stop; //stop the clock

(
c = TempoClock(6);
c.schedAbs(1, {arg beat, sec;
	if (beat % 4 == 0, {Synth(\gray, ([freq:5000.rrand(8000), amp:0.25]))});
	if (beat % 4 == 2, {Synth(\gray, ([freq:4000.rrand(5000), amp:0.3]))});
	if (beat % 7 == 0, {Synth(\gray, ([freq:400.rrand(800), amp:0.6]))});
	if (beat % 7 == 2, {Synth(\gray, ([freq:800.rrand(1000), amp:0.55]))});
	if (beat % 7 == 4, {Synth(\gray, ([freq:1000.rrand(3000), amp:0.35]))});
	0.5});
)
c.tempo_(3)
c.stop
