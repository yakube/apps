class Entity
{
  float x, y, hp, ap;
  boolean lb, rb, ub, db, dead;
  int eid, id, lastD;
  EntityType et;
  ArrayList<Action> myMoves;
  Entity(int id, int eid, float x, float y)
  {
    this.x=x;
    this.y=y;
    this.id=id;
    this.eid=eid;
    if(eid>=0)
    {
      this.et=entypes.get(eid);
      this.myMoves=this.et.getMoves();
      this.hp=this.et.getMhp();
      this.ap=this.et.getMap();
    }
    //this.myMoves=new ArrayList<Action>();
    lastD=0;
    this.dead=false;
  }
  PImage entPic(int side)
  {
    return this.et.getFace(side);
  }
  void frDisplay()
  {
    if (!this.dead&&this.eid>=0)
      image(this.et.getFace(lastD), this.x, this.y);
  }
  float getAp()
  {
    return this.ap;
  }
  float getHp()
  {
    return this.hp;
  }
  void setAp(float ap)
  {
    this.ap=ap;
  }
  void setHp(float hp)
  {
    this.hp=hp;
  }
  //EntityType getEt()
  //{
  //return this.et;
  //}
  Action getAction(int slot)
  {
    return this.myMoves.get(slot);
  }
  String myName()
  {
    return this.et.myName();
  }
  void move(float x, float y)
  {
    this.lb=false;
    this.rb=false;
    this.ub=false;
    this.db=false;
    float moveX=x;
    float moveY=y;
    for (int i=0; i<obs.size(); i++)//hitboxes work
    {
      this.lb=false;
      this.rb=false;
      this.ub=false;
      this.db=false;
      if (obs.get(i).doesBlock())
      {
        if (this.x+64>obs.get(i).getX()-64&&this.x-64<obs.get(i).getX()+64&&this.getY()-64<=obs.get(i).getY()+64&&this.getY()>obs.get(i).getY())
        {
          this.ub=true;
        }
        if (this.x+64>obs.get(i).getX()-64&&this.x-64<obs.get(i).getX()+64&&this.getY()+64>=obs.get(i).getY()-64&&this.getY()<obs.get(i).getY())
        {
          this.db=true;
        }
        if (this.y+64>obs.get(i).getY()-64&&this.y-64<obs.get(i).getY()+64&&this.getX()-64<=obs.get(i).getX()+64&&this.getX()>obs.get(i).getX())
        {
          this.lb=true;
        }
        if (this.y+64>obs.get(i).getY()-64&&this.y-64<obs.get(i).getY()+64&&this.getX()+64>=obs.get(i).getX()-64&&this.getX()<obs.get(i).getX())
        {
          this.rb=true;
        }
        if (abs(this.x-obs.get(i).getX())>abs(obs.get(i).getY()-this.y))//horizontal is more collided
        {
          if (this.rb)
            this.x=obs.get(i).getX()-128;
          else if (this.lb)
            this.x=obs.get(i).getX()+128;
        }
        else if(abs(this.x-obs.get(i).getX())<abs(obs.get(i).getY()-this.y))
        {
          if (this.ub)
            this.y=obs.get(i).getY()+128;
          else if (this.db)
            this.y=obs.get(i).getY()-128;
        }
      }
    }
    if(abs(moveX)>0&&abs(moveY)>0)//special diagonal cases
    {
      if ((moveY>0&&!this.db))
      {
        this.y+=moveY;
        if(lastD==2)
          lastD=0;
      }
      else if ((moveY<0&&!this.ub))
      {
        this.y+=moveY;
        if(lastD==0)
          lastD=2;
      }
      if((moveX>0&&!this.rb))
      {
        this.x+=moveX;
        if(lastD==1)
          lastD=3;
      }
      else if((moveX<0&&!this.lb))
      {
        this.x+=moveX;
        if(lastD==3)
          lastD=1;
      }
    }
    else if ((moveY>0&&!this.db)||(moveY<0&&!this.ub))//only vertical
    {
      this.y+=moveY;
      if (moveY>0)
        lastD=0;
      else if (moveY<0)
        lastD=2;
    }
    else if ((moveX>0&&!this.rb)||(moveX<0&&!this.lb))//only horizontal
    {
      this.x+=moveX;
      if (moveX>0)
        lastD=3;
      else if (moveX<0)
        lastD=1;
    }
  }
  float getX()
  {
    return this.x;
  }
  float getY()
  {
    return this.y;
  }
  void setX(float x)
  {
    this.x=x;
  }
  void setY(float y)
  {
    this.y=y;
  }
  boolean isPlayer()
  {
    if(this.eid>=0)
      return this.et.getAllId()==0;
    return false;
  }
  void setMoves(int a1, int a2, int a3, int a4)
  {
    if (a1>=0)
      this.myMoves.set(0, actions.get(a1));
    if (a2>=0)
      this.myMoves.set(1, actions.get(a2));
    if (a3>=0)
      this.myMoves.set(2, actions.get(a3));
    if (a4>=0)
      this.myMoves.set(3, actions.get(a4));
  }
  void killed()
  {
    this.dead=true;
  }
  boolean isDead()
  {
    return this.dead;
  }
  int getEid()
  {
    return this.eid;
  }
  int getId()
  {
    return this.id;
  }
}
