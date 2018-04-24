// AFFICHER CE QUE VOIT LA KINECT EN PROFONDEUR

//on importe la bibliothèque dont on a besoin -> openkinect
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

//on crée un nouvel objet kinect2 de type Kinect2
Kinect2 kinect2;

void setup() {
  
  size(512,424);
  kinect2 = new Kinect2(this); //on initialise dans kinect2 un nouvel objet Kinect2
  kinect2.initDepth(); //initialise la profondeur
  kinect2.initDevice(0, 1);   //initialise la kinect
}


void draw() {
  background(0);  
  
  //on vient ensuite stocker ce qu'enregistre la kinect sur laquelle on applique 
  //la méthode getDepthImage dans un PImage
  PImage img = kinect2.getDepthImage(); 
  image(img,0,0); //et on l'affiche youpi
}
