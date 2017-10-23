(
s.boot;
s.options.numOutputBusChannels = 2;
s.options.numInputBusChannels = 0;
)
s.reboot;
s.plotTree;
s.meter;

/* Groups
 *
 */
(
~master = Group.new;
~sources = Group.after(~master);
~effects = Group.after(~sources);
)

/* master */
(
SynthDef.new(\master, {
	arg in, amp=0.8, out=0;
	var sig;
	sig = In.ar(in,2) * amp;
	Out.ar(out, sig);
}).add;
)


/* Sources
 */

(
SynthDef.new(\delay, {
	arg delaytime = 0.1, in;
	var sig, effect;
	sig = In.ar(in,2);
	effect = DelayN.ar(sig, 1, delaytime);
	Out.ar(0, effect);
}).add;
)

(
SynthDef.new(\chorus, {
	arg in, out;
	var sig, effect;
	sig = In.ar(in,2);
	effect = DelayC.ar(sig, 0.01, SinOsc.ar(Rand(5,10), 0,0.0025,0.0075));
	Out.ar(out, effect);
}).add;
)

(
SynthDef.new(\synth1, {
	arg amp=0.1, freq1=110, freq2=12, out;
	var in, pulse;
	pulse = LFNoise0.kr(freq2);
	in = SinOsc.ar(freq1) * pulse * amp;
	Out.ar(out, Pan2.ar(in));
}).add;
)

~s1out = 0;

(
SynthDef.new(\synthTest, {
	arg amp=0.3;
	var in;
	in = SinOsc.ar(110) * amp;
	Out.ar(0, in);
}).play
)

(
x = Synth.new(\synth1,[\out, ~s1out], ~sources, \addToHead);
y = Synth.new(\chorus, [\in, ~sawsBus, \out, ~effectBus], ~effects, \addToHead);
z = Synth.new(\master, [\in, ~effectBus], s, \addToTail);
)
x.set(\out, 0);
x.set(\amp, 0.6);
x.set(\freq2, 7);
x.set(\freq1, 220);

s.scope;
(
x.free;
y.free;
z.free;
)
~sawsBus = Bus.audio(s, 2);
~effectBus = Bus.audio(s,2);
z.set(\amp, 0.9);


MIDIClient.init;
MIDIIn.connectAll;
MIDIClient.sources;
MIDIdef.freeAll;


MIDIdef.noteOn(\noteOnTest, {"key down".postln});
(
MIDIdef.noteOn(\test, {
	arg vel, nn, chan, src;
	[vel, nn].postln;
	~notes[nn] = Synth.new(\tone,
		[
			\freq, nn.midicps,
			\amp, vel.linexp(1,127,0.01,03),
			\gate, 1,
		]
	);
});

MIDIdef.noteOff(\noteOffTest, {
	arg vel, nn;
	[vel, nn].postln;
	~notes[nn].set(\gate, 0);
	~notes[nn] = nil;
});
)


(
SynthDef.new(\tone, {
	arg freq=440, amp=0.3, gate=0;
	var sig, env;
	sig = LFTri.ar(freq)!2;
	env = EnvGen.kr(Env.adsr, gate, doneAction:2);
	sig = sig * env * amp;
	Out.ar(0, sig);
}).add;
)

~note = Array.newClear(128);













































