//Room values used here: 16-Highway path 18-Room IV of boss rush 19-Final Hallway 
//66-Area-O room where there is a transerver located
//70-Transerver

//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64"){}
state("DeSmuME_0.9.11_x86"){}
state("MZZXLC"){}

update {

	if (game.ProcessName == "DeSmuME_0.9.11_x64" || game.ProcessName == "DeSmuME_0.9.11_x86") {
		vars.lastROM = vars.ROM;
		if (game.ProcessName == "DeSmuME_0.9.11_x64") { vars.ROM = game.ReadString((IntPtr)modules.First().BaseAddress + 0x5810CDC, 4); }
		if (game.ProcessName == "DeSmuME_0.9.11_x86") { vars.ROM = game.ReadString((IntPtr)modules.First().BaseAddress + 0x32A0944, 4); }
		
		if (vars.ROM == string.Empty || vars.ROM == null){
			//print("--Yikes no good finding ROM");
			return; //stop since we have no ROM yet
		} else if (vars.ROM != vars.lastROM) {
			//ROM changed let's update our watchers!
			//print("--ROM Changed from: " + vars.lastROM + " to: " + vars.ROM);
			if (vars.ROM == "ARZJ"){
				//JP Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x55710F8, 0x5560234); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3000D60, 0x2FF071C); 
				}
			} else if(vars.ROM == "ARZE"){
				//US Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x55714F8, 0x5508600); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3001160, 0x64CC548); 
				}
			} else if(vars.ROM == "ARZP"){
				//EU Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x5573700, 0x550A540); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3003368, 0x2F9A1A8); 
				}
			}
		}
	} else {
		//ZXLC
		vars.ROM = "ZXLC";
		if (vars.watchers.Count == 0)
			vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x28B4360, 0x293349C); 
	}
	
	if (vars.watchers.Count == 0) {
		//failsafe
		//print("--Oops! Not a ZX ROM?");
		return;
	}
	vars.watchers.UpdateAll(game);
	//print("--Process: " + game.ProcessName + " | ROM: " + vars.ROM + " | IGT: " + vars.watchers["IGT"].Current + " | Room: " + vars.watchers["room"].Current);
}

init {
	vars.ROM = "";
	vars.lastROM = "";
	vars.watchers = new MemoryWatcherList();
}

startup{
	refreshRate = 60;
	settings.Add("everyRoom", false, "Every Room");
	settings.SetToolTip("everyRoom", "Splits when the game changes room ID. This will override every other option.");
	settings.Add("Intro", true, "Intro");
	settings.SetToolTip("Intro", "Split when you enter the first transerver room.");
	settings.Add("Boring", true, "Boring Mission");
	settings.SetToolTip("Boring", "Split when you enter the transerver room after getting the Stuffed Animal.");
	settings.Add("LocateGiro", true, "Locate Giro");
	settings.SetToolTip("LocateGiro", "Split when you enter the transerver room after destroying RayFly.");
	settings.Add("Giro", true, "Giro");
	settings.SetToolTip("Giro", "Split when you arrive at the Guardian's HQ after defeating Giro.");
	settings.Add("E", true, "Area-E");
	settings.SetToolTip("E", "Split when you enter Area-E.");
	settings.Add("Hivolt", true, "Hivolt");
	settings.SetToolTip("Hivolt", "Split when you enter the transerver room after Hivolt fight.");
	settings.Add("G", true, "Area-G");
	settings.SetToolTip("G", "Split when you enter Area-G.");
	settings.Add("Fistleo", true, "Fistleo");
	settings.SetToolTip("Fistleo", "Split when you enter the transerver room after Fistleo fight.");
	settings.Add("F", true, "Area-F");
	settings.SetToolTip("F", "Split when you enter Area-F.");
	settings.Add("Lurere", true, "Lurere");
	settings.SetToolTip("Lurere", "Split when you enter the transerver room after Lurere fight.");
	settings.Add("I", true, "Area-I");
	settings.SetToolTip("I", "Split when you enter Area-I.");
	settings.Add("Hurricaune", true, "Hurricaune");
	settings.SetToolTip("Hurricaune", "Split when you enter the transerver room after Saving the people.");
	settings.Add("Prometheus", true, "Prometheus");
	settings.SetToolTip("Prometheus", "Split when you arrive at Prairie's control room after defeating Prometheus.");
	settings.Add("K", true, "Area-K");
	settings.SetToolTip("K", "Split when you enter Area-K.");
	settings.Add("Flamolle", true, "Flamolle");
	settings.SetToolTip("Flamolle", "Split when you enter the transerver room after defeating Flamolle.");
	settings.Add("J", true, "Area-J");
	settings.SetToolTip("J", "Split when you enter Area-J.");
	settings.Add("Leganchor", true, "Leganchor");
	settings.SetToolTip("Leganchor", "Split when you leave Area-J.");
	settings.Add("H", true, "Area-H");
	settings.SetToolTip("H", "Split when you enter Area-H.");
	settings.Add("Purprill", true, "Purprill");
	settings.SetToolTip("Purprill", "Split when you enter the transerver room after defeating Purprill.");
	settings.Add("HL", true, "Area-L");
	settings.SetToolTip("HL", "Split when you enter Area-L.");
	settings.Add("Protectos", true, "Protectos");
	settings.SetToolTip("Protectos", "Split when you enter the transerver room after defeating Protectos.");
	settings.Add("M", true, "Area-M");
	settings.SetToolTip("M", "Split when you enter Area-M.");
	settings.Add("Pandora", true, "Pandora");
	settings.SetToolTip("Pandora", "Split when you enter the transerver room after Pandora fight.");
	settings.Add("O", true, "Area-O");
	settings.SetToolTip("O", "Split when you enter Area-O.");
	settings.Add("PandP", true, "Prometheus and Pandora");
	settings.SetToolTip("PandP", "Split when you arrive at Guardian's HQ after Prometheus and Pandora fight.");
	settings.Add("BossRush", true, "Boss Rush");
	settings.SetToolTip("BossRush", "Split when you leave Purprill and Protectos refight room.");
	
	vars.GetWatcherList = (Func<IntPtr, int, int, MemoryWatcherList>)((baseAddress, igtAddress, roomAddress) =>
	{   
		print("--BaseAddress: 0x" + baseAddress.ToString("X") + " | IGT address: 0x" + igtAddress.ToString("X") + " | room address: 0x" + roomAddress.ToString("X"));
		return new MemoryWatcherList
		{
			new MemoryWatcher<uint>(baseAddress + igtAddress) { Name = "IGT" }, //IGT frame counter
			new MemoryWatcher<byte>(baseAddress + roomAddress) { Name = "room" }, //Current Room     
		};
	});
}
 
start{
	//This logic needs fixed, false starts on demo - might need another value to watch? Also IGT/Room doesn't update the same on ZXLC
	// if(vars.watchers["IGT"].Changed && vars.watchers["room"].Current != 72){
		// return true;
	// }
}

reset {
	//Should be able to reset when IGT and Room == 0 right? won't work on ZXLC
	if(vars.watchers["IGT"].Current == 0 && vars.watchers["room"].Current == 0){
		return true;
	}
}
 
split{
	//Can probably put all of this into a dictionary/tuples and tidy it up as well as track splits 
	if(!settings["everyRoom"]){
		if(vars.watchers["room"].Old == 2 && vars.watchers["room"].Current == 70 && settings["Intro"]){
			//Intro
			return true;
		}
		if(vars.watchers["room"].Old == 10 && vars.watchers["room"].Current == 70 && settings["Boring"]){
			//Boring Mission
			return true;
		}
		if(vars.watchers["room"].Old == 6 && vars.watchers["room"].Current == 70 && settings["LocateGiro"]){
			//Locate Giro Mission
			return true;
		}
		if(vars.watchers["room"].Old == 16 && vars.watchers["room"].Current == 68 && settings["Giro"]){
			//Giro Fight
			return true;
		}
		if(vars.watchers["room"].Old == 10 && vars.watchers["room"].Current == 20 && settings["E"]){
			//Area-E
			return true;
		}
		if(vars.watchers["room"].Old == 26 && vars.watchers["room"].Current == 70 && settings["Hivolt"]){
			//Hivolt
			return true;
		}
		if(vars.watchers["room"].Old == 17 && vars.watchers["room"].Current == 33 && settings["G"]){
			//Area-G
			return true;
		}
		if(vars.watchers["room"].Old == 37 && vars.watchers["room"].Current == 70 && settings["Fistleo"]){
			//Fistleo
			return true;
		}
		if(vars.watchers["room"].Old == 7 && vars.watchers["room"].Current == 28 && settings["F"]){
			//Area-F
			return true;
		}
		if(vars.watchers["room"].Old == 32 && vars.watchers["room"].Current == 70 && settings["Lurere"]){
			//Lurere
			return true;
		}
		if(vars.watchers["room"].Old == 70 && vars.watchers["room"].Current == 42 && settings["I"]){
			//Area-I
			return true;
		}
		if(vars.watchers["room"].Old == 44 && vars.watchers["room"].Current == 70 && settings["Hurricaune"]){
			//Hurricaune
			return true;
		}
		if(vars.watchers["room"].Old == 69 && vars.watchers["room"].Current == 68 && settings["Prometheus"]){
			//Prometheus
			return true;
		}
		if(vars.watchers["room"].Old == 11 && vars.watchers["room"].Current == 52 && settings["K"]){
			//Area-K
			return true;
		}
		if(vars.watchers["room"].Old == 55 && vars.watchers["room"].Current == 70 && settings["Flamolle"]){
			//Flamolle
			return true;
		}
		if(vars.watchers["room"].Old == 4 && vars.watchers["room"].Current == 47 && settings["J"]){
			//Area-J
			return true;
		}
		if(vars.watchers["room"].Old == 47 && vars.watchers["room"].Current == 4 && settings["Leganchor"]){
			//Leganchor
			return true;
		}
		if(vars.watchers["room"].Old == 3 && vars.watchers["room"].Current == 38 && settings["H"]){
			//Area-H
			return true;
		}
		if(vars.watchers["room"].Old == 41 && vars.watchers["room"].Current == 70 && settings["Purprill"]){
			//Purprill
			return true;
		}
		if(vars.watchers["room"].Old == 39 && vars.watchers["room"].Current == 57 && settings["HL"]){
			//HL
			return true;
		}
		if(vars.watchers["room"].Old == 60 && vars.watchers["room"].Current == 70 && settings["Protectos"]){
			//Protectos
			return true;
		}
		if(vars.watchers["room"].Old == 4 && vars.watchers["room"].Current == 61 && settings["M"]){
			//Area-M
			return true;
		}
		if(vars.watchers["room"].Old == 63 && vars.watchers["room"].Current == 70 && settings["Pandora"]){
			//Pandora
			return true;
		}
		if(vars.watchers["room"].Old == 17 && vars.watchers["room"].Current == 65 && settings["O"]){
			//Area-O
			return true;
		}
		if(vars.watchers["room"].Old == 66 && vars.watchers["room"].Current == 68 && settings["PandP"]){
			//Pandora and Prometheus
			return true;
		}
		if(vars.watchers["room"].Old == 18 && vars.watchers["room"].Current == 19 && settings["BossRush"]){
			//Boss Rush
			return true;
		}
	}else if(vars.watchers["room"].Old != vars.watchers["room"].Current){
		//This would split on deaths wouldn't it? Gameovers? etc, not mistake friendly
		return true;
	}
}

isLoading {
    return true;
}
 
gameTime{
    return TimeSpan.FromSeconds(vars.watchers["IGT"].Current / 60.0); 
}

//created by Flameberger and Ikkisoad and Coltaho
//Special Thx to Fatalis, blastedt and DrTchops.