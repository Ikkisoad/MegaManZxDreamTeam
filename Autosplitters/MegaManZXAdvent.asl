//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting, livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run ~this may happen if you don't allow the script to start runs~
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64")
{
    uint IGT : "DeSmuME_0.9.11_x64.exe", 0x558A150;
	byte room : "DeSmuME_0.9.11_x64.exe", 0x551CCB0;
}

state("DeSmuME_0.9.11_x86")
{
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x3019DB8;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x2FAC918;
}

state("MZZXLC"){
    uint IGT : "MZZXLC.exe", 0x2784CB8;
	byte room : "MZZXLC.exe", 0x278526C;
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
	settings.SetToolTip("PandP", "Split when you defeat Pandora and Prometheus.");
	settings.Add("BossRush", true, "Boss Rush");
	settings.SetToolTip("BossRush", "Split when you leave the second boss rush room.");
	settings.Add("Albert", true, "Albert");
	settings.SetToolTip("Albert", "Split when you defeat Albert.");
}
 
start{
	if(current.IGT != old.IGT &&(current.room == 5 || current.room == 1)){
		return true ;
	}
}
 
split{
	if(!settings["everyRoom"]){
		if(old.room == 2 && current.room == 10 && settings["Intro"]){
			//intro grey
			return true;
		}
		if(old.room == 5 && current.room == 10 && settings["Intro"]){
			//intro Ashe
			return true;
		}
		if(old.room == 7 && current.room == 6 && settings["Buckfire"]){
			//Buckfire
			return true;
		}
		if(old.room == 17 && (current.room == 22 || current.room == 14) && settings["Chronoforce"]){
			//Chronoforce
			return true;
		}
		if(old.room == 18 && (current.room == 22 || current.room == 14) && settings["Rosepark"]){
			//Rosepark
			return true;
		}
		if(old.room == 24 && current.room == 6 && settings["Atlas"]){
			// Atlas
			return true;
		}
		if(old.room == 28 && current.room != 28 && settings["Sianarq"]){
			//Sianarq
			return true;
		}
		if(old.room == 41 && current.room != 41 && settings["Aelous"]){
			//Aelous
			return true;
		}
		if(old.room == 37 && current.room != 37 && settings["Thetis"]){
			//Thetis
			return true;
		}
		if(old.room == 45 && current.room != 45 && settings["Vulturon"]){
			//Vulturon
			return true;
		}
		if(old.room == 33 && current.room != 33 && settings["Queenbee"]){
			//Queenbee
			return true;
		}
		if(old.room == 49 && current.room != 49 && settings["AileVent"]){
			//Aile/Vent
			return true;
		}
		if(old.room == 53 && current.room != 53 && settings["ArgoyleUgoyle"]){
			//Argoyle/Ugoyle
			return true;
		}
		if(old.room == 4 && current.room != 4 && settings["Hedgeshock"]){
			//Hedgeshock
			return true;
		}
		if(old.room == 56 && current.room != 56 && settings["Bifrost"]){
			// Bifrost
			return true;
		}
		if(old.room == 60 && current.room != 60 && settings["PandP"]){
			// Prometheus and Pandora
			return true;
		}
		if(old.room == 63 && current.room == 64 && settings["BossRush"]){
			// Boss Rush
			return true;
		}
		if(old.room == 64 && current.room == 65 && settings["Albert"]){
			// Albert
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
