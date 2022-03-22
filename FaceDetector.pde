import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
//Detectores
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;


class FaceDetector {
  private Capture cam;
  private CVImage img;

  //Cascadas para detección
  private CascadeClassifier face;
  //Nombres de modelos
  private String faceFile;
  
  public FaceDetector(PApplet parent) {
    //Cámara
    cam = new Capture(parent, width , height);
    //cam = new Capture(parent, "pipeline:autovideosrc");
    cam.start(); 
    
    //OpenCV
    //Carga biblioteca core de OpenCV
    System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
    println(Core.VERSION);
    
    img = new CVImage(cam.width, cam.height);
    
    //Detectores
    faceFile = "haarcascade_frontalface_default.xml";
    face = new CascadeClassifier(dataPath(faceFile));
  }
  
  public Rect[] scan() {
    if (!cam.available()) return null;
    
    cam.read();
    
    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 0, 0, img.width, img.height);
    img.copyTo();
      
    //Imagen de grises
    Mat gris = img.getGrey();
    
    //Imagen de entrada
    image(img,0,0);
 
    Mat auxroi;
    
    //Detección de rostros
    MatOfRect faces = new MatOfRect();
    face.detectMultiScale(gris, faces, 1.15, 3, Objdetect.CASCADE_SCALE_IMAGE, new Size(60, 60), new Size(200, 200));
    Rect [] facesArr = faces.toArray();
    
     //Dibuja contenedores
    noFill();
    stroke(255,0,0);
    strokeWeight(4);
    rectMode(CENTER);
    for (Rect r : facesArr) {
      rect(r.x + r.width/2, r.y + r.height/2, r.width, r.height);
    }

    faces.release();
    gris.release();
    return facesArr;
  }
}
