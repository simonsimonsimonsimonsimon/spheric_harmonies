s.boot;

s.plotTree;

s.reboot;

(
SynthDef.new(\synth1, {
	arg out, amp;
	var freq, sig, env;
	env = EnvGen.kr(Env.new([0.01,1,0.01],[0.001,2], \exp), doneAction:2);
	freq = SinOsc.ar(ExpRand(200,1000)!2) * env;
	sig = freq;
	Out.ar(out, sig);
}).add;
)

Env.new([0.1,1,0.1],[0.001,2],\exp).plot;

(
SynthDef.new(\rev1, {
	arg in, out=0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 0.3, 0.2);
	Out.ar(out, sig);
}).add;
)

~s1 = Synth.new(\synth1, [\out, 16]);
~r1 = Synth.new(\rev1, [\in, 16, \out, 0]);
~e1 = Synth.new(\env1, [\in, 16, \out, 0]);

(
p = Pbind(
	~s1, \sine,
	\dur, Pseq([0.6,0.6,0.3,0.1,0.4,0.3],inf),
	\freq, Pseq([[50,53,57],[52,67,71],[45,67,61]].midicps,inf),
	\bus, 16,
).play;
)
























