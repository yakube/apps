void freeRoam(ArrayList<Entity> currents)
{
  loopSong("free");
  stroke(0);
  strokeWeight(1);
  boundsDetector(currents);
  generalFRDisplay(currents);
  controlPad(currents);
  collide(currents);
}
void macroMove(char type, ArrayList<Entity> currents)
{
  boolean exceeded=false;
  obs.clear();
  for (int i=currents.size()-1; i>=0; i--)
  {
    if (currents.get(i).isPlayer())
    {
      switch(type)
      {
      case 'n':
        currents.get(i).setY(bg.height-64);
        exceeded=true;
        break;
      case 'e':
        currents.get(i).setX(-448+(width/2));
        exceeded=true;
        break;
      case 's':
        currents.get(i).setY(64);
        exceeded=true;
        break;
      case 'w':
        currents.get(i).setX(448+(width/2));
        exceeded=true;
        break;
      }
    } else
      currents.remove(i);
  }
  if(exceeded)
  {
    switch(type)
      {
      case 'n':
        my++;
        break;
      case 'e':
        mx++;
        break;
      case 's':
        my--;
        break;
      case 'w':
        mx--;
        break;
      }
      saveStuff();
  }
  macroAddress="backgrounds/w"+wid+"/x"+mx+"y"+my+".jpg";
  macroAddress2="spawngrounds/w"+wid+"/x"+mx+"y"+my+".png";
  bg=loadImage(macroAddress);
  sg=loadImage(macroAddress2);
  sg.loadPixels();
  for (int i=0; i<sg.height; i++)//maps spawn colors to pngs
  {
    for (int j=0; j<sg.width; j++)
    {
      for (ColorMap cm : cMaps)
      {
        if (sg.pixels[(i*sg.height)+j]==cm.getColor())
        {
          obs.add(new Obstruct(-448+(width/2)+128*j, 64+128*i, cm.getId(),cm.doesBlock(),cm.getHarm()));
        }
      }
    }
  }
  for(TableRow row:fluse.rows())
  {
    if(row.getInt("mx")==mx&&row.getInt("my")==my&&row.getInt("isDead")==0)
      currentEnts.add(new Entity(row.getInt("id"),row.getInt("eid"),-448+(width/2)+128*row.getInt("x"),64+128*row.getInt("y")));
  }
}
void boundsDetector(ArrayList<Entity> currents)
{
  for (int q=currents.size()-1; q>=0; q--)
  {
    if (currents.get(q).isPlayer())
    {
      if (currents.get(q).getX()>448+(width/2))
      {
        macroMove('e', currents);
        break;
      } else if (currents.get(q).getX()<-448+(width/2))
      {
        macroMove('w', currents);
        break;
      } else if (currents.get(q).getY()<64)
      {
        macroMove('n', currents);
        break;
      } else if (currents.get(q).getY()>bg.height-64)
      {
        macroMove('s', currents);
        break;
      }
    }
  }
}
void generalFRDisplay(ArrayList<Entity> currents)
{
  background(0);
  image(bg, width/2, bg.width/2);
  for (int i=0; i<obs.size(); i++)
  {
    obs.get(i).display();
  }
  for (int i=currents.size()-1; i>=0; i--)
  {
    currents.get(i).frDisplay();
  }
}
void controlPad(ArrayList<Entity> currents)
{
  fill(0, 100, 100);
  strokeWeight(4);
  rect(width/2, (bg.height+height)/2, width, height-bg.height);
  line(0, (bg.height+height)/2, width, (bg.height+height)/2);
  line(width/2, bg.height, width/2, height);
  fill(150);
  strokeWeight(20);
  rect(width/2, (bg.height+height)/2, width/2, width/6);
  rect(width/2, (bg.height+height)/2, width/6, width/2);
  noStroke();
  fill(150);
  rect(width/2, (bg.height+height)/2, width/2, width/6);
  rect(width/2, (bg.height+height)/2, width/6, width/2);

  fill(100);
  if (touches.length==0)
  {
    for (Entity cur : currents)
    {
      if (cur.isPlayer())
      {
        cur.move(0, 0);
      }
      else
      {
         for (Entity cur2 : currents)
          {
            if (cur2.isPlayer())
            {
              if (cur.getX()+2<cur2.getX()-2)
                cur.move(4, 0);
              else if (cur.getX()-2>cur2.getX()+2)
                cur.move(-4, 0);
              if (cur.getY()+2<cur2.getY()-2)
                cur.move(0, 4);
              else if (cur.getY()-2>cur2.getY()+2)
                cur.move(0, -4);
            }
          }
      }
    }
  }
  for (int i=0; i<touches.length; i++)
  {
    if (touches[i].x<width&&touches[i].x>0&&touches[i].y<height&&touches[i].y>bg.height)
    {
      for (Entity cur : currents)
      {
        if (cur.isPlayer())
        {
          if (touches[i].y<((bg.height+height)/2)-width/12)//up
          {
            if (touches[i].x>7*width/12)//up right
            {
              rect(5*width/8, (bg.height+height)/2, width/4, width/6);//right
              rect(width/2, -(width/8)+(bg.height+height)/2, width/6, width/4);//up
              cur.move(8, -8);
            } else if (touches[i].x<5*width/12)//up left
            {
              rect(width/2, -(width/8)+(bg.height+height)/2, width/6, width/4);//up
              rect(3*width/8, (bg.height+height)/2, width/4, width/6);//left
              cur.move(-8, -8);
            }
             else//true up
            {
              rect(width/2, -(width/8)+(bg.height+height)/2, width/6, width/4);//up
              cur.move(0, -8);
            }
          } else if (touches[i].y>((bg.height+height)/2)+width/12)//down
          { 
            if (touches[i].x>7*width/12)//down right
            {
              rect(width/2, (width/8)+(bg.height+height)/2, width/6, width/4);//down
              rect(5*width/8, (bg.height+height)/2, width/4, width/6);//right
              cur.move(8, 8);
            } else if (touches[i].x<5*width/12)//down left
            {
              rect(width/2, (width/8)+(bg.height+height)/2, width/6, width/4);//down
              rect(3*width/8, (bg.height+height)/2, width/4, width/6);//left
              cur.move(-8, 8);
            }
             else//true down
            {
              rect(width/2, (width/8)+(bg.height+height)/2, width/6, width/4);//down
              cur.move(0, 8);
            }
          } else if (touches[i].x>7*width/12)//true right
          {
            rect(5*width/8, (bg.height+height)/2, width/4, width/6);//right
            cur.move(8, 0);
          } else if (touches[i].x<5*width/12)//true left
          {
            rect(3*width/8, (bg.height+height)/2, width/4, width/6);//left
            cur.move(-8, 0);
          } else
            cur.move(0, 0);
        } else
        {
          for (Entity cur2 : currents)
          {
            if (cur2.isPlayer())
            {
              if (cur.getX()+2<cur2.getX()-2)
                cur.move(4, 0);
              else if (cur.getX()-2>cur2.getX()+2)
                cur.move(-4, 0);
              if (cur.getY()+2<cur2.getY()-2)
                cur.move(0, 4);
              else if (cur.getY()-2>cur2.getY()+2)
                cur.move(0, -4);
            }
          }
        }
      }
    }
    else if(dist(touches[i].x,touches[i].y,width/2,0)<250)
    {
      sceneDraw="pause";//go to pause screen
    }
    else
    {
      fadeFrames=150;
    }
  }
  if(fadeFrames>0)
  {
     fill(200,0,0,fadeFrames);
     ellipse(width/2,0,500,500);
     fill(255,255,255,fadeFrames);
     textSize(75);
     text("Pause",width/2,100);
     fadeFrames-=2;
  }
  fill(0);
  rect(width/2, (bg.height+height)/2, 2*width/5, width/24);
  rect(width/2, (bg.height+height)/2, width/24, 2*width/5);
  fill(150);
  rect(width/2, (bg.height+height)/2, width/6, width/6);
  textAlign(RIGHT, BOTTOM);
  textSize(60);
  fill(0, 150, 150);
  text("Control Pad\t\t", width, height);
  textAlign(CENTER, CENTER);
}
void collide(ArrayList<Entity> currents)
{
  for(Entity cur:currents)
  {
    if(cur.isPlayer())
    {
      for(Entity cur2:currents)
      {
        if((!cur2.isPlayer())&&(!cur2.isDead())&&(cur.getX()+50>cur2.getX()-50)&&(cur.getX()-50<cur2.getX()+50)&&(cur.getY()-50<cur2.getY()+50)&&(cur.getY()+50>cur.getY()-50))
         {
            pComba=cur;
            eComba=cur2;
            if(cur2.getEid()<0)
            {
              stroyLim=abs(cur2.getEid());
              sceneDraw="stroy";
              bg=loadImage("stroys/"+stroindex+".png");
            }
            else
            {
              sceneDraw="combat";
              bg=loadImage("backgrounds/battle.jpg");
            }
         }
      }
    }
  }
}
