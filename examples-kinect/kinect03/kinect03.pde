// QUADRILLER LA VIDEO DE LA KINECT SELON LA BRIGHTNESS

//on importe la bibliothèque dont on a besoin -> openkinect
import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

//on crée un nouvel objet kinect2 de type Kinect2
Kinect2 kinect2;

void setup() {

  size(512, 424);
  kinect2 = new Kinect2(this); //on initialise dans kinect2 un nouvel objet Kinect2
  kinect2.initDepth(); //initialise la profondeur
  kinect2.initDevice(0,1); //initialise la kinect
}


void draw() {
  background(0);  

  //on vient ensuite stocker ce qu'enregistre la kinect sur laquelle on applique 
  //la méthode getDepthImage dans un PImage
  PImage img = kinect2.getDepthImage(); 
  image(img, 0, 0); //et on l'affiche youpi


  //variable skip -> permet de "sauter" des pixels et afficher une résolution plus basse
  int skip = 15;
  for (int x = 0; x<img.width; x+=skip) { //sur toute la largeur et pour tous les skip pixels
    for (int y =0; y<img.height; y+=skip) { //sur toute la hauteur et pour tous les skip pixels
      // passer d'une tableau double entrée à une entrée -> x+y*width
      int index = x+y *img.width; 
      // on vient récupérer la luminosité pour chaque pixel qu'on stocke dans b
      float b = brightness(img.pixels[index]);
      // et on affiche un rectangle qu'on remplit avec b
      fill(b);
      pushMatrix(); //on vient créer une matrice de transformation
      // dans laquelle on vient faire une translation suivant x et y
      translate(x, y);
      rect(0, 0, skip, skip); //taille du rect de la même valeur que le skip
      popMatrix();
    }
  }
}
