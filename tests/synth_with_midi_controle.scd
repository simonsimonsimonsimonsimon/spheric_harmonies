MIDIClient.init;
MIDIIn.connectAll;

(
MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	[vel, nn, src].postln;
	~notes[nn] = Synth.new(
		\tone, [
			\freq, nn.midicps,
			\amp, ~amp.linexp(0, 127, 0.05, 0.1),
			\gate, 1,
			\bend, ~bend.linlin(0,16383, -2,2),
			\att, ~att.linlin(0,127,0.01,5),
			\sus, ~sus.linlin(0,127,0.01,5),
			\dec, ~dec.linlin(0,127,0.01,5),
			\rel, ~rel.linlin(0,127,0.01,5),
			\off, ~off.linlin(0,127,1,20),
		]
	);
}, srcID:1310720);

MIDIdef.noteOff(\noteOffTest, {
	arg vel, nn;
	[vel, nn].postln;
	~notes[nn].set(\gate, 0);
	~notes[nn] = nil;
});

MIDIdef.bend(\bendTest, {
	arg val, chan, src;
	//[val, chan, src].postln;
	~bend = val;
	~notes.do{arg synth; synth.set(\bend, val.linlin(0,16383, -2, 2))};
});

MIDIdef.cc(\syntAtt, {
	arg val, nn, chan, src;
	//[val, nn, chan, src].postln;
	~att=val;
	~notes.do{arg synth; synth.set(\att, val.linlin(0,127,0.01,5))};
}, srcID:1835008, ccNum:49);

MIDIdef.cc(\synDec, {
	arg val, nn, chan, src;
	//[val, nn, chan, src].postln;
	~dec = val;
	~notes.do{arg synth; synth.set(\dec, val.linlin(0,127,0.01,5))};
}, srcID:1835008, ccNum:50);

MIDIdef.cc(\synSus, {
	arg val, nn, chan, src;
	//[val, nn, chan, src].postln;
	~sus = val;
	~notes.do{arg synth; synth.set(\sus, val.linlin(0,127,0.01,5))};
}, srcID:1835008, ccNum:51);

MIDIdef.cc(\synRel, {
	arg val, nn, chan, src;
	//[val, nn, chan, src].postln;
	~rel = val;
	~notes.do{arg synth; synth.set(\rel, val.linlin(0,127,0.01,5))};
}, srcID:1835008, ccNum:52);

MIDIdef.cc(\synOff, {
	arg val, nn, chan, src;
	[val, nn, chan, src].postln;
	~off = val;
	~notes.do{arg synth; synth.set(\off, val.linlin(0,127,1,20))};
}, srcID:1835008, ccNum:53);

MIDIdef.cc(\synAmp, {
	arg val, nn, chan, src;
	//[val, nn, chan, src].postln;
	~amp = val;
	~notes.do{arg synth; synth.set(\amp, val.linlin(0,127,0.01,0.3))};
}, srcID:1835008, ccNum:77)

)

MIDIFunc.trace(false);

(
~att = 0.01;
~dec = 0.01;
~sus = 0.01;
~rel = 2;
~bend = 8192;
~amp = 0.5;
~off = 4;
)

Env.adsr(~att, ~dec, ~sus, ~rel).plot;

(
SynthDef.new(\tone, {
	arg freq=440, amp=0.1, gate=0, bend=0, att=0.01, dec=0.3, sus=0.5, rel=0.01, off=4;
	var sig, src, env, gen, mod, lpf;
	mod = FSinOsc.ar((freq + off) * bend.midiratio);
	src = LFTri.ar(freq * bend.midiratio, add:mod)!2;
	env = Env.adsr(att, dec, sus, rel);
	gen = EnvGen.kr(env, gate, doneAction:2);
	src = src * gen * amp;
	src = LPF.ar(src, 1400);
	src = HPF.ar(src, 800);
	Out.ar(0,sig);
}).add;
)

~notes = Array.newClear(128);

(
p = Pbind(
	\instrument, \tone,
).play;
)
p.stop;

x = Synth.new(\tone, [\gate, 1]);
x.set(\gate, 0);


MIDIdef.cc(\controlTest, {"cc".postln});
MIDIdef.bend(\bendTest, {"bended".postln});