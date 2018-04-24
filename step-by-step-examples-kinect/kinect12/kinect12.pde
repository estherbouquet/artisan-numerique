// QUADRILLER LA VIDEO EN X, Y, ET Z SELON LA BRIGTHNESS 
import processing.dxf.*;
boolean record = false;

//on importe la bibliothèque dont on a besoin -> openkinect
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

//on crée un nouvel objet kinect2 de type Kinect2
Kinect2 kinect2;
//float a = 3; //pour valeur fixe de face
//float a =0;
void setup() {

  //size(512, 424, P3D);
  size(800, 600, P3D);
  kinect2 = new Kinect2(this); //on initialise dans kinect2 un nouvel objet Kinect2
  kinect2.initDepth(); //initialise la profondeur
  kinect2.initDevice(0, 1); //initialise la kinect
}


void draw() {
  background(0);  

  if (record == true) {
    beginRaw(DXF, "output.dxf"); // Start recording to the file
  }

  //on vient ensuite stocker ce qu'enregistre la kinect sur laquelle on applique 
  //la méthode getDepthImage dans un PImage
  //PImage img = kinect2.getDepthImage(); 
  //image(img, 0, 0); //et on l'affiche youpi
  pushMatrix();
  translate(width/2, height/2, -1100);
  //rotateY(a);


  //variable skip -> permet de "sauter" des pixels et afficher une résolution plus basse
  int skip = 5;

  //get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();

lights();
  //stroke(255);
  //strokeWeight(1);
  noStroke();
  fill(255);

  beginShape(POINTS);

  for (int x = 0; x<kinect2.depthWidth; x+=skip) { //sur toute la largeur et pour tous les skip pixels
    for (int y =0; y<kinect2.depthHeight; y+=skip) { //sur toute la hauteur et pour tous les skip pixels

      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];

      //calculate the x, y, z camera position based on the depth info
      PVector point = depthToPointCloudPos(x, y, d);

      //draw a point
      //vertex(x,y,0);
      //beginShape(TRIANGLES);
      //vertex(point.x+10, point.y, point.z);
      //vertex(point.x, point.y, point.z+10);
      //endShape();
      //vertex(point.x, point.y, point.z);
      
      pushMatrix();
      translate(point.x, point.y, point.z);
      box(20);
      popMatrix();
    }
  }
  endShape();

  popMatrix();

  //fill(255);
  text(frameRate, 50, 50);
  //text(a, 50, 150);

  //rotate
  //a+=0.0015;

  if (record == true) {
    endRaw();
    record = false; // Stop recording to the file
  }
}

//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}



void keyPressed() {
  if (key == 'R' || key == 'r') { // Press R to save the file
    record = true;
  }
}
