
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
    HashMap<String,Float> modelBounds = getMeshBounds(model);
    boxWidth = modelBounds.get("xMax") - modelBounds.get("xMin");
    boxHeight = modelBounds.get("yMax") - modelBounds.get("yMin");
    boxDepth = modelBounds.get("zMax") - modelBounds.get("zMin");
    this.boundingBox = createShape(BOX, boxWidth, boxHeight, boxDepth);
    this.position = position;
  }

}

public HashMap<String,Float> getMeshBounds(PShape mesh) {
  PVector vertex;
  float xMin = MAX_FLOAT, yMin = MAX_FLOAT, zMin = MAX_FLOAT;
  float xMax = MIN_FLOAT, yMax = MIN_FLOAT, zMax = MIN_FLOAT;
  for (int i = 0; i < mesh.getVertexCodeCount(); i++) {
    vertex = mesh.getVertex(i);
    if (vertex.x < xMin) {
      xMin = vertex.x;
    } 
    if (vertex.x > xMax) {
      xMax = vertex.x;
    }
    if (vertex.y < yMin) {
      yMin = vertex.y;
    } 
    if (vertex.y > yMax) {
      yMax = vertex.y;
    }
    if (vertex.z < zMin) {
      zMin = vertex.z;
    }
    if (vertex.z > zMax) {
      zMax = vertex.z;
    }
  }
  HashMap<String,Float> bounds = new HashMap();
  bounds.put("xMin", xMin);
  bounds.put("xMax", xMax);
  bounds.put("yMin", yMin);
  bounds.put("yMax", yMax);
  bounds.put("zMin", zMin);
  bounds.put("zMax", zMax);
  return bounds;
}


public boolean areColliding(HitBox a, HitBox b) {
  return (a.position.x - a.boxWidth/2 <= b.position.x + b.boxWidth/2 && a.position.x + a.boxWidth/2 >= b.position.x - b.boxWidth/2) &&
         (a.position.y - a.boxHeight/2 <= b.position.y + b.boxHeight/2 && a.position.y + a.boxHeight/2 >= b.position.y - b.boxHeight/2) &&
         (a.position.z - a.boxDepth/2 <= b.position.z + b.boxDepth/2 && a.position.z + a.boxDepth/2 >= b.position.z - b.boxDepth/2);
}
