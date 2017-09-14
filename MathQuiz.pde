// a random math quiz
// test on parse int...finish
// adding two 2-digit numbers...sounds ok
// timer...ok
// score...ok
// 1 min countdown...
// rest between epochs (output start and end signal and score)

Quiz q;

void setup() {
  size(800,600);
  q = new Quiz(100,50,400,300);
}

void draw() {
  q.update();
  q.display();
  println(q.keyOutput, q.stageOutput);
}

void keyPressed() {
  q.myKeyPressed();
}  

void mousePressed() {
  q.myMousePressed();
}