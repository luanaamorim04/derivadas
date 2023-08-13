void setup()
{
  size(700, 700);
  background(255);
}

void cartesiano(int marg, int tam)
{
  int spaceX = 10;
  int spaceY = 10;

  for (int i = 0; i <= width; i+=spaceX)
  {
    stroke(240);
    line(i, height, i, 0);
  }

  for (int i = 0; i <= height; i+=spaceY)
  {
    line(0, i, width, i);
  }

  stroke(0);
  line(marg, marg, marg, height-marg);
  line(marg, height-marg, width-marg, height-marg);

  int txtSize = (str(tam).length()+1)*10;
  textSize(30);
  fill(255, 0, 0);
  text("0", marg-20, height-marg+20);
  text(str(tam), width-marg, height-marg+20);
  text(str(tam), marg-txtSize, marg+10);
}

float f(float x)
{
  return x*x;
}

float posX(float x, int margin)
{
  return x+margin;
}

float posY(float y, int margin)
{
  return (height-y-margin);
}

void dbug(String s)
{
  textSize(30);
  fill(255, 0, 0);
  text(s, 100, height/2);
}

void imprime(int margin, int range, int tam)
{
  String resp = "";
  float lastX = posX(0, margin), lastY = posY(0, margin);
  stroke(255, 0, 0);
  float add = (width-(2*margin)) / (float)tam;
  //dbug(str(add));
  
  float x, count = 0;
  for (x = 0; x <= width-(2*margin); x += add)
  {
    float xx = posX(x, margin);
    float yy = posY(f(x), margin);
    line(lastX, lastY, xx, yy);
    lastX = xx;
    lastY = yy;
    count += 1;
    resp += yy;
    resp += " ";
  }
  
  dbug(resp);
}

void draw()
{
  cartesiano(50, 1);
  imprime(50, 1, 1);
}
