
interface Collisionable {
  
  HitBox getHitBox();
  
}


class HitBox {
  
  PVector position;
  float boxWidth;
  float boxHeight;
  float boxDepth;
  PShape boundingBox;
  
  public HitBox(PShape model, PVector position) {
    HashMap<String,Float> modelBounds = new HashMap();
    modelBounds.put("xMin", MAX_FLOAT);
    modelBounds.put("xMax", MIN_FLOAT);
    modelBounds.put("yMin", MAX_FLOAT);
    modelBounds.put("yMax", MIN_FLOAT);
    modelBounds.put("zMin", MAX_FLOAT);
    modelBounds.put("zMax", MIN_FLOAT);
    getMeshBounds(model, modelBounds);
    boxWidth = modelBounds.get("xMax") - modelBounds.get("xMin");
    boxHeight = modelBounds.get("yMax") - modelBounds.get("yMin");
    boxDepth = modelBounds.get("zMax") - modelBounds.get("zMin");
    this.boundingBox = createShape(BOX, boxWidth, boxHeight, boxDepth);
    this.position = position;
  }

}

public void getMeshBounds(PShape mesh, HashMap<String,Float> boundContainer) {
  if (mesh.getChildCount() > 0) {
    for (PShape child : mesh.getChildren()) {
      getMeshBounds(child, boundContainer);
    }
  }
  PVector vertex;
  for (int i = 0; i < mesh.getVertexCount(); i++) {
    vertex = mesh.getVertex(i);
    if (vertex.x < boundContainer.get("xMin")) {
      boundContainer.put("xMin", vertex.x);
    } 
    if (vertex.x > boundContainer.get("xMax")) {
      boundContainer.put("xMax", vertex.x);
    }
    if (vertex.y < boundContainer.get("yMin")) {
      boundContainer.put("yMin", vertex.y);
    } 
    if (vertex.y > boundContainer.get("yMax")) {
      boundContainer.put("yMax", vertex.y);
    }
    if (vertex.z < boundContainer.get("zMin")) {
      boundContainer.put("zMin", vertex.z);
    }
    if (vertex.z > boundContainer.get("zMax")) {
      boundContainer.put("zMax", vertex.z);
    }
  }
}


public boolean areColliding(HitBox a, HitBox b) {
  return (a.position.x - a.boxWidth/2 <= b.position.x + b.boxWidth/2 && a.position.x + a.boxWidth/2 >= b.position.x - b.boxWidth/2) &&
         (a.position.y - a.boxHeight/2 <= b.position.y + b.boxHeight/2 && a.position.y + a.boxHeight/2 >= b.position.y - b.boxHeight/2) &&
         (a.position.z - a.boxDepth/2 <= b.position.z + b.boxDepth/2 && a.position.z + a.boxDepth/2 >= b.position.z - b.boxDepth/2);
}
