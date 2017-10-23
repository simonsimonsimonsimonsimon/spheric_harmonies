/* test instruments */
a = Pbind(
  \instrument, \hah,
  \dur, Pseq([1,1,1,0.5,0.5], inf),
  \freq, Pseq([38,40,38,40,37].midicps, inf),
  \amp, 0.8
  );
a.set("amp", 0.8);
a.play;
a.stop;


/* \bplay is used to play audio buffers */
SynthDef(\bplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;

(
SynthDef(\test1, {
	arg freq = 400, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.5, out = 0, pan = 0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk, sus, rel),1,1,0,1,2, doneAction:2);
	amp = SinOsc.kr(120/60,0,1);
	sig = SinOscFB.ar(freq, fb, 1);
	sig = amp * sig * env;
	Out.ar(out, Pan2.ar(sig, pan, amp));
	}).add;
);

(
SynthDef(\hah,{
  arg freq=200, out=0, amp=0.8, pan=0;
  var env, sig;
  env = EnvGen.ar(Env.new([0.1,1,0.1],[0.1,1],\exp), doneAction: 2);
  sig = LFCub.ar(freq);
  sig = sig * env;
  Out.ar(out, Pan2.ar(sig, pan, amp));
  }).add;
)
