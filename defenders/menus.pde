void startMenu()
{
  loopSong("menu");
  stroke(0);
  strokeWeight(1);
  background(0);
  image(icons.get(7),width/2,height/6);
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
          else if(i==2)
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
  image(icons.get(9),width/2,height/6);
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
        if(i==2)
          exit();
      }
    }
  }
}
