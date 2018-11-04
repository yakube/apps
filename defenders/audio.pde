void loopSong(String kee)
{
  if(kee=="menu"&&music.get(0).isPlaying()==false)//hellish menu music
  {
    song.stop();
    song=music.get(0);
  }
  else if(kee=="combat"&&!music.get(1).isPlaying()&&!music.get(2).isPlaying())//combat music-quicker pace
  {
    song.stop();
    song=music.get(1+floor(random(2)));
  }
  else if(kee!="combat"&&kee!="menu"&&!music.get(3).isPlaying()&&!music.get(4).isPlaying()&&!music.get(5).isPlaying()&&!music.get(6).isPlaying())//freeroam and default music
  {
    song.stop();
    song=music.get(floor(random(4))+3);
  }
  if(!song.isPlaying())
    song.play();
}//music overall is a little loud, perhaps lower volume later
