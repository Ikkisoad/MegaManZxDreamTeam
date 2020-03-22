pArea1 = memory.readbyte(0x020F9130)
pArea2 = memory.readbyte(0x020F9130)
qArea = 80
intro = 1
serpent2 = 0
dead = 0
model = 1
giro = 0
overdrived = 0

function randomize()
	memory.writebyte(0x0214F874, model)
	n = math.random(1, 6)

	if ((cArea == 2) or (cArea == 49) or (cArea == 66)) then  --No Px Snake
		n = math.random(1,6)
		memory.writebyte(0x0214F874, 6)
	end

	if (cArea == 7 or (cArea == 19 and serpent2 == 1)) then  --No X or Px Button / Serpent 2
		n = math.random(2,6)
		memory.writebyte(0x0214F874, 6)
	end

	if (cArea == 47) then  --Lx or Ox for Water Spike Room
		if ((math.random(0,1)) == 1) then
			n = 5
		else
			n = 7
		end
		memory.writebyte(0x0214F874, 6)
	end

	if (cArea == 49) then
		memory.writebyte(0x0214F874, 6)
	end

	if (intro == 0) then
		n = n + 1
	end
	if (n == memory.readbyte(0x0214F874)) then
		n = 7
	end

	if (cArea == 17) then  --Hx or Lx for Ladder to Area O
		if ((math.random(0,1)) == 1) then
			n = 3
		else
			n = 5
		end
		memory.writebyte(0x0214F874, 6)
	end

	memory.writebyte(0x0214F874, n)
	model = n
	overdrived = math.random(0,1);
	
end

randomize()

while true do
	--print(model)
	--print(cArea);
	--print(giro);
	--print(intro)
	--lmao = -1 --TRYING TO MAKE AREA D UNLOCKED
	--memory.writebyte(0x02104227, lmao)
	--memory.writebyte(0x02104228, lmao)
	--gui.text(25,50,memory.readbyte(0x0214FDe4))
	--gui.text(25,150,memory.readbyte(0x0214F874))
	--gui.text(40,50,giro)
	gui.text(10,20,curentModel)
	--gui.text(100,100,cArea)
	if(memory.readbyte(0x0214FDe4) ~= 5)then
		memory.writebyte(0x0214F86C, 5) --Infinity lives
	end
	if(overdrived == 1)then
		gui.text(10, 10, "OVERDRIVED")
	end
	if((memory.readbyte(0x0214FDe4)~=0) and (memory.readbyte(0x0214F874)~=0 and memory.readbyte(0x0214F874)~=model))then
		memory.writebyte(0x0214F874, model)
	end
	if (model == 1) then --X
		curentModel = "X"
		memory.writebyte(0x021041CF, 128)
		memory.writebyte(0x021041D0, 000)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).Y then
				memory.writebyte(0x0214F838, 120)
			end
			if joypad.get(1).R then
				memory.writebyte(0x0214F839, 120)
			end
		end
	elseif (model == 2) then --Zx
		curentModel = "Zx"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 001)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).R then
				memory.writebyte(0x0214F839, 120)
			end
		end
	elseif (model == 3) then --Hx
		curentModel = "Hx"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 002)
		memory.writebyte(0x021041D1, 002)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).Y then
				memory.writebyte(0x0214F838, 120)
			end
			if joypad.get(1).R then
				memory.writebyte(0x0214F839, 120)
			end
			memory.writebyte(0x0214F895, 24)
			memory.writebyte(0x0214F82D, 65)
		end
	elseif (model == 4) then --Fx
		curentModel = "Fx"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 032)
		memory.writebyte(0x021041D1, 032)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).Y then
				memory.writebyte(0x0214F838, 120)
			end
			if joypad.get(1).R then
				memory.writebyte(0x0214F839, 120)
			end
			memory.writebyte(0x021041CF, 0)
			if (memory.readbyte(0x021041D0) % 2) ~= 0 then
				memory.writebyte(0x021041D0, memory.readbyte(0x021041D0) - 1)
			end
			memory.writebyte(0x0214F896, 24)
			memory.writebyte(0x0214F82D, 65)
		end
	elseif (model == 5) then --Lx
		curentModel = "Lx"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 008)
		memory.writebyte(0x021041D1, 008)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).Y then
				memory.writebyte(0x0214F838, 120)
			end
			if joypad.get(1).R then
				memory.writebyte(0x0214F838, 120)
			end
			memory.writebyte(0x0214F897, 24)
			memory.writebyte(0x0214F82D, 65)
		end
	elseif (model == 6) then --Px
		curentModel = "Px"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 128)
		memory.writebyte(0x021041D1, 128)
		memory.writebyte(0x021041D2, 000)
		if(overdrived == 1) then
			if joypad.get(1).Y then
				memory.writebyte(0x0214F838, 120)
			end
			if joypad.get(1).R then
				memory.writebyte(0x0214F838, 120)
			end
			memory.writebyte(0x0214F898, 24)
			memory.writebyte(0x0214F82D, 65)
		end
	elseif (model == 7) then --Ox
		curentModel = "Ox"
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 000)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 003)
		if(overdrived == 1) then
			--memory.writebyte(0x0214F898, 24)
			--memory.writebyte(0x0214F82D, 65) --This crashes the game if you try to do a special with Ox :(
			if joypad.get(1).R then
				memory.writebyte(0x0214F839, 120)
			end
		end
	end

	if ((cArea == 16) and (memory.readbyte(0x0214FDE4) > 0) and giro == 0) then
		giro = 1
		memory.writebyte(0x02104227, -80) --Unlocks Area D
		memory.writebyte(0x02104228, 0)
	end
	
	if ((giro == 1) and (memory.readbyte(0x0214FDe4) == 64)) then
		randomize()
		giro = 2
	end

	if ((giro > 1) and (memory.readbyte(0x0214FDe4) == 0)) then
		model = 2
	end

	if (cArea ~= 16) then
		giro = 0
	end

	if ((cArea == 71) and (pArea2 ~= 0)) then
		pArea1 = 0
		pArea2 = 0
	end

	if ((cArea == 18) and (pArea2 == 0)) then
		pArea1 = 18
		pArea2 = 18
	end

	if (memory.readbyte(0x0214F874) > 7) then
		randomize()
	end

	cArea = memory.readbyte(0x020F9130)
	if (memory.readword(0x0215FEA8) == 0) then
		intro = 0
	end
	
	if (memory.readbyte(0x02104234) == 0) then
		memory.writebyte(0x02104234, 1)
	end
	if (memory.readbyte(0x02104235) == 0) then
		memory.writebyte(0x02104235, 1)
	end
	if (memory.readbyte(0x02104236) == 0) then
		memory.writebyte(0x02104236, 1)
	end
	if (memory.readbyte(0x02104237) == 0) then
		memory.writebyte(0x02104237, 1)
	end
	if (memory.readbyte(0x02104238) == 0) then
		memory.writebyte(0x02104238, 1)
	end
	if (memory.readbyte(0x02104239) == 0) then
		memory.writebyte(0x02104239, 1)
	end
	if (memory.readbyte(0x0210423A) == 0) then
		memory.writebyte(0x0210423A, 1)
	end
	if (memory.readbyte(0x0210423B) == 0) then
		memory.writebyte(0x0210423B, 1)
	end

	if ((intro == 0) and (memory.readbyte(0x0214F874) == 1)) then
		intro = 1
		memory.writebyte(0x0214F86E, math.random(1,8)) --Randomize Human Color Palette
		randomize()
	end
	if ((cArea == 19) and (serpent2 == 0) and (memory.readbyte(0x020F5123) == 1)) then
		serpent2 = 1
		randomize()
	end
	if ((cArea == 19) and (memory.readbyte(0x020F5123) == 0)) then
		serpent2 = 0
	end
	if ((memory.readbyte(0x0214F7B2) == 0) and (dead == 0)) then
		randomize()
		dead = 1
	end
	if (memory.readbyte(0x0214F7B2) ~= 0) then
		dead = 0
	end

	if ((cArea == 15) and (memory.readbyte(0x0214F874) == 1)) then
		randomize()
	end
	
	if ((cArea == 16) and (memory.readbyte(0x0214F874) == 1) and (giro == 0)) then
		randomize()
	end

	if ((hWay == 1) and (memory.readbyte(0x0214F874) == 1)) then
		randomize()
		pArea2 = pArea1
		pArea1 = cArea
	end

	if ((cArea == 69) and (memory.readbyte(0x0214F874) == 2)) then
		randomize()
	end

	if ((cArea ~= pArea1) and (cArea ~= pArea2) and (cArea ~= 70) and (cArea ~= 68) and (cArea ~= 18)) then
		randomize()
		pArea2 = pArea1
		pArea1 = cArea
	end

	if (memory.readbyte(0x020F457C) ~= memory.readbyte(0x0214F874)) then
		joypad.set(1, {left = false})
		joypad.set(1, {right = false})
	end	

	emu.frameadvance()
end