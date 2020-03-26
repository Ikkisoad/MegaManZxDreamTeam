//Room values used here: 16-Highway path 18-Room IV of boss rush 19-Final Hallway 
//66-Area-O room where there is a transerver located
//70-Transerver

//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64"){
	string4 ROM : "DeSmuME_0.9.11_x64.exe",0x5810CDC;
	uint IGT : "DeSmuME_0.9.11_x64.exe", 0x55710F8;
	byte room : "DeSmuME_0.9.11_x64.exe", 0x5560234;
}

state("DeSmuME_0.9.11_x86"){
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x3000D60;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x2FF071C;
}

state("MZZXLC"){
    uint IGT : "MZZXLC.exe", 0x28B4360;
    byte room : "MZZXLC.exe", 0x293349C;
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
}
 
start{
	if(current.IGT != old.IGT && current.room != 72){
		return true;
	}
}
 
split{
	if(!settings["everyRoom"]){
		if(old.room == 2 && current.room == 70 && settings["Intro"]){
			//Intro
			return true;
		}
		if(old.room == 10 && current.room == 70 && settings["Boring"]){
			//Boring Mission
			return true;
		}
		if(old.room == 6 && current.room == 70 && settings["LocateGiro"]){
			//Locate Giro Mission
			return true;
		}
		if(old.room == 16 && current.room == 68 && settings["Giro"]){
			//Giro Fight
			return true;
		}
		if(old.room == 10 && current.room == 20 && settings["E"]){
			//Area-E
			return true;
		}
		if(old.room == 26 && current.room == 70 && settings["Hivolt"]){
			//Hivolt
			return true;
		}
		if(old.room == 17 && current.room == 33 && settings["G"]){
			//Area-G
			return true;
		}
		if(old.room == 37 && current.room == 70 && settings["Fistleo"]){
			//Fistleo
			return true;
		}
		if(old.room == 7 && current.room == 28 && settings["F"]){
			//Area-F
			return true;
		}
		if(old.room == 32 && current.room == 70 && settings["Lurere"]){
			//Lurere
			return true;
		}
		if(old.room == 70 && current.room == 42 && settings["I"]){
			//Area-I
			return true;
		}
		if(old.room == 44 && current.room == 70 && settings["Hurricaune"]){
			//Hurricaune
			return true;
		}
		if(old.room == 69 && current.room == 68 && settings["Prometheus"]){
			//Prometheus
			return true;
		}
		if(old.room == 11 && current.room == 52 && settings["K"]){
			//Area-K
			return true;
		}
		if(old.room == 55 && current.room == 70 && settings["Flamolle"]){
			//Flamolle
			return true;
		}
		if(old.room == 4 && current.room == 47 && settings["J"]){
			//Area-J
			return true;
		}
		if(old.room == 47 && current.room == 4 && settings["Leganchor"]){
			//Leganchor
			return true;
		}
		if(old.room == 3 && current.room == 38 && settings["H"]){
			//Area-H
			return true;
		}
		if(old.room == 41 && current.room == 70 && settings["Purprill"]){
			//Purprill
			return true;
		}
		if(old.room == 39 && current.room == 57 && settings["HL"]){
			//HL
			return true;
		}
		if(old.room == 60 && current.room == 70 && settings["Protectos"]){
			//Protectos
			return true;
		}
		if(old.room == 4 && current.room == 61 && settings["M"]){
			//Area-M
			return true;
		}
		if(old.room == 63 && current.room == 70 && settings["Pandora"]){
			//Pandora
			return true;
		}
		if(old.room == 17 && current.room == 65 && settings["O"]){
			//Area-O
			return true;
		}
		if(old.room == 66 && current.room == 68 && settings["PandP"]){
			//Pandora and Prometheus
			return true;
		}
		if(old.room == 18 && current.room == 19 && settings["BossRush"]){
			//Boss Rush
			return true;
		}
	}else if(old.room != current.room){
		return true;
	}
}

isLoading {
    return true;
}
 
gameTime{
    return TimeSpan.FromSeconds(current.IGT / 60.0); 
}

//created by Flameberger and Ikkisoad
//Special Thx to Fatalis, blastedt and DrTchops.
//Comments from Ikkisoad