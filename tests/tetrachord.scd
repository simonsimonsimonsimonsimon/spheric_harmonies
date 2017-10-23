p = ProxySpace.push(s);

StageLimiter.activate;


(
SynthDef.new(\sine, {
	arg freq=220, atk=0.005, rel=0.5, amp=2, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
  sig = SinOsc.ar(freq * 2);
  env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp*10);
	Out.ar(0, sig);
}).add;
)

s.reboot;

(
~a = Pbind(
	\instrument, \sine,
	\dur, Pseq([1,1,1,1,1,1,1,1],inf),
	\freq, Pseq([50,60,53,55,50,51,52,55].midicps,inf)
  );
)
