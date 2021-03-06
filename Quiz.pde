class Quiz {
  // draw parameters
  float x, y, w, h;
  
  // game parameters
  int stage;  // 0 start, 1 test, 2(see result), 3 countdown end and restartable
  int score;

  int startTime;
  int duration = 60000;
  int timeLeft;
  int minutes;
  int seconds;

  int num1, num2;
  int answerCorrect;
  String answerStr;
  int answerNum;
  boolean entered;
  boolean pass;
  
  // output info
  int stageOutput;   // 0 1 21 20
  // 0 start waiting (= restart), 
  // 1 input waiting
  // 21 correct waiting
  // 20 false waiting
  boolean keyOutput;  // true when key is down or see

  Quiz(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    stageOutput = 0;
    stage = 0;
  }

  void update() {
    switch(stage) {
      case 0:
        break;
        
      case 1:
        if (keyPressed) {
          keyOutput = true;
        }
        else {
          keyOutput = false;
        }
        timeLeft = startTime + duration - millis();
        if (timeLeft > 0 ) {
          seconds = (timeLeft / 1000) % 60;
          minutes = (timeLeft / 1000) / 60;
        } else {
          stageOutput = 0;
          stage = 3;
        }
        break;
        
      case 3:
        break;
    }
    
  }

  void display() {
    translate(x,y);
    fill(0);
    rect(0,0,w,h);
    switch (stage) {
      case 0:
        
        
        fill(255);
        noStroke();
        textSize(0.058 * h);
        textAlign(CENTER, CENTER);
        text("Click to start quiz.", w/2, h/2);
        break;
        
      case 1:
        fill(255);
        noStroke();
        textSize(0.058 * h);
        textAlign(LEFT, BASELINE);
        text(score, 0.136*w, 0.14*h);
        text(String.format("%02d", minutes) + ":" + String.format("%02d", seconds), 0.136*w, 0.23*h);
        
        textSize(0.08 * h);
        text(num1 + " + " + num2 + " = ?", 0.35*w, 0.46*h);
        if (!entered) {
          text(answerStr, 0.35*w, 0.59*h);
        } else {
          text(answerNum, 0.35*w, 0.59*h);
          
          textSize(0.058 * h);
          textAlign(RIGHT, BASELINE);
          if (pass) {
            text("Correct!", 0.84*w, 0.84*h);
          } else {
            text("Oops~ Try again?", 0.84*w, 0.84*h);
          }
        }
        break;
        
      case 3:
        fill(255);
        noStroke();
        textSize(0.058 * h);
        textAlign(CENTER,CENTER);
        text("Your Score: " + score, w/2, h/2 - h/10);
        text("Click to restart.", w/2, h/2 + h/10);
        break;
    }
    translate(-x,-y);
  }

  void retry() {
    answerStr = "";
    answerNum = 0;
    entered = false;
  }
 
  void newRound() {  // new round of quizes
    score = 0;
    startTime = millis();
    newQuiz();
  }
  
  void newQuiz() {    // new quiz    
    num1 = floor(random(10, 100));
    num2 = floor(random(10, 100));
    answerCorrect = num1 + num2;

    answerStr = "";
    answerNum = 0;
    entered = false;
    pass = false;
  } 

  void myKeyPressed() {
    switch(stage) {
      case 0:
        break;

      case 1:
        if (key <= 57 && key >= 48) {
          if (answerStr.length() < 8)
            answerStr += key;
        }
        if (key == 8) {  // clear stuff
          if (answerStr.length() > 0) {
            answerStr = answerStr.substring(0, answerStr.length()-1);
          }
        } else if (key == ENTER) {
          if (!entered) {
            if (answerStr != "") {
              entered = true;
              answerNum = Integer.parseInt(answerStr);
              answerStr = "";
              if (answerNum == answerCorrect) {
                score ++;
                stageOutput = 21;
                pass = true;
              }
              else {
                stageOutput = 20;
                pass = false;
              }
            }
          }
          else { // if entered
            if (!pass) {
              stageOutput = 1;
              retry();
            }
            else {
              stageOutput = 1;
              newQuiz();
            }
          }
        }
        break;
        
      case 3:
        break;
    } 
    
  }
  
  void myMousePressed() {
    switch (stage) {
      case 0:
        newRound();
        stageOutput = 1;
        stage = 1;
        break;
        
      case 1: 
        break;
        
      case 3:
        newRound();
        stageOutput = 1;
        stage = 1;
        break;
    }
  }
  
}