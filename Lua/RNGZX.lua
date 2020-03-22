split = 0
split1 = 0
split2 = 0
split3 = 0
RNG = 0
while true do
	oldRNG = RNG
	RNG = memory.readdword(0x2108B90)
	room = memory.readbyte(0x2108228)
	
	gui.text(10,10,RNG)

	if(oldRNG == RNG)then
		split = oldRNG
		split1 = split
		split2 = split1
		split3 = split2
	end
	gui.text(10,40,"Room: " .. room)
	gui.text(10,50,"RNG: " .. split)
	gui.text(10,60,"RNG1: " .. split1)
	gui.text(10,70,"RNG2: " .. split2)
	gui.text(10,80,"RNG3: " .. split3)

    emu.frameadvance()
end