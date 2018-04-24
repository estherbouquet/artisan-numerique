// SEUIL QUI PERMET DE DETERMINER UNE ZONE QUI EST FILMEE OU PAS
//on importe la bibliothèque dont on a besoin -> openkinect
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

//on crée un nouvel objet kinect2 de type Kinect2
Kinect2 kinect2;

//on vient créer des variables pour notre seuil :
float minThresh = 650;
float maxThresh = 700;

PImage img; //créée pour pouvoir voir par la couleur les limites du seuil

void setup() {
  //size(800, 600, P3D);
  size(512, 424, P3D);
  kinect2 = new Kinect2(this); //on initialise dans kinect2 un nouvel objet Kinect2
  kinect2.initDepth(); //initialise la profondeur
  kinect2.initDevice(0, 1); //initialise la kinect

  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB); //taille de notre fenêtre
  //createImage -> methode qui crée a blank image
}


void draw() {
  background(0);  

  img.loadPixels(); //pour pouvoir opérer sur tous les px de l'image

  //pour ajuster les valeurs des varibles du seuil
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, height, 0, 4500);

  //get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();

  for (int x = 0; x<kinect2.depthWidth; x++) { //sur toute la largeur et p our tous les skip pixels
    for (int y =0; y<kinect2.depthHeight; y++) { //sur toute la hauteur et pour tous les skip pixels

      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      if (d>minThresh && d<maxThresh) { //y -> pour ne pas avoir la table
        img.pixels[offset] = color(map(d, minThresh, maxThresh, 0, 255) );
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0); //on affiche cette image

  //fill(255);
  //text(minThresh + " // " + maxThresh, 20, 20);
}
