pArea1 = memory.readbyte(0x020F9130)
pArea2 = memory.readbyte(0x020F9130)
qArea = 80
intro = 1
serpent2 = 0
dead = 0
model = 1
giro = 0

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
	
end

randomize()

while true do


	if (model == 1) then
		memory.writebyte(0x021041CF, 128)
		memory.writebyte(0x021041D0, 000)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 2) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 001)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 3) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 002)
		memory.writebyte(0x021041D1, 002)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 4) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 032)
		memory.writebyte(0x021041D1, 032)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 5) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 008)
		memory.writebyte(0x021041D1, 008)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 6) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 128)
		memory.writebyte(0x021041D1, 128)
		memory.writebyte(0x021041D2, 000)
	elseif (model == 7) then
		memory.writebyte(0x021041CF, 000)
		memory.writebyte(0x021041D0, 000)
		memory.writebyte(0x021041D1, 000)
		memory.writebyte(0x021041D2, 003)
	end

	if ((cArea == 16) and (memory.readbyte(0x0214FDE4) > 0)) then
		giro = 1
	end

	if ((giro == 1) and (memory.readbyte(0x0214FDe4) == 0)) then
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