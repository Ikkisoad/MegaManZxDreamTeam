math.randomseed(17) --This seed guarantees Bifrost first
fight = 0
Y = 0
randomized = 0
model = 0
oldRoom = 0
CurrentRoom = 0
deathRandomization = 0
i = 0
--128 512 896

function randomize()
	n = math.random(0,17)
	if(n == 1 or n == 7)then
		randomize()
		return
	end
	if(n == 11 and fight == 0 and (CurrentRoom ~= 15 and CurrentRoom ~= 24 and CurrentRoom ~= 25 and CurrentRoom ~= 8))then --Rosepark exceptions
		randomize()
		return
	end
	if(n == 16 and (CurrentRoom ~= 5) and fight == 0)then --Bifrost exceptions
		randomize()
		return
	end
	if((n == 10) and (CurrentRoom ~= 37 and CurrentRoom ~= 59))then --Chronoforce exceptions
		randomize()
		return
	end
	if((n == 0) and (CurrentRoom == 37 or CurrentRoom == 48 or CurrentRoom == 14 or CurrentRoom == 17 or CurrentRoom == 33 or CurrentRoom == 54))then --Human Exceptions
		randomize()
		return
	end
	if((n == 17) and (CurrentRoom == 14 or CurrentRoom == 15 or CurrentRoom == 12 or CurrentRoom == 39 or CurrentRoom == 33))then --Model a Exceptions
		randomize()
		return
	end
	if((CurrentRoom == 11 or CurrentRoom == 52 or CurrentRoom == 7 or CurrentRoom == 32 or CurrentRoom == 62 or CurrentRoom == 15 or CurrentRoom == 20 or CurrentRoom == 27 or CurrentRoom == 44 or CurrentRoom == 6 or CurrentRoom == 37) and (n == 0 or n == 12 or n == 14 or n == 16) and fight == 0)then --Room needs walljump
		randomize()
		return
	end
	if((CurrentRoom == 34 or CurrentRoom == 36 or CurrentRoom == 15 or CurrentRoom == 27) and (n == 17 or n == 14 or n == 12 or n == 0))then --Impossible jump
		randomize()
		return
	end
	if((CurrentRoom == 15 or CurrentRoom == 16) and (n ~= 9 or n ~= 15) and fight == 0)then --Needs ice breakers
		if ((math.random(0,1)) == 1) then
			n = 9
		else
			n = 15
		end
	end
	if((CurrentRoom == 11) and (n ~= 9 or n ~= 4) and fight == 0)then --Needs block breakers
		if ((math.random(0,1)) == 1) then
			n = 9
		else
			n = 4
		end
	end
	model = n
	memory.writebyte(0x02168B60, model)
	print(model)
	randomized = 1
end

while true do
	CurrentRoom = memory.readbyte(0x02177D6C)
	--gui.text(10,10,"Randomized: " .. randomized)
	--gui.text(10,10,"Current Model: " .. memory.readbyte(0x02168B60))
	--gui.text(1,-190,"BossHP: " .. memory.readbyte(0x02169116))
	--gui.text(10,20,"Fight: " .. fight)
	--gui.text(50,70,i)
	gui.text(10,30,"Room: " .. memory.readbyte(0x02177D6C))
	--gui.text(10,20,"Randomized Model: " .. model)
	--gui.text(10,50,"Speed: " .. memory.readword(0x02168AB0))

	if(memory.readbyte(0x02168B58) ~= 9)then --lives
		i = 0
		memory.writebyte(0x02168B58,9)
	end
	
	if(memory.readbyte(0x02169116) > 31 and fight == 0)then
		fight = 1
		randomize()
	end
	
	if(fight == 1 and memory.readbyte(0x02168B60) ~= model and (CurrentRoom ~= 21 and CurrentRoom ~= 25 and CurrentRoom ~= 37 and CurrentRoom ~= 45 and CurrentRoom ~= 48 and CurrentRoom ~= 37 and CurrentRoom ~= 4 and CurrentRoom ~= 56))then --Forces transformation during a fight
		memory.writebyte(0x02168B60, model)
	end
	
	if(fight == 0 and randomized == 0)then
		randomize()
	end
	
	if(memory.readbyte(0x02169116) == 0 and fight == 1)then --Forces transformation after the fight
		fight = 0
		i = 0
		if(CurrentRoom == 21)then
			model = 8
			memory.writebyte(0x02168B60, model)
		end
		if(CurrentRoom == 5 or CurrentRoom == 2)then
			model = 0
			memory.writebyte(0x02168B60, model)
		else
			if(CurrentRoom ~= 19 and CurrentRoom ~= 21 and CurrentRoom ~= 23 and CurrentRoom ~= 25 and CurrentRoom ~= 53)then
				randomized = 0
			end
		end
	end
	
	if joypad.get(1).select then
		memory.writebyte(0x02168B60, model)
	end
	
	if (joypad.get(1).select and joypad.get(1).up and i == 0) then
	--	fight = 0
		randomize()
		i = 1
	--memory.writebyte(0x02169116, 0)
	end
	
	if(oldRoom ~= CurrentRoom)then
		if(CurrentRoom ~= 10 and CurrentRoom ~= 2 and CurrentRoom ~= 61 and CurrentRoom ~= 7 and CurrentRoom ~= 17 and CurrentRoom ~= 19 and CurrentRoom ~= 21 and CurrentRoom ~= 22 and CurrentRoom ~= 53 and CurrentRoom ~= 4 and CurrentRoom ~= 56 and CurrentRoom ~= 63 and CurrentRoom ~= 65 and CurrentRoom ~= 25)then --Prevents randomization in some rooms
			randomized = 0
		end
	end
	
	if(memory.readbyte(0x02168A8E) == 0 and deathRandomization == 0)then --Player Dies
		randomized = 0
		fight = 0
		memory.writebyte(0x02169116,0)
		deathRandomization = 1
	end
	
	if(memory.readbyte(0x02168A8E) > 0)then
		deathRandomization = 0
	end
	
	if((memory.readbyte(0x02168B60) ~= 15) and memory.readword(0x02168AB0) > 500 and ((CurrentRoom ~= 7 and CurrentRoom ~= 22 and CurrentRoom ~= 10 and CurrentRoom ~= 24 and CurrentRoom ~= 4) or (CurrentRoom == 4 and fight == 1)) and (memory.readbyte(0x02168B60) ~= 11 and memory.readbyte(0x02168B60) ~= 10 and memory.readbyte(0x02168B60) ~= 16 and memory.readbyte(0x02168B60) ~= 9 and memory.readbyte(0x02168B60) ~= 6))then --Speed Forces Transformation back to randomized model
		memory.writebyte(0x02168B60, model)
	end
	
	oldRoom = CurrentRoom
	
	emu.frameadvance()
end