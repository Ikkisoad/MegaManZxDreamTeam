cArea = 0
while true do
	old=cArea
	cArea = memory.readbyte(0x020F9130)
	gui.text(10,20,cArea)
	
	if(cArea ~= old)then
		print(cArea)
	end

	emu.frameadvance()
end