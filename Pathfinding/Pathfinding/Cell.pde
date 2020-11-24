import java.util.Vector;


class Cell
{
   //coordinates
    int i;
    int j;
   //dimisions
    int w;
    int h;
  

   //wall or not
   private boolean wall = false; 
   //color
   private color col;
   //visited or not
   private boolean visited = false;
    private Cell parent;
   //parent

  
   
   public Cell(int i, int j, int w, int h)
   {
     col = color(255);
     this.i = i;
     this.j = j;
     this.w = w;
     this.h = h;
   }
   
   
   public void show()
   {
      fill(this.col);
      stroke(0);
      rect(this.j * h, this.i * w, h - 1, w - 1); 
   }
   
    public void setParent(Cell parent)
   {
      this.parent = parent; 
   }
   //SETTERS
 
   public void setCol(color col)
   {
      this.col = col; 
   }
   public void setVisited(boolean visited)
   {
      this.visited = visited;
      this.col = color(255,255,0);
   }
   public void setWall(boolean wall)
   {
      this.wall = wall;
      this.col = color(0);
   }
  
   
}
