import java.util.LinkedList; 
import java.util.Queue; 

int cols = 15;
int rows = 15;
int w, h;
int start_i=0, start_j=0;
int target_i = rows-1, target_j=cols-1;
Queue<Cell> q;
Cell root, end;
Cell grid[][];
Cell child;
boolean found = false;
boolean target_identified = false;
boolean start_identified = false;
boolean clicked = false;


void setup()
{
   size(800, 800);
   background(255);
   
   
   w = width / rows;
   h = height / cols;
   grid = new Cell[rows][cols];
   init();
   end = grid[target_i][target_j];
   child = null;
   q = new LinkedList<Cell>(); 
   
}

void draw()
{
  
  if(!clicked && mousePressed && !start_identified)
  {
    start_i = mouseY / w;
    start_j = mouseX / h;
    
     start_identified = true;
     root = grid[start_i][start_j];
     root.parent = null;
     root.setVisited(true);
     root.col = color(0, 255, 0);
     q.add(root);
     println(start_i);
     println(start_j);  
  }
  else if(clicked && mousePressed && !target_identified)
  {
    target_i = mouseY / w;
    target_j = mouseX / h;
    target_identified = true;
    end = grid[target_i][target_j];
    end.col = color(255, 0, 0);
    println(target_i);
    println(target_j);
  }
  
  if(start_identified && target_identified)
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
    
    
  }
  
  show();
}

Cell find_parent(Cell temp)
{
   Cell current = temp;
   if(current.parent != null)
   {
       current = current.parent;
       current.setCol(color(0, 255, 0));
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

void mouseClicked()
{
  if(!clicked)
  {
    start_i = mouseY / w;
    start_j = mouseX / h;
    clicked = true;
    /*println("start");
    println(start_i);
    println(start_j);*/
  }
  else if(clicked)
  {
    target_i = mouseY / w;
    target_j = mouseX / h;
    /*println("end");
    println(target_i);
    println(target_j);*/
  }

  /*println(mouseX);
  println(mouseY); */
  
}
