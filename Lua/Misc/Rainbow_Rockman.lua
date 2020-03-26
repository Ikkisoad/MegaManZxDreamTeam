addresses = {0x020F79CA, 0x020F79CC, 0x020F79CE, 0x020F79D0, 0x020F79D2, 0x020F79D4, 0x020F79D6, 0x020F79D8, 0x020F79DA, 0x020F79DC, 0x020F79DE, 0x020F79E0, 0x020F79E2, 0x020F79E4, 0x020F79E6} --current model
--addresses = {0x020F79D4, 0x020F79D6, 0x020F79D8} --just the colored part of model's armor
dash_addresses = {0x020F79EA, 0x020F79EC, 0x020F79EE, 0x020F79F0, 0x020F79F2, 0x020F79F4, 0x020F79F6, 0x020F79F8, 0x020F79FA, 0x020F79FC, 0x020F79FE, 0x020F7A00, 0x020F7A02, 0x020F7A04, 0x020F7A06} --current dash
count = 1
color = 31 --red
delta = 32
dash_count = 26
dash_color = 6175 --red 6 steps backwards toward magenta
dash_delta = -1024
while true do
	--model
	for i,x in ipairs(addresses) do
		memory.writeword(x, color)
    end
	
	color = color + delta
	
	if count < 31 then
		count = count + 1
	else
		count = 1
		if delta == 32 then
			delta = -1
		elseif delta == -1 then
			delta = 1024
		elseif delta == 1024 then
			delta = -32
		elseif delta == -32 then
			delta = 1
		elseif delta == 1 then
			delta = -1024
		elseif delta == -1024 then
			delta = 32
		end
	end
	
	--dash
	for i,x in ipairs(dash_addresses) do
		memory.writeword(x, dash_color)
    end
	
	dash_color = dash_color + dash_delta
	
	if dash_count < 31 then
		dash_count = dash_count + 1
	else
		dash_count = 1
		if dash_delta == 32 then
			dash_delta = -1
		elseif dash_delta == -1 then
			dash_delta = 1024
		elseif dash_delta == 1024 then
			dash_delta = -32
		elseif dash_delta == -32 then
			dash_delta = 1
		elseif dash_delta == 1 then
			dash_delta = -1024
		elseif dash_delta == -1024 then
			dash_delta = 32
		end
	end
	
    emu.frameadvance()
end
