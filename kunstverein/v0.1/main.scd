("../quarks.scd").loadRelative;
("../setup.scd").loadRelative;

s.reboot
s.boot

~test = Pbind(\instrument, \test1, \freq, Pseq([54].midicps,inf), \dur, Pseq([0.5,Pseq([4],inf)],inf), \amp, 0.5, \sus, 0.01, \atk,0.02, \rel, 0.5);
~test = Pbind(\instrument, \test1, \freq, Pseq([50,45,43,46].midicps,inf), \dur, Pbjorklund2(Pseq([8,8,8,8],inf),32), \amp, Pseq([0.3,0.7,0.8,0.8], inf), \sus, 0.8, \atk,0.0001, \rel, 4);
~test.play(fadeTime: 10);
~test.stop(fadeTime: 10);
~test.stop

~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,2,\amp,1);
~k.set("quant", 1);
~k.play
~k = Pbind(\instrument,\bplay,\buf,d["k"][3],\dur,2,\amp,1).play(quant: 1);
~k = Pbind(\instrument,\bplay,\buf,d["k"][3],\dur,Pbjorklund2(Pseq([3,3,3,5],inf),8)/4,\amp,1,\rate,Pseq([1,1.2],inf));
~k.play(TempoClock, quant: 1);
~k.stop(fadeTime: 8);
~k.play

~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,2,\amp,1,\bufnum,100, \rate,Pseq([1,1.2],inf));
~sn.set("quant", 1);
~sn.play
~sn.stop
~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,4,\amp,1,\bufnum,100, \rate,Pseq([1,1.2],inf)).play(quant: 2);
~sn.play.quant_(1);
~sn.stop(fadeTime: 8)

~hh = Pbind(\instrument,\bplay,\buf,d["h"][2],\dur,0.25,\amp,Pwhite(0.25,1));
~hh.play(fadeTime: 20)
~hh.stop(fadeTime: 10);

~hc =
Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pseq([0.5,Pseq([4],inf)],inf),\amp,Pwhite(0.25,1));
~hc.play(fadeTime: 20);
~hc.stop;



~sines = {SinOscFB.ar([36.midicps,48.midicps+1],SinOsc.kr(0.1).range(0.1,1),0.1)}
~sines.play
~sines.stop



SynthDef(\smooth, { |freq = 440, sustain = 1, amp = 0.7|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.linen(0.05, sustain, 0.1), doneAction: 2);
    Out.ar(0, sig ! 2)
}).add;

~mel = Pbind (
	\instrument, \smooth,
	\freq, Pseq([[50,53,57],[49,52,57]].midicps, inf),
	/*\freq, Pseq([50,53,57,49].midicps,inf),*/
	\dur, Pseq([8,8],inf),
)
~mel.play;

(
SynthDef(\bass, {
	arg freq=220, amp=1, dur=0.2, gate=1, a=0.1, d=0.1, s=0.1, r=0.1;
	var sig, env, env_gen;
	env = Env.adsr(a, d, s, r, amp);
  env_gen = EnvGen.kr(env, gate, doneAction: 2);
	sig = SinOscFB.ar(freq) * EnvGen.kr(env_gen);
	Out.ar(0, sig ! 2);
	}).add;
)

~tb = Pbind (
	\instrument, \bass,
	\dur, Pseq([1], inf),
	/*\freq, Pseq([38].midicps, inf),*/
	/*\amp, Pwhite(0.25,1),*/
	)
~tb.play;

SynthDef("harpsichord1", { arg out = 0, freq = 440, amp = 0.1, pan = 0;
    var env, snd;
	env = Env.perc(level: amp).kr(doneAction: 2);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

// add more harpsichord SynthDefs here...
// "harpsichord2", "harpsichord3", etc.


~a = Pbind(
	\instrument, "harpsichord1",
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, [-7, -3, 0, 2, 4, 6], 7], 1),
	\amp, Pseq([Pn(0.1, 8), 0.06]),
	\dur, Pseq([0.3, Pn(0.1, 6), 1.3, 1], inf),
	\strum, 0.09
)

~a.play;








(
SynthDef(\sine, {
	arg freq=220, atk=0.005, rel=0.5, amp=2, pan=0;
	var sig, env;
	sig = SinOsc.ar(freq);
  sig = SinOsc.ar(freq * 2);
  env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]), doneAction:2);
	sig = Pan2.ar(sig, pan, amp*10);
	Out.ar(0, Pan2(sig, pan));
}).add;
)

(
~a = Pbind(
	\instrument, \sine,
	\dur, Pseq([1,1,1,1,1,1,1,1],inf),
	\freq, Pseq([50,60,53,55,50,51,52,55].midicps,inf)
  );
)

~a.play;
(
  n = NetAddr(\localhost.asString, 7779);
  n.postln;
  o = OSCFunc({|msg, time, from, port| msg.postln}, '/Grace', nil, 57120);
)
OSCFunc.trace(false);

b = NetAddr.new("127.0.0.1", 7771);    // create the NetAddr
b.sendMsg("/hello", "there");    // send the application the message "hello" with the parameter "there"


~recv = NetAddr.langPort;
~recv.value();


thisProcess.openPorts;
o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/goodbye', ~recv);


s.reboot
