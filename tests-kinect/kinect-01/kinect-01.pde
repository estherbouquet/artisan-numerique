import org.openkinect.processing.*;

//on crée un objet kinect2 qui est de type Kinect2 et qui contient null pour l'instant car pas initialisé
Kinect2 kinect2;

void setup(){
  size(800,600);
  LibraryPath libPath = new LibraryPath();
  String path = libPath.getDir()+"/v2/linux/";
  System.load(path+"libfreenect2.so");
  System.load(path+"libturbojpeg.so.0");
  
  //System.out.println(System.getProperty("os.name").toLowerCase());
  kinect2 = new Kinect2(this); //on initialise un nouvel objet Kinect2 dans kinect2
  kinect2.initDevice();//on commence à communiquer avec la kinect
}

void draw() {
  PImage video = kinect2.getVideoImage();
  image(video, 0, 0);

}
