while true do
	gui.text(10,30,"Room: " .. memory.readbyte(0x02177D6C))
	emu.frameadvance()
end