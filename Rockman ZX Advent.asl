//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting, livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run ~this may happen if you don't allow the script to start runs~
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64"){
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x5588EC4;
	//byte bossHP : "DeSmuME_0.9.11_x86.exe", 0x557A366;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x558D404;
}

state("DeSmuME_0.9.11_x86"){
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x3018B2C;
	//byte bossHP : "DeSmuME_0.9.11_x86.exe", 0x3009FCE;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x3018B34;
}

state("MZZXLC"){
    uint IGT : "MZZXLC.exe", 0x2784CB8;
	byte room : "MZZXLC.exe", 0x278526C;
}
 
start{
	if(current.IGT != old.IGT && (current.room == 5 || current.room == 1)){
		return true ;
	}
}
 
split{
	if(old.room == 2 && current.room == 10){
		//intro grey
		return true;
	}
	if(old.room == 5 && current.room == 10){
		//intro Ashe
		return true;
	}
	if(old.room == 7 && current.room == 6){
		//Buckfire
		return true;
	}
	if(old.room == 18 || old.room == 17){
		//Rosepark > Chronoforce
		if(current.room == 14 || current.room == 22){
			return true;
		}
	}
	if(old.room == 24 && current.room == 6){
		// Atlas
		return true;
	}
	if(old.room == 28 || old.room == 41 || old.room == 37 || old.room == 45 || old.room == 33){
		//Sianarq
		if(current.room == 38 && old.room != 41){
			// Aelous
			return true;
		}
		if(current.room == 34 && old.room != 37){
			// Thetis
			return true;
		}
		if(current.room == 42 && old.room != 45){
			// Vulturon
			return true;
		}
		if(current.room == 30 && old.room != 33){
			// Queenbee
			return true;
		}
	}
	if(old.room == 41 || old.room == 37 || old.room == 45 || old.room == 33){
		if(current.room == 10){
			//Before Aile/Vent split
			return true;
		}
	}
	if(old.room == 49 && current.room == 10){
		// After Aile/Vent
		return true;
	}
	if(old.room == 53 || old.room == 4){
		if(current.room == 50){
			// Argoyle Ugoyle / Hedgeshock
			return true;		
		}
		if(current.room == 6){
			// Argoyle Ugoyle / Hedgeshock
			return true;		
		}
	}
	if(old.room == 56 && current.room == 6){
		// Bifrost
		return true;
	}
	if(old.room == 56 && current.room == 58){
		// Prometheus and Pandora
		return true;
	}
	if(old.room == 61 && current.room == 10){
		// Prometheus and Pandora
		return true;
	}
	if(old.room == 63 && current.room == 64){
		// Prometheus and Pandora
		return true;
	}
}
 
gameTime{
    return TimeSpan.FromSeconds(current.IGT / 60.0); 
}

//created by Flameberger and Ikkisoad
//Special Thx to Fatalis, blastedt and DrTchops.
//Comments from Ikkisoad