--Save this as a .lua file and run in Desmume
--Lua script created by @Flameberger
 
lagPrev = emu.lagcount()
timeStart = 0
timeEnd = 0
function main()
	RNG = memory.readdword(0x2108790)
	if (RNG == 0x5C8E5DA2) then
		if (timeStart ~= emu.framecount()) then
			timeStart = emu.framecount()
			print("--")
		end
	end
 
	if (emu.lagcount() > lagPrev) then
		posX = memory.readdword(0x214F764)
		if (posX == 0x52000) then
			timeEnd = emu.framecount()
			print(timeEnd - timeStart - 268 .. " " .. timeEnd - timeStart - 252 .. " " .. timeEnd - timeStart - 231 .. " " .. timeEnd - timeStart - 210)
		end
		if ((posX > 0x60000) and (posX < 0x64000)) then
			timeEnd = emu.framecount()
			print(timeEnd - timeStart - 374)
			print("==")
		end
	end
	lagPrev = emu.lagcount()
end
 
gui.register(main)