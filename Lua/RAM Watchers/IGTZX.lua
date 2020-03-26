split = 0
HPSpeedTracker = 0
while true do
	oldSpeed = speed
    oldIGT = IGT
	IGT = memory.readdword(0x0215FEA8)
	speed = memory.readdword(0x0214F7D4)
	bossHP = memory.readbyte(0x0214FDE4)
	room = memory.readbyte(0x20F9130)
	
	gui.text(10,10,IGT)
	--gui.text(10,20,IGT/60)
	--gui.text(10,30,IGT/60/60)
	--gui.text(10,40,IGT/60/60/60)

	if(oldIGT == IGT)then
		split = oldIGT
	--	memory.writebyte(0x0214F7B2,30)
	end
	gui.text(10,40,"Room: " .. room)
	gui.text(10,50,"Split: " .. split)
	
	gui.text(10,60,"Speed: " .. speed)
	print(IGT)
	if(speed~=oldSpeed)then
		gui.text(10,82,"Failed Chain")
	end
	
	gui.line(11, 70, bossHP+11, 70, 'yellow')
	gui.text(10,70,"Boss: " .. bossHP)
	
	if(speed>800)then
		gui.line(10, 80, 100, 80, 'green')
		gui.line(10, 81, 100, 81, 'green')
		gui.line(10, 82, 100, 82, 'green')
		gui.line(10, 83, 100, 83, 'green')
		if(HPSpeedTracker == 1)then
			memory.writebyte(0x0214F7B2,16)
		end
	elseif(speed<800 and speed>500)then
		gui.line(10, 80, 70, 80, 'yellow')
		gui.line(10, 81, 70, 81, 'yellow')
		gui.line(10, 82, 70, 82, 'yellow')
		gui.line(10, 83, 70, 83, 'yellow')
		if(HPSpeedTracker == 1)then
			memory.writebyte(0x0214F7B2,8)
		end
	elseif(speed<500 and speed>127)then
		gui.line(10, 80, 30, 80, 'red')
		gui.line(10, 81, 30, 81, 'red')
		gui.line(10, 82, 30, 82, 'red')
		gui.line(10, 83, 30, 83, 'red')
		if(HPSpeedTracker == 1)then
			memory.writebyte(0x0214F7B2,4)
		end
	else
		gui.line(10, 80, 20, 80, 'black')
		gui.line(10, 81, 20, 81, 'black')
		gui.line(10, 82, 20, 82, 'black')
		gui.line(10, 83, 20, 83, 'black')
	end
	
	--memory.writebyte(0x020F3DDA,24)
	--memory.writebyte(0x0214F848,50) --Current Animation Address
	--memory.writeword(0x0214F7D4,500) --S P E E D
	--memory.writeword(0x0214F7DC,500)
    emu.frameadvance()
end