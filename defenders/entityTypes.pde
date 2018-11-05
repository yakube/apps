class EntityType
{
  String name;
  int allId,id;
  float mhp, map;
  ArrayList<Action> myMoves;
  ArrayList<PImage> faces;
  EntityType(String name, int id, int allId, float mhp, float map, int pa, int pa2, int pa3, int pa4)
  {
    this.name=name;
    this.allId=allId;
    this.mhp=mhp;
    this.map=map;
    this.myMoves=new ArrayList<Action>();
    this.faces=new ArrayList<PImage>();
    this.myMoves.add(actions.get(pa));
    this.myMoves.add(actions.get(pa2));
    this.myMoves.add(actions.get(pa3));
    this.myMoves.add(actions.get(pa4));
    this.faces.add(entPics.get(id));
    this.faces.add(entPics1.get(id));
    this.faces.add(entPics2.get(id));
    this.faces.add(entPics3.get(id));
    this.id=id;
    
  }
  Action getAction(int slot)
  {
    return this.myMoves.get(slot);
  }
  PImage getFace(int side)
  {
    return this.faces.get(side);
  }
  String myName()
  {
    return this.name;
  }
  float getMhp()
  {
    return mhp;
  }
  float getMap()
  {
    return map;
  }
  ArrayList<Action> getMoves()
  {
    return this.myMoves;
  }
  int getAllId()
  {
    return this.allId;
  }
}
class Action
{
  String name;
  int eid,id;
  float dmg,ldmg,iamg,lamg,ihp,lhp,iap,lap,lt,dm,am,s;
  PImage picture;
  Action(int id,String nm,int eid,int dmg,int ldmg,int iamg,int lamg,int ihp,int lhp,int iap,int lap,int lt,int dm,int am,int s)
  {
    this.name=nm;
    this.eid=eid;
    this.dmg=dmg;
    this.ldmg=ldmg;
    this.iamg=iamg;
    this.lamg=lamg;
    this.ihp=ihp;
    this.lhp=lhp;
    this.iap=iap;
    this.lap=lap;
    this.lt=lt;
    this.dm=dm;
    this.am=am;
    this.s=s;
    this.picture=icons.get(eid);
    this.id=id;
  }
  PImage getIcon()
  {
    return this.picture;
  }
  String aName()
  {
    return this.name;
  }
  float getDmg(){return this.dmg;}
  float getLdmg(){return this.ldmg;}
  float getIamg(){return this.iamg;}
  float getLamg(){return this.lamg;}
  float getIhp(){return this.ihp;}
  float getLhp(){return this.lhp;}
  float getIap(){return this.iap;}
  float getLap(){return this.lap;}
  float getLt(){return this.lt;}
  float getDm(){return this.dm;}
  float getAm(){return this.am;}
  float getS(){return this.s;}
  int getId()
  {
    return this.id;
  }
}
