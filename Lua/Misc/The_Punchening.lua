while true do
	if memory.readbyte(0x021041D0) < 32 then
		memory.writebyte(0x021041D0, 32)
	end
	if joypad.get(1).Y then
		memory.writebyte(0x0214F838, 120)
	end
	if joypad.get(1).R then
		memory.writebyte(0x0214F839, 120)
	end
	if ((memory.readbyte(0x020F9130) ~= 16) or (memory.readbyte(0x020F031C) ~= 60)) then 
		if (memory.readbyte(0x0214F874) == 1) or (memory.readbyte(0x0214F874) == 2) then
			memory.writebyte(0x0214f874, 4)
		end
	end
	memory.writebyte(0x021041CF, 0)
	if (memory.readbyte(0x021041D0) % 2) ~= 0 then
		memory.writebyte(0x021041D0, memory.readbyte(0x021041D0) - 1)
	end
	emu.frameadvance()
end