-- Model Adjustment Pack v1 by Meta_X --
-- For Rockman ZX (JP) on DeSmuME x86 --
--List of changes (disable them by changing the "true" values at the bottom of this script to false):
--All: Give 1 Weapon Energy to all models every 3 seconds
--FX: Can perform a recoil-rod style superjump by pressing B while using Ground Breaker
--LX: Ice dragon can be performed from a lv1 charge and costs 2 fewer energy points
--PX: Can perform a MMX6 Shadow Armor-style highjump by pressing Up and B
--    Can throw kunai straight forward by pressing Y (press R for the usual kunai spread)
--OX, ZX and X: Can perform a double jump (must be toggled on for ZX and X)
--
--Known issues:
--Models you haven't yet switched to with the script active can appear on the menu as filling past their cap
--Cannot drop through a platform then double jump and land on that same platform
--You must use a different attack before being able to FX superjump again (eg. plain bullet)
--Ice dragon early charge doesn't always work like if released during a cutscene


autofill_frame_count = 0
hxcap = 32
fxcap = 32
lxcap = 32
pxcap = 32
function autofill_energy (e)
	if e then
		--record WE cap for each model since we can only see equipped's cap
		if memory.readbyte(0x0214F874) == 3 then
			hxcap = memory.readbyte(0x0214FE75)*4;
		elseif memory.readbyte(0x0214F874) == 4 then
			fxcap = memory.readbyte(0x0214FE75)*4;
		elseif memory.readbyte(0x0214F874) == 5 then
			lxcap = memory.readbyte(0x0214FE75)*4;
		elseif memory.readbyte(0x0214F874) == 6 then
			pxcap = memory.readbyte(0x0214FE75)*4;
		end
		
		if memory.readbyte(0x0214F895) < 32 or memory.readbyte(0x0214F896) < 32 or memory.readbyte(0x0214F897) < 32 or memory.readbyte(0x0214F897) < 32 then --if any of HX, FX, LX, or PX has less than 32 (so count isnt always going)
			if autofill_frame_count < 180 then --number of frames til energy point
				autofill_frame_count = autofill_frame_count + 1
			else --if each model's WE less than assumed cap and not currently equipped, add WE point
				if memory.readbyte(0x0214F895) < hxcap then --HX
					memory.writebyte(0x0214F895, memory.readbyte(0x0214F895) + 1)
				end
				if memory.readbyte(0x0214F896) < fxcap then --FX
					memory.writebyte(0x0214F896, memory.readbyte(0x0214F896) + 1)
				end
				if memory.readbyte(0x0214F897) < lxcap then --LX
					memory.writebyte(0x0214F897, memory.readbyte(0x0214F897) + 1)
				end
				if memory.readbyte(0x0214F898) < pxcap then --PX
					memory.writebyte(0x0214F898, memory.readbyte(0x0214F898) + 1)
				end
				autofill_frame_count = 0
			end
		end
		
		--if equipped model's WE is higher than its cap, reduce to cap
		if memory.readbyte(0x0214FE71) > memory.readbyte(0x0214FE75)*4 then
			if memory.readbyte(0x0214F874) == 3 then --if HX
				memory.writebyte(0x0214F895, memory.readbyte(0x0214FE75)*4)
			end
			if memory.readbyte(0x0214F874) == 4 then --if FX
				memory.writebyte(0x0214F896, memory.readbyte(0x0214FE75)*4)
			end
			if memory.readbyte(0x0214F874) == 5 then --if LX
				memory.writebyte(0x0214F897, memory.readbyte(0x0214FE75)*4)
			end
			if memory.readbyte(0x0214F874) == 6 then --if PX
				memory.writebyte(0x0214F898, memory.readbyte(0x0214FE75)*4)
			end
		end
	end
end

double_jump_frame_count = -1
jump_pressed = joypad.get(1).B
double_jump_remaining = false
jump_override = false
function double_jump (e, ox, zx, x)
	if e then
		if (memory.readbyte(0x0214F874) == 1 and x) or (memory.readbyte(0x0214F874) == 2 and zx) or (memory.readbyte(0x0214F874) == 7 and ox) then
			if double_jump_remaining and joypad.get(1).B and (memory.readbyte(0x0214F719) ~= 0 and memory.readbyte(0x0214F719) ~= 2) then
				jump_pressed = true
			end
			if (memory.readbyte(0x0214F719) == 0 or memory.readbyte(0x0214F719) == 2 or memory.readbyte(0x0214F719) == 3) and joypad.get(1).B then
				jump_override = true
			end
			if not joypad.get(1).B then
				jump_override = false
			end
			if not double_jump_remaining and (memory.readbyte(0x0214F719) == 0 or memory.readbyte(0x0214F719) == 2) then
				double_jump_remaining = true
			end
			if double_jump_remaining and jump_pressed and double_jump_frame_count == -1 and not jump_override and memory.readbyte(0x0214F719) == 1 then
				--print("go time baybee")
				double_jump_frame_count = 0
				double_jump_remaining = false
			end
			if double_jump_frame_count > -1 then
				if double_jump_frame_count < 19 then
					memory.writebyte(0x0214F772, -1)
					memory.writebyte(0x0214F773, -1)
					--memory.writedword(0x0214F768, memory.readdword(0x0214F768) - 256*3*(3.36-0.08*double_jump_frame_count))
					if not joypad.get(1).B then
						memory.writebyte(0x0214F771, 0)
						double_jump_frame_count = 19
						memory.writebyte(0x0214F772, 0)
						memory.writebyte(0x0214F773, 0)
					elseif double_jump_frame_count < 3 then
						memory.writebyte(0x0214F771, -5)
					elseif double_jump_frame_count < 7 then
						memory.writebyte(0x0214F771, -4)
					elseif double_jump_frame_count < 11 then
						memory.writebyte(0x0214F771, -3)
					elseif double_jump_frame_count < 15 then
						memory.writebyte(0x0214F771, -2)
					elseif double_jump_frame_count < 19 then
						memory.writebyte(0x0214F771, -1)
					end
					double_jump_frame_count = double_jump_frame_count + 1
					--print(double_jump_frame_count)
				else
					double_jump_frame_count = -1
					memory.writebyte(0x0214F771, 0)
					memory.writebyte(0x0214F772, 0)
					memory.writebyte(0x0214F773, 0)
				end
			end
			--print(jump_pressed)
			if jump_pressed then
				jump_pressed = false
			end
		else
			if double_jump_frame_count ~= -1 then
				double_jump_frame_count = -1
			end
			if double_jump_remaining == true then
				double_jump_remaining = false
			end
			if jump_override == true then
				jump_override = false
			end
		end
	end
end

--sorry this one's a horror show...... but, it works :P
ground_punch_frame_count = -1
ground_punch_jump_attack_cooldown = false
ground_punch_jump_landing_cooldown = false
ground_punch_animation_frame_count = -1
function fx_ground_breaker_jump (e)
	if e then
		if memory.readbyte(0x0214F874) == 4 then
			if ground_punch_jump_attack_cooldown and not (memory.readbyte(0x0214F836) == 62 or memory.readbyte(0x0214F836) == 63) and ground_punch_frame_count == -1 then
				ground_punch_jump_attack_cooldown = false --must other attack (to avoid confusion with ID)
			end
			if ground_punch_jump_landing_cooldown and memory.readbyte(0x0214F719) == 0 and ground_punch_frame_count == -1 then
				ground_punch_jump_landing_cooldown = false --must land before jumping again
			end
			if (memory.readbyte(0x0214F836) == 62 or memory.readbyte(0x0214F836) == 63) and ground_punch_frame_count == -1 and not ground_punch_jump_attack_cooldown and not ground_punch_jump_landing_cooldown and memory.readbyte(0x0214F719) == 0 and ground_punch_animation_frame_count == -1 then
				ground_punch_animation_frame_count = 0
				ground_punch_jump_attack_cooldown = true
			end
			if ground_punch_animation_frame_count > -1 then
				if ground_punch_animation_frame_count < 30 then
					ground_punch_animation_frame_count = ground_punch_animation_frame_count + 1
				else
					ground_punch_animation_frame_count = -1
				end
			end
			if ground_punch_animation_frame_count > 8 and joypad.get(1).B and not ground_punch_jump_landing_cooldown then
				ground_punch_frame_count = 0
				ground_punch_jump_attack_cooldown = true
				ground_punch_jump_landing_cooldown = true
			end
			if ground_punch_frame_count > -1 then
					if ground_punch_frame_count < 24 then -- 19 + 8 frames
						memory.writebyte(0x0214F772, -1)
						memory.writebyte(0x0214F773, -1)
						if ground_punch_frame_count == 0 then --must force first movement :/
							memory.writedword(0x0214F768, memory.readdword(0x0214F768) - 256*8)
						end
						if ground_punch_frame_count < 3 then
							memory.writebyte(0x0214F771, -8)
						elseif ground_punch_frame_count < 7 then
							memory.writebyte(0x0214F771, -7)
						elseif ground_punch_frame_count < 11 then
							memory.writebyte(0x0214F771, -6)
						elseif ground_punch_frame_count < 15 then
							memory.writebyte(0x0214F771, -5)
						elseif ground_punch_frame_count < 19 then
							memory.writebyte(0x0214F771, -4)
						elseif ground_punch_frame_count < 23 then
							memory.writebyte(0x0214F771, -3)
						elseif ground_punch_frame_count < 27 then
							memory.writebyte(0x0214F771, -2)
						elseif ground_punch_frame_count < 31 then
							memory.writebyte(0x0214F771, -1)
						end
					else
						ground_punch_frame_count = -2
						memory.writebyte(0x0214F771, 0)
						memory.writebyte(0x0214F772, 0)
						memory.writebyte(0x0214F773, 0)
					end
				ground_punch_frame_count = ground_punch_frame_count + 1
			end
		else
			if ground_punch_frame_count ~= -1 then
				ground_punch_frame_count = -1
			end
			if ground_punch_jump_attack_cooldown then
				ground_punch_jump_attack_cooldown = false
			end
		end
	end
end

lx_charging = false
lx_dragoned = 254
function lx_dragon (e)
	if e then
		if memory.readbyte(0x0214F874) == 5 then --if LX
			if (joypad.get(1).Y or joypad.get(1).R) and not lx_charging then
				lx_charging = true
			end
			if lx_charging and not (joypad.get(1).Y or joypad.get(1).R) and memory.readbyte(0x0214F838) > 39 and joypad.get(1).up then --if charge released at >40 and up held
				memory.writebyte(0x0214F838, 120) --instant charge for dragon
				memory.writebyte(0x0214F897, memory.readbyte(0x0214F897) + 2) --refund 2 energy for dragon
			end
		end
	end
end

highjump_frame_count = -1
function px_highjump (e)
	if e then
		if memory.readbyte(0x0214F874) == 6 then
			if memory.readbyte(0x0214F719) == 0 and joypad.get(1).B and joypad.get(1).up then
				highjump_frame_count = 0
			end
			if highjump_frame_count > -1 then
				if highjump_frame_count < 16 then
					memory.writebyte(0x0214F771, -8)
					memory.writebyte(0x0214F772, -1)
					memory.writebyte(0x0214F773, -1)
					highjump_frame_count = highjump_frame_count + 1
				else
					highjump_frame_count = -1
					memory.writebyte(0x0214F771, 0)
					memory.writebyte(0x0214F772, 0)
					memory.writebyte(0x0214F773, 0)
				end
			end
		elseif highjump_frame_count > -1 then
			highjump_frame_count = -1
		end
	end
end

function px_kunai_spread_control (e)
	if e then
		if memory.readbyte(0x0214F874) == 6 then
			if memory.readdword(0x0218BA1C) == 807407616 then
				if joypad.get(1).Y then
					memory.writedword(0x0218BA1C, 0)
				end
			elseif memory.readdword(0x0218BA1C) == 0 then
				if joypad.get(1).R then
					memory.writedword(0x0218BA1C, 807407616)
				end
			end
		end
	end
end

while true do
	autofill_energy(true) --Autofill 1 energy to all models every 3 seconds
	double_jump(true, true, false, false) --Gives double jump to OX (and ZX/X if toggled on)
	fx_ground_breaker_jump(true) --Hold B as FX while using ground breaker to do a recoil rod-style super jump
	lx_dragon(true) --Reduces the charge time and energy cost of ice dragon
	px_highjump(true) --Hold up as PX and press B to do a MMX6 Shadow Armor-style highjump
	px_kunai_spread_control(true) --Press Y as PX to throw kunai straight forward, press R for classic spread
	
	emu.frameadvance()
end
