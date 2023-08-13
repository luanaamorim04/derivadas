void setup()
{
  size(800, 800);
  background(255);
}

int marg = 50;

void cartesiano(float tamX, float tamY, float tempo)
{ 
  background(255);
  tamX/=2;
  tamX += tempo;
  int spaceX = 10, spaceY = 10;
  int meio = width/2;
  //tamX += tempo;

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
  line(meio, marg, meio, height-marg);
  line(marg, (height-marg)/2, width-marg, (height-marg)/2);

  int txtSize = (str(tamX).length()+1)*10;
  textSize(20);
  fill(0, 0, 0);
  text(str(tempo), meio-20, (height-marg)/2 +20);
  text(str(tamX), width-marg, (height-marg)/2+20);
  text(str(tamY), meio-txtSize+10, marg+10);
  text("- "+str(tamY), meio-txtSize, (height-marg) +20);
  
  textSize(30);
  fill(200, 0, 0);
  text("derivada exata", width - 200, 30);
  fill(180, 0, 255);
  text("derivada aprox", width - 200, 60);
  fill(0, 0, 200);
  text("função", width - 200, 90);
}

float f(float x)
{
  return sin(x);
}

float f2(float x)
{
 return cos(x); 
}

float df(float x, float h)
{
  return (f(x + h) - f(x)) / h;
}

float posX(float x)
{
  return x-(width/2);
}

float posY(float y)
{
  return (height/2)-y;
}

void imprime(float tamX, float tamY, float tam, float h, int flag, float tempo)
{
  for (int x = marg; x <= width-marg; x++)
  {
   for (int y = marg; y <= height-marg; y++)
   {
     
   }
    
  }
  
  
  
  
  
  tamX /= (float)2;
  //tamX += tempo;
  float lastX = 0, lastY = 0, xlinha = -tamX-tempo, tot = width-(2*marg), xx, yy, totY;
  if (flag==0)stroke(200, 0, 0);
  else if (flag==1) stroke(180, 0, 255);
  else stroke(0, 0, 200);
  
  float add = tot / (float)tam;
  totY = height - 2*marg;

  for (float x = 0; x <= tot; x += add)
  {
    xx = posX(x);
    if (flag==0) yy = posY(f2(xlinha)*totY/tamY);
    else if (flag==1) yy = posY(df(xlinha, h)*totY/tamY);
    else yy = posY(f(xlinha)*totY/tamY);
    if (x != 0) line(lastX, lastY, xx, yy);
    lastX = xx;
    lastY = yy;
    xlinha += 2*tamX/(float)tam;
  }
}

void solve(float tamX, float tamY, float pontos, float h, float tempo)
{
  cartesiano(tamX, tamY, tempo);
  imprime(tamX, tamY, pontos, h, 0, tempo);
  imprime(tamX, tamY, pontos, h, 1, tempo);
  imprime(tamX, tamY, pontos, h, -1, tempo);
  //cartesiano(tamX, tamY, tempo);
}

float tempo = 0;

void draw()
{
  //tamX, tamY, pontos, h
  
  solve(8, 2, 100, 0.05, tempo);
  tempo+=0.5;
  
  delay(20);
}
