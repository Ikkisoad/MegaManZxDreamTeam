while true do
    if ((memory.readbyte(0x020F9130) ~= 16) or (memory.readbyte(0x020F031C) ~= 60)) then
        if (memory.readbyte(0x0214F874) == 1) or (memory.readbyte(0x0214F874) == 2) then
            memory.writebyte(0x0214f874, 6)
        end
    end
 
    if joypad.get(1).Y then
        memory.writebyte(0x0214F838, 120)
    end
    if joypad.get(1).R then
        memory.writebyte(0x0214F838, 120)
    end
    memory.writebyte(0x0214F898, 24)
    memory.writebyte(0x0214F82D, 65)
       
    emu.frameadvance()
end