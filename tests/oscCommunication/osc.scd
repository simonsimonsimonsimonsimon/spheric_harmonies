s.boot;

NetAddr.langPort;
NetAddr.localAddr;

n = NetAddr.new("127.0.0.1", 7771);
o = OSCFunc
(
	{
		arg msg, time, addr, recvPort;
		[msg, time, addr, recvPort].postln;
	},
	'/goodbye', n;
);
