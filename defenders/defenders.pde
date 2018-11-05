import processing.sound.*;
import android.os.Environment;

PImage bg,sg;
int mx,my,wid,stroindex;
String macroAddress,macroAddress2,basePath;
ArrayList<Obstruct> obs;
ArrayList<ColorMap> cMaps;
ArrayList<Action> actions;
ArrayList<PImage> icons,entPics,entPics1,entPics2,entPics3;//stroys;
ArrayList<SoundFile> music,sounds;
ArrayList<EntityType> entypes;
ArrayList<Entity> currentEnts;
SoundFile song;
Table obsTab, movesTab,entTab,spawnTab,fluvs,fluse;
Entity thePlayer,theEnemy,pComba,eComba;

int numIcons=10;
int numEnt=8;
int numSongs=7;
int numSounds=0;
int numStroys=4;
String sceneDraw="start";
void setup()
{
  cMaps=new ArrayList<ColorMap>();
  actions=new ArrayList<Action>();
  music=new ArrayList<SoundFile>();
  entypes=new ArrayList<EntityType>();
  currentEnts=new ArrayList<Entity>();
  obs=new ArrayList<Obstruct>();
  icons=new ArrayList<PImage>();
  entPics=new ArrayList<PImage>();
  entPics1=new ArrayList<PImage>();
  entPics2=new ArrayList<PImage>();
  entPics3=new ArrayList<PImage>();
  //stroys=new ArrayList<PImage>();
  obsTab=loadTable("tables/obstructs.csv","header");
  movesTab=loadTable("tables/moves.csv","header");
  entTab=loadTable("tables/entyp.csv","header");
  spawnTab=loadTable("tables/spawn.csv","header");
  for(TableRow row:obsTab.rows())//brings in csv file obstructs
  {
    cMaps.add(new ColorMap(row.getInt("id"),color(row.getInt("red"),row.getInt("green"),row.getInt("blue")),row.getInt("block"),row.getInt("harm")));
  }
  for(int i=0; i<numIcons; i++)
  {
    icons.add(loadImage("icons/"+i+".png"));
  }
  for(TableRow row:movesTab.rows())//brings in csv file moves
  {
    actions.add(new Action(row.getInt("id"),row.getString("name"),row.getInt("elementId"),row.getInt("dmg"),row.getInt("ldmg"),row.getInt("iamg"),row.getInt("lamg"),row.getInt("ihp"),row.getInt("lhp"),row.getInt("iap"),row.getInt("lap"),row.getInt("lt"),row.getInt("dm"),row.getInt("am"),row.getInt("s")));
  }
  for(int i=0; i<numEnt; i++)
  {
    entPics.add(loadImage("sprites/fronts/"+i+".png"));
  }
  for(int i=0; i<numEnt; i++)
  {
    entPics1.add(loadImage("sprites/leftFace/"+i+".png"));
  }
  for(int i=0; i<numEnt; i++)
  {
    entPics2.add(loadImage("sprites/backs/"+i+".png"));
  }
  for(int i=0; i<numEnt; i++)
  {
    entPics3.add(loadImage("sprites/rightFace/"+i+".png"));
  }
  for(TableRow row:entTab.rows())//brings in csv file moves
  {
    entypes.add(new EntityType(row.getString("name"),row.getInt("id"),row.getInt("allId"),row.getInt("mhp"),row.getInt("map"),row.getInt("pa"),row.getInt("pa2"),row.getInt("pa3"),row.getInt("pa4")));//testing...
  }
  for(int i=0; i<numSongs; i++)
  {
    music.add(new SoundFile(this,"music/"+i+".wav"));
  }
  //for(int i=0; i<numStroys; i++)
  //{
    //stroys.add(loadImage("stroys/"+i+".png"));//consider reworking if startup takes too long to load
  //}
  currentEnts.add(new Entity(0,3,64+width/2,32+width/2));//the player
  song=music.get(0);
  imageMode(CENTER);
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  orientation(PORTRAIT);
  frameRate(60);
  //stroindex=0;//index along cutscenes
  //bg=stroys.get(0);
}
void draw()
{
  if(sceneDraw=="start")
    startMenu();
  else if(sceneDraw=="combat")
    combat(pComba,eComba,currentEnts);
  else if(sceneDraw=="free")
    freeRoam(currentEnts);
  else if(sceneDraw=="dead")
    dead();
  else if(sceneDraw=="stroy")
    stroyDraw();
}
void newGameSetup()//initialization in the case of new game
{
  sharedSetup();
  fluvs=loadTable("tables/vars.csv","header");
  fluse=loadTable("tables/spawn.csv","header");
  mx=fluvs.getRow(0).getInt("mx");
  my=fluvs.getRow(0).getInt("my");
  wid=fluvs.getRow(0).getInt("wid");
  saveStuff();
  for(Entity cur:currentEnts)
  {
    if(cur.isPlayer())
    {
      cur.setX(fluvs.getRow(0).getInt("x"));
      cur.setY(fluvs.getRow(0).getInt("y"));
      cur.setMoves(fluvs.getRow(0).getInt("a1id"),fluvs.getRow(0).getInt("a2id"),fluvs.getRow(0).getInt("a3id"),fluvs.getRow(0).getInt("a4id"));
      if(fluvs.getRow(0).getInt("hp")>=0)
        cur.setHp(fluvs.getRow(0).getInt("hp"));
      if(fluvs.getRow(0).getInt("ap")>=0)
        cur.setAp(fluvs.getRow(0).getInt("ap"));
    }
  }
  initialization();
}
void sharedSetup()
{
  fluvs=new Table();
  fluvs.addColumn("id");
  fluvs.addColumn("date");
  fluvs.addColumn("time");
  fluvs.addColumn("mx");
  fluvs.addColumn("my");
  fluvs.addColumn("x");
  fluvs.addColumn("y");
  fluvs.addColumn("a1id");
  fluvs.addColumn("a2id");
  fluvs.addColumn("a3id");
  fluvs.addColumn("a4id");
  fluvs.addColumn("hp");
  fluvs.addColumn("ap");
  fluvs.addColumn("stroindex");
  fluvs.addColumn("wid");
  fluse=new Table();
  fluse.addColumn("id");
  fluse.addColumn("eid");
  fluse.addColumn("wid");
  fluse.addColumn("mx");
  fluse.addColumn("my");
  fluse.addColumn("x");
  fluse.addColumn("y");
  fluse.addColumn("isDead");
}
void saveStuff()
{
  fluvs.getRow(0).setInt("id",fluvs.getRow(0).getInt("id")+1);
  println("Save number "+fluvs.getRow(0).getInt("id"));
  fluvs.getRow(0).setString("date",year()+"");
  fluvs.getRow(0).setString("time",hour()+"");
  fluvs.setInt(0,"mx",mx);
  fluvs.setInt(0,"my",my);
  fluvs.setInt(0,"stroindex",stroindex);
  fluvs.setInt(0,"wid",wid);
  for(Entity cur:currentEnts)
  {
    if(cur.isPlayer())
    {
      fluvs.getRow(0).setInt("x",(int)cur.getX());
      fluvs.getRow(0).setInt("y",(int)cur.getY());
      fluvs.setInt(0,"a1id",cur.getAction(0).getId());
      fluvs.setInt(0,"a2id",cur.getAction(1).getId());
      fluvs.setInt(0,"a3id",cur.getAction(2).getId());
      fluvs.setInt(0,"a4id",cur.getAction(3).getId());
      fluvs.setInt(0,"hp",(int)cur.getHp());
      fluvs.setInt(0,"ap",(int)cur.getAp());
    }
    else if(cur.isDead())
    {
      for(TableRow fluseRow:fluse.rows())
      {
        if(fluseRow.getInt("id")==cur.getId())
          fluseRow.setInt("isDead",1);
      }
    }
  }
  saveTable(fluvs,"fluidVars.csv");
  saveTable(fluse,"fluidSpawn.csv");
}
void continueSetup()//load most recent data from r/w files
{
  sharedSetup();
  fluvs=loadTable("fluidVars.csv","header");
  fluse=loadTable("fluidSpawn.csv","header");
  mx=fluvs.getRow(0).getInt("mx");
  my=fluvs.getRow(0).getInt("my");
  wid=fluvs.getRow(0).getInt("wid");
  stroindex=fluvs.getInt(0,"stroindex");
  for(Entity cur:currentEnts)
  {
    if(cur.isPlayer())
    {
      cur.setX(fluvs.getRow(0).getInt("x"));
      cur.setY(fluvs.getRow(0).getInt("y"));
      cur.setMoves(fluvs.getRow(0).getInt("a1id"),fluvs.getRow(0).getInt("a2id"),fluvs.getRow(0).getInt("a3id"),fluvs.getRow(0).getInt("a4id"));
      if(fluvs.getRow(0).getInt("hp")>=0)
        cur.setHp(fluvs.getRow(0).getInt("hp"));
      if(fluvs.getRow(0).getInt("ap")>=0)
        cur.setAp(fluvs.getRow(0).getInt("ap"));
    }
  }
  initialization();
}
void initialization()
{
  wid=fluvs.getInt(0,"wid");
  mx=fluvs.getInt(0,"mx");
  my=fluvs.getInt(0,"my");
  for(TableRow row:fluse.rows())
  {
    if(row.getInt("mx")==mx&&row.getInt("my")==my&&row.getInt("wid")==wid&&row.getInt("isDead")==0)
      currentEnts.add(new Entity(row.getInt("id"),row.getInt("eid"),-448+(width/2)+128*row.getInt("x"),64+128*row.getInt("y")));
  }
  macroAddress="backgrounds/w"+wid+"/x"+mx+"y"+my+".jpg";
  macroAddress2="spawngrounds/w"+wid+"/x"+mx+"y"+my+".png";
  bg=loadImage(macroAddress);
  sg=loadImage(macroAddress2);
  sg.loadPixels();
  for(int i=0; i<sg.height; i++)//handles mapping spawn colors to pngs
  {
    for(int j=0; j<sg.width; j++)
    {
      for(ColorMap cm:cMaps)
      {
        if(sg.pixels[(i*sg.height)+j]==cm.getColor())
        {
          obs.add(new Obstruct(-448+(width/2)+128*j,64+128*i,cm.getId(),cm.doesBlock(),cm.getHarm()));
        }
      }
    }
  }
  print("Current WID: "+wid);
}
void mousePressed()
{
  if(sceneDraw=="stroy")
    stroisePressed();
}
