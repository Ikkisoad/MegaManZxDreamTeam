//RAM search addresses: Rooms-020F9130 BossHP-0214FDE4-02150CAA IGT-0215FEA8
//Room values used here: 16-Highway path 18-Room IV of boss rush 19-Final Hallway 
//66-Area-O room where there is a transerver located
//70-Transerver

//About: Resets have to be done manually when the IGT is static - in the Main Menu
//After starting livesplit will keep track of the IGT all the time, it works everytime
//in the run, e.g. if you forget to start the timer, and you start it later in the run
//it will still be accurate because it runs by IGT of the game itself.

//Setup: Edit Layout: + > Control > Scriptable Auto Splitter, browse for the script file
//Have fun and accurate timing c:

state("DeSmuME_0.9.11_x64")
{
    uint IGT : "DeSmuME_0.9.11_x64.exe", 0x55710F8;
	byte bossHP : "DeSmuME_0.9.11_x64.exe", 0x5561EFA;
	byte room : "DeSmuME_0.9.11_x64.exe", 0x5560234;
}

state("DeSmuME_0.9.11_x86")
{
    uint IGT : "DeSmuME_0.9.11_x86.exe", 0x3000D60;
	byte bossHP : "DeSmuME_0.9.11_x86.exe", 0x2FF1B62;
	byte room : "DeSmuME_0.9.11_x86.exe", 0x2FF071C;
}

state("MZZXLC")
{
    uint IGT : "MZZXLC.exe", 0x28B4360;
    byte room : "MZZXLC.exe", 0x293349C;
}
 
start
{
	if(current.IGT != old.IGT && current.room != 72){
		return true;
	}
	
	
}
 
split
{
	if(old.room != 66 && old.room != 16 && old.room != 70 && current.room == 70){
	
		return true;
	
	}
	if(old.room == 18 && current.room == 19){
	
		return true;
	
	}
	
	
}
 
gameTime
{
    return TimeSpan.FromSeconds(current.IGT / 60.0); 
}

//created by Flameberger and Ikkisoad
//Special Thx to Fatalis, blastedt and DrTchops.
//Comments from Ikkisoad