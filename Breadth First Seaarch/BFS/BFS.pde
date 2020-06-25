import java.util.LinkedList; 
import java.util.Queue;
import java.util.Dictionary; 

int cols = 10;
int rows = 10;
int w, h;
int start_i=0, start_j=0;
int target_i = 5, target_j=9;
Queue<Cell> q;
Cell root, end;
Cell grid[][];
Cell child;
boolean found = false;

void setup()
{
   size(800, 800);
   background(255);
   
   
   w = width / rows;
   h = height / cols;
   grid = new Cell[rows][cols];
   init();
   root = grid[start_i][start_j];
   root.parent = null;
   end = grid[target_i][target_j];
   child = null;
   q = new LinkedList<Cell>(); 
   root.setVisited(true);
   q.add(root);
   
   
   
   
   
}

void draw()
{
  
  if(!q.isEmpty() && !found)
  {
    Cell current = q.remove();
    if(current == end)
    {
        found = true;
        current.col = color(0);
        child = current;
        System.out.println("Found\n" + current.i + "\t" + current.j);
    }
    else
    {
        current.explore_Neighbours(grid, q);
    }
  }
  
  if(found)
  {
      child = find_parent(child);
  }
  
  
  
  show();
}

Cell find_parent(Cell temp)
{
   Cell current = temp;
   if(current.parent != null)
   {
       current = current.parent;
       current.setCol(color(0, 0, 128));
   }
   return current;
}

void show()
{
  for(int i=0; i<rows; i++)
  {
     for(int j=0; j<cols; j++)
     {
        grid[i][j].show();
     }
  } 
}

void init()
{
  for(int i=0; i<rows; i++)
  {
     for(int j=0; j<cols; j++)
     {
        grid[i][j] = new Cell(i, j, w, h, rows, cols);
     }
  }
}
