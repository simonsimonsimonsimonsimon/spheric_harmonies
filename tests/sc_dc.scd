(
b = Buffer.read(s, "/home/nando/supercollider/audio/TR808WAV/BD/BD1010.WAV");
d = Buffer.read(s, "/home/nando/supercollider/audio/TR808WAV/SD/SD1010.WAV");
)

Platform.userExtensionDir;

Quarks.gui;


(
x = SynthDef(\kick,{arg out = 0, bufnum;
	Out.ar( out,
		PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum))
	)
}).play(s,[\bufnum, b.bufnum]);
)

s.start;

(
y = SynthDef(\snare,{arg out = 0, bufnum;
	Out.ar( out,
		PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum))
	)
}).play(s,[\bufnum, d.bufnum]);
)

(
SynthDef.new(\sine, {
	arg freq=220, atk=0.005, rel=0.3, amp=0.8, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
	sig = SinOsc.ar(freq+6);
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	Out.ar(0, sig);
}).add;
)

s.boot

(
a = Pseq ([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1],inf);
b = Pseq ([0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0],inf);
//c = Pseq([[50,53,57],[52,67,71],[45,67,61]].midicps,inf);

p = Ppar(
	[a,b].collect { |pattern, i|
		Pbind(
			\instrument, [\kick, \snare].at(i),
			\dur, 0.30,
			\amp, 0.1,
			\noteOrRest, Pif(pattern > 0, 1, Rest)
		)
	}
).play;
)









x.free; b.free; y.free; sd.free;
