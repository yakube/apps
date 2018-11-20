void startMenu()
{
  loopSong("menu");
  stroke(0);
  strokeWeight(1);
  background(0);
  image(icons.get(16),width/2,height/6);
  textSize(50);
  stroke(255,0,0);
  strokeWeight(8);
  for(int i=0; i<4; i++)
  {
    fill(33);
    rect(width/2,(10+4*i)*height/24,2*width/3,height/10);
  }
  fill(255,255,0);
  if(dataFile("fluidVars.csv").isFile()&&dataFile("fluidSpawn.csv").isFile())//change the file name later to what you save
  {
    text("Continue",width/2,10*height/24);
  }
  else
    text("New Game",width/2,10*height/24);
  text("Load Game",width/2,14*height/24);
  text("Options",width/2,18*height/24);
  text("Exit",width/2,22*height/24);
  for(int i=0; i<4; i++)
  {
    for(int j=0; j<touches.length; j++)
    {
      if(touches[j].x>(width/2)-width/3&&touches[j].x<(width/2)+width/3&&touches[j].y<((10+4*i)*height/24)+height/20&&touches[j].y>((10+4*i)*height/24)-height/20)
      {
        fill(0,0,0,150);
        rect(width/2,(10+4*i)*height/24,2*width/3,height/10);
        if(dataFile("fluidVars.csv").isFile()&&dataFile("fluidSpawn.csv").isFile())
        {
          if(i==0)//new/continue button
          {
            continueSetup();
            sceneDraw="free";
          }
          else if(i==1)//load button
          {
            goToLoad();
          }
          else if(i==2)//options
          {
            dataFile("fluidVars.csv").delete();
            dataFile("fluidSpawn.csv").delete();
          }
        }
        else
        {
          if(i==0)
          {
            newGameSetup();
            sceneDraw="free";
          }
        }
        if(i==3)
          exit();
      }
    }
  }
}
void dead()
{
  loopSong("menu");
  stroke(0);
  strokeWeight(1);
  background(21);
  image(icons.get(17),width/2,height/6);
  textSize(65);
  stroke(255);
  strokeWeight(8);
  for(int i=0; i<3; i++)
  {
    fill(21);
    rect(width/2,(11+5*i)*height/24,width/2,height/10);
  }
  fill(255);
  text("Revive",width/2,11*height/24);
  text("Load Save",width/2,16*height/24);
  text("Perish",width/2,21*height/24);
  for(int i=0; i<3; i++)
  {
    for(int j=0; j<touches.length; j++)
    {
      if(touches[j].x>(width/2)-width/3&&touches[j].x<(width/2)+width/3&&touches[j].y<((11+5*i)*height/24)+height/20&&touches[j].y>((11+5*i)*height/24)-height/20)
      {
        fill(0,0,0,150);
        rect(width/2,(11+5*i)*height/24,width/2,height/10);
        if(i==0)
        {
          continueSetup();
          sceneDraw="free";
        }
        if(i==1)
        {
          goToLoad();
        }
        if(i==2)
          exit();
      }
    }
  }
}
void goToLoad()
{
  continueSetup();
  selctedRow=-1;
  dpment=0;
  sceneReturn=sceneDraw;
  sceneDraw="load";
}
void loadDraw()
{
  if(sceneReturn=="pause")
    loopSong("free");
  else
    loopSong("menu");
  background(0);
  stroke(0);
  strokeWeight(1);
  fill(255);
  textSize(75);
  for(int i=dpment; i<min(fluvs.getRowCount()+dpment,10+dpment); i++)
  {
    text((fluvs.getInt(i,"id")+1)+"\t\t\t\t"+fluvs.getString(i,"date")+"\t\t\t\t"+fluvs.getString(i,"time"),width/2,350+i*125-dpment*125);
  }
  for(int i=0; i<touches.length; i++)
  {
    for(int j=0; j<min(fluvs.getRowCount(),10); j++)
    {
      if(touches[i].y>350+125*j-62&&touches[i].y<350+125*j+62)
        selctedRow=j;
    }
  }
  strokeWeight(4);
  stroke(255);
  if(selctedRow>=0)
  {
    fill(0,100,255,100);
    rect(width/2,350+selctedRow*125,9*width/10,120);
    fill(0,0,0,255);
    for(int i=0; i<touches.length; i++)
    {
      if(touches[i].y>1656.6-60&&touches[i].y<1656.6+60&&touches[i].x>2*width/6&&touches[i].x<4*width/6)//load activated
      {
        fill(175);
        loadSave(dpment+selctedRow);
        sceneDraw="free";
      }
    }
    rect(width/2,1656.5,width/3,120);
    fill(255);
    text("Load",width/2,1656.5);
  }
  fill(0,0,0,255);
  rect(width/2,137,9*width/10,246.6);
  fill(255);
  text("Save Slots",width/2,137);
  fill(0,0,0,255);
  for(int i=0; i<touches.length; i++)
  {
    if(touches[i].y>1656.6-60&&touches[i].y<1656.6+60&&touches[i].x>(5*width/6)-width/8&&touches[i].x<(5*width/6)+width/8)//down acxtivated
    {
      fill(175);
      if(frameCount%5==0&&dpment<fluvs.getRowCount()-10)
        dpment++;
    }
  }
  rect(5*width/6,1656.5,width/4,120);
  fill(255);
  text("\\/",5*width/6,1656.5);
  fill(0,0,0,255);
  for(int i=0; i<touches.length; i++)
  {
    if(touches[i].y>1656.6-60&&touches[i].y<1656.6+60&&touches[i].x>(width/6)-width/8&&touches[i].x<(width/6)+width/8)//up acxtivated
    {
      fill(175);
      if(frameCount%5==0&&dpment>0)
        dpment--;
    }
  }
  rect(width/6,1656.5,width/4,120);
  fill(255);
  text("/\\",width/6,1656.5);
  fill(0);
  for(int i=0; i<touches.length; i++)
  {
    if(touches[i].y>10&&touches[i].y<10+width/6&&touches[i].x>10&&touches[i].x<10+width/6)//back button
    {
      fill(175);
      sceneDraw=sceneReturn;
    }
  }
  rect(10+width/12,10+width/12,width/6,width/6);
  fill(255);
  text("<-",10+width/12,10+width/12);
}
void pauseDraw()
{
  loopSong("free");
  stroke(0);
  strokeWeight(1);
  background(0,0,100);
  textSize(100);
  fill(255);
  text("Pause Menu",width/2,height/6);
  textSize(65);
  stroke(255);
  strokeWeight(8);
  for(int i=0; i<4; i++)
  {
    fill(0,0,100);
    rect(width/2,(8+4*i)*height/24,2*width/3,height/10);
  }
  fill(255);
  text("Resume",width/2,8*height/24);
  text("Load Game",width/2,12*height/24);
  text("Options",width/2,16*height/24);
  text("Quit to Main Menu",width/2,20*height/24);
  for(int i=0; i<4; i++)
  {
    for(int j=0; j<touches.length; j++)
    {
      if(touches[j].x>(width/2)-width/3&&touches[j].x<(width/2)+width/3&&touches[j].y<((8+4*i)*height/24)+height/20&&touches[j].y>((8+4*i)*height/24)-height/20)
      {
        fill(0,0,0,150);
        rect(width/2,(8+4*i)*height/24,2*width/3,height/10);
        if(i==0)
        {
          sceneDraw="free";
        }
        if(i==1)
        {
          goToLoad();
        }
        if(i==3)
          sceneDraw="start";
      }
    }
  }
}
