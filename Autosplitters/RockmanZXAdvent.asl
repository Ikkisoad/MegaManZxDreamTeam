
//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting, livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run ~this may happen if you don't allow the script to start runs~
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
			if (vars.ROM == "YZXJ"){
				//JP Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x5588EC4, 0x558D404); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3018B2C, 0x3018B34);
				}
			} else if(vars.ROM == "YZXE"){
				//US Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x558A150, 0x551CCB0); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3019DB8, 0x2FAC918); 
				}
			} else if(vars.ROM == "YZXP"){
				//EU Rom
				if (game.ProcessName == "DeSmuME_0.9.11_x64") {
					//64-bit addresses - IGT then Room
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x557619C, 0x55085F0); 
				}
				else {
					//32-bit addresses
					vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x3005E04, 0x2F98258); 
				}
			}
		}
	} else {
		//ZXLC
		vars.ROM = "ZXLC";
		if (vars.watchers.Count == 0)
			vars.watchers = vars.GetWatcherList(modules.First().BaseAddress, 0x2786468, 0x2781E98); 
	}
	
	if (vars.watchers.Count == 0) {
		//failsafe
		//print("--Oops! Not a ZXA ROM?");
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
	settings.SetToolTip("everyRoom", "Split when the game changes room ID. This will override every other option. 80+ Splits on a Normal difficulty run.");
	settings.Add("Intro", true, "Intro");
	settings.SetToolTip("Intro", "Split after intro stage.");
	settings.Add("Buckfire", true, "Buckfire");
	settings.SetToolTip("Buckfire", "Split after Buckfire stage.");
	settings.Add("Chronoforce", true, "Chronoforce");
	settings.SetToolTip("Chronoforce", "Split when you leave Ice Floe Transerver room.");
	settings.Add("Rosepark", true, "Rosepark");
	settings.SetToolTip("Rosepark", "Split when you leave Tower of Verdure Transerver room.");
	settings.Add("Atlas", true, "Atlas");
	settings.SetToolTip("Atlas", "Split when you leave the Raiders Base.");
	settings.Add("Sianarq", true, "Sianarq");
	settings.SetToolTip("Sianarq", "Split when you leave the Trinity Sage transerver room.");
	settings.Add("Aelous", true, "Aelous");
	settings.SetToolTip("Aelous", "Split when you leave Aelous stage.");
	settings.Add("Thetis", true, "Thetis");
	settings.SetToolTip("Thetis", "Split when you leave Thetis stage.");
	settings.Add("Vulturon", true, "Vulturon");
	settings.SetToolTip("Vulturon", "Split when you leave Vulturon stage.");
	settings.Add("Queenbee", true, "Queenbee");
	settings.SetToolTip("Queenbee", "Split when you leave Queenbee stage.");
	settings.Add("AileVent", true, "Aile/Vent");
	settings.SetToolTip("AileVent", "Split after Spidrill Neo.");
	settings.Add("ArgoyleUgoyle", true, "Argoyle/Ugoyle");
	settings.SetToolTip("ArgoyleUgoyle", "Split after leaving Waterfall Ruins transerver Room.");
	settings.Add("Hedgeshock", true, "Hedgeshock");
	settings.SetToolTip("Hedgeshock", "Split after leaving Mysterious Lab transerver Room.");
	settings.Add("Bifrost", true, "Bifrost");
	settings.SetToolTip("Bifrost", "Split when you leave Bifrost stage.");
	settings.Add("PandP", true, "Pandora and Prometheus");
	settings.SetToolTip("PandP", "Split when you arrive at the Hunter's Camp after defeating Pandora and Prometheus.");
	settings.Add("BossRush", true, "Boss Rush");
	settings.SetToolTip("BossRush", "Split when you leave the second boss rush room.");
	settings.Add("Albert", true, "Albert");
	settings.SetToolTip("Albert", "Split when arrive at the Hunter's Camp after defeating Albert.");
	
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
	if(vars.watchers["IGT"].Current != vars.watchers["IGT"].Old &&(vars.watchers["room"].Current == 5)){ //Grey room is the same as main menu room number, so just Ashe automatic start for now.
		return true ;
	}
}

reset {
	//Should be able to reset when IGT and Room == 0 right? won't work on ZXLC
	if(vars.watchers["IGT"].Current == 0 && vars.watchers["room"].Current == 0){
		return true;
	}
}

split{
	if(!settings["everyRoom"]){
		if(vars.watchers["room"].Old == 2 && vars.watchers["room"].Current == 10 && settings["Intro"]){
			//intro grey
			return true;
		}
		if(vars.watchers["room"].Old == 5 && vars.watchers["room"].Current == 10 && settings["Intro"]){
			//intro Ashe
			return true;
		}
		if(vars.watchers["room"].Old == 7 && vars.watchers["room"].Current == 6 && settings["Buckfire"]){
			//Buckfire
			return true;
		}
		if(vars.watchers["room"].Old == 17 && (vars.watchers["room"].Current == 22 || vars.watchers["room"].Current == 14) && settings["Chronoforce"]){
			//Chronoforce
			return true;
		}
		if(vars.watchers["room"].Old == 18 && (vars.watchers["room"].Current == 22 || vars.watchers["room"].Current == 14) && settings["Rosepark"]){
			//Rosepark
			return true;
		}
		if(vars.watchers["room"].Old == 24 && vars.watchers["room"].Current == 6 && settings["Atlas"]){
			// Atlas
			return true;
		}
		if(vars.watchers["room"].Old == 28 && vars.watchers["room"].Current != 28 && settings["Sianarq"]){
			//Sianarq
			return true;
		}
		if(vars.watchers["room"].Old == 41 && vars.watchers["room"].Current != 41 && settings["Aelous"]){
			//Aelous
			return true;
		}
		if(vars.watchers["room"].Old == 37 && vars.watchers["room"].Current != 37 && settings["Thetis"]){
			//Thetis
			return true;
		}
		if(vars.watchers["room"].Old == 45 && vars.watchers["room"].Current != 45 && settings["Vulturon"]){
			//Vulturon
			return true;
		}
		if(vars.watchers["room"].Old == 33 && vars.watchers["room"].Current != 33 && settings["Queenbee"]){
			//Queenbee
			return true;
		}
		if(vars.watchers["room"].Old == 49 && vars.watchers["room"].Current != 49 && settings["AileVent"]){
			//Aile/Vent
			return true;
		}
		if(vars.watchers["room"].Old == 53 && vars.watchers["room"].Current != 53 && settings["ArgoyleUgoyle"]){
			//Argoyle/Ugoyle
			return true;
		}
		if(vars.watchers["room"].Old == 4 && vars.watchers["room"].Current != 4 && settings["Hedgeshock"]){
			//Hedgeshock
			return true;
		}
		if(vars.watchers["room"].Old == 56 && vars.watchers["room"].Current != 56 && settings["Bifrost"]){
			// Bifrost
			return true;
		}
		if(vars.watchers["room"].Old == 61 && vars.watchers["room"].Current == 10 && settings["PandP"]){
			// Prometheus and Pandora
			return true;
		}
		if(vars.watchers["room"].Old == 63 && vars.watchers["room"].Current == 64 && settings["BossRush"]){
			// Boss Rush
			return true;
		}
		if(vars.watchers["room"].Old == 64 && vars.watchers["room"].Current == 10 && settings["Albert"]){
			// Albert
			return true;
		}
	}else if(vars.watchers["room"].Old != vars.watchers["room"].Current){
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