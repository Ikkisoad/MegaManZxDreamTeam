split = 0
split1 = 0
split2 = 0
split3 = 0
RNG = 0
oldRoom = 0
while true do
	oldRNG = RNG
	oldRoom = room
	RNG = memory.readdword(0x2108790)
	room = memory.readbyte(0x2107E28)
	
	gui.text(10,10,RNG)

	if(oldRNG == RNG)then
		split3 = split2
		split2 = split1
		split1 = split
		split = oldRNG
	end
	
	if(oldRoom ~= room)then
		roomRNG = RNG
	end
	
	gui.text(10,40,"Room: " .. room)
	gui.text(10,60,"Lag RNG: " .. split)
	gui.text(10,70,"RNG1: " .. split1)
	gui.text(10,80,"RNG2: " .. split2)
	gui.text(10,90,"RNG3: " .. split3)

	gui.text(10,50,"Room RNG: " .. roomRNG)

    emu.frameadvance()
end