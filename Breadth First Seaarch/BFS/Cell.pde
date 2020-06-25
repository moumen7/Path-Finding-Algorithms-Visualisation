import java.util.Vector;

class Cell
{
   //coordinates
   int i;
   int j;
   //dimisions
   int w;
   int h;
   //grid
   int rows;
   int cols;
   //wall or not
   boolean wall = false; 
   //color
   color col;
   //visited, 0 for not visited, 1 for visited
   boolean visited = false;
   //parent
   Cell parent;
   Vector<Cell> neighbours;
   
   public Cell(int i, int j, int w, int h, int rows, int cols)
   {
     col = color(255);
     this.i = i;
     this.j = j;
     this.w = w;
     this.h = h;
     this.rows = rows;
     this.cols = cols;
     this.neighbours = new Vector<Cell>();
   }
   
   public void show()
   {
      fill(this.col);
      stroke(0);
      rect(this.i * w , this.j * h, w - 1, h - 1); 
   }
   public void explore_Neighbours(Cell[][] grid, Queue<Cell> q)
   {
     int di[] = { -1, 1, 0, 0 };
     int dj[] = { 0, 0, 1, -1 };
      
      for(int k=0; k<4; k++)
      {
          int new_i = this.i + di[k];
          int new_j = this.j + dj[k];

          if(new_i < 0 || new_j < 0)
              continue;
          if(new_i >= this.rows || new_j >= this.cols)
              continue;
          
          Cell neighbour = grid[new_i][new_j];
          if(neighbour.visited == true)
              continue;
          if(neighbour.wall == true)
              continue;
          
          q.add(neighbour);
          this.neighbours.add(neighbour);
          neighbour.setVisited(true);
          neighbour.setParent(this);
              
              
        
      }
   }
   
   
   //SETTERS
   public void setParent(Cell parent)
   {
      this.parent = parent; 
   }
   public void setCol(color col)
   {
      this.col = col; 
   }
   public void setVisited(boolean visited)
   {
      this.visited = true;
      this.col = color(255,204,0);
   }
   
   
   
   
   
   
   
   
   
   
}
