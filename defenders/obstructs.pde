class Obstruct
{
  float x,y,harm;
  int id;
  PImage picture;
  boolean block;
  Obstruct(float x,float y,int id,boolean block, float harm)
  {
    this.x=x;
    this.y=y;
    this.id=id;
    this.picture=cMaps.get(this.id).getImage();
    this.harm=harm;
    this.block=block;
  }
  void display()
  {
    image(this.picture,this.x,this.y,128,128);
  }
  float getX()
  {
    return this.x;
  }
  float getY()
  {
    return this.y;
  }
  boolean doesBlock()
  {
    return this.block;
  }
}
class ColorMap
{
  int id;
  color c;
  PImage picture;
  boolean block;
  float harm;
  ColorMap(int id, color c, int block, float harm)
  {
    this.id=id;
    this.c=c;
    this.picture=loadImage("obstructs/"+id+".png");
    this.block=block>0;
    this.harm=harm;
  }
  int getId()
  {
    return this.id;
  }
  color getColor()
  {
    return this.c;
  }
  PImage getImage()
  {
    return this.picture;
  }
  boolean doesBlock()
  {
    return this.block;
  }
  float getHarm()
  {
    return this.harm;
  }
}
