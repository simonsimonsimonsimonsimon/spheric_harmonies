(
SynthDef.new(\sine, {
	arg freq=220, atk=0.005, rel=0.5, amp=0.8, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	sig = SinOsc.ar(freq+6);
	sig = SinOsc.ar(freq * 2);
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(0, sig);
}).add;
)

s.start

Server.default.makeWindow



(
p = Pbind(
	\instrument, \sine,
	\dur, Pseq([0.6,0.6,0.3,0.1,0.4,0.9],inf),
	\freq, Pseq([[50,53,57],[52,67,71],[45,67,61]].midicps,inf)
).play;
)

s.reboot;
s.hardFreeAll;
