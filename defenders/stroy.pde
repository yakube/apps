void stroyDraw()
{
  background(0);
  stroke(0);
  stroyDisplay();
  stroyPad();
}
void stroyDisplay()
{
  loopSong("stroy");
  background(0);
  image(bg, width/2, bg.width/2);
}
void stroyPad()
{
  fill(200,200,0);
  strokeWeight(4);
  rect(width/2, (bg.height+height)/2, width, height-bg.height);
  line(0, (bg.height+height)/2, width, (bg.height+height)/2);
  line(width/2, bg.height, width/2, height);
  fill(150);
  strokeWeight(20);
  ellipse(width/4, (bg.height+height)/2, width/3, width/3);
  ellipse(3*width/4, (bg.height+height)/2, width/3, width/3);
  //textSize(40);
  fill(0);
  if(stroindex>0)
    text("Previous",width/4, (bg.height+height)/2);
  if(stroindex<numStroys)
    text("Next",3*width/4, (bg.height+height)/2);
  else
    text("Finish",3*width/4, (bg.height+height)/2);
  textAlign(RIGHT, BOTTOM);
  textSize(60);
  fill(100,100,0);
  text("Story View\t\t", width, height-5);
  textAlign(CENTER, CENTER);
}
void stroisePressed()
{
  if(dist(mouseX,mouseY,3*width/4, (bg.height+height)/2)<width/6)//next
  {
    if(stroindex<numStroys)
    {
      ellipse(3*width/4, (bg.height+height)/2, width/3, width/3);
      stroindex++;
      bg=loadImage("stroys/"+stroindex+".png");
    }
    else
    {
      sceneDraw="free";
      bg=loadImage(macroAddress);
      eComba.killed();
      saveStuff();
    }
  }
  else if(dist(mouseX,mouseY,width/4, (bg.height+height)/2)<width/6&&stroindex>0)//previous
  {
    ellipse(width/4, (bg.height+height)/2, width/3, width/3);
    stroindex--;
    bg=loadImage("stroys/"+stroindex+".png");
  }
}
