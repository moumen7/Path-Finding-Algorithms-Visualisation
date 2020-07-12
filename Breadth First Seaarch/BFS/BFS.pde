import java.util.LinkedList; 
import java.util.Queue;
import java.util.Set;
import java.util.HashSet;
import java.util.Random;
import javafx.util.Pair;

int cols = 20;
int rows = 20;
int w, h;
int start_i=0, start_j=0;
int target_i = rows-1, target_j=cols-1;

Queue<Cell> q;
Set<Pair<Integer, Integer>> walls;
Cell root, end;
Cell grid[][];
Cell child;
boolean found;
boolean target_identified;
boolean start_identified;
boolean clicked;
boolean finished;

void setup()
{
  
   size(800, 805);
   background(255);
   target_identified = false;
   start_identified = false;
   clicked = false;
   finished = false;
   found = false;
   w = width / rows - 5;
   h = height / cols;
   grid = new Cell[rows][cols];
   randomize_walls();
   init();
   end = grid[target_i][target_j];
   child = null;
   q = new LinkedList<Cell>(); 
   
}


void draw()
{
  if(keyPressed)
      {
         if(key == ' ')
         {
           setup();
         }
         if(key == '\n')
         {
           exit();  
         }
      }
  if(!clicked && mousePressed && !start_identified)
  {
     start_i = mouseY / w;
     start_j = mouseX / h;
      
     if(start_i < rows &&  start_j < cols)
     {
       start_identified = true;
       root = grid[start_i][start_j];
       
       if(start_identified && root.wall)
       {
          start_identified = false;
          clicked = false;
       }  
       else if(start_identified)
       {
         root.parent = null;
         root.setVisited(true);
         root.col = color(0, 255, 0);
         q.add(root);
       }
     }
     println(start_i);
     println(start_j);  
  }
  else if(clicked && mousePressed && !target_identified)
  {
    target_i = mouseY / w;
    target_j = mouseX / h;
    
    if(target_i < rows &&  target_j < cols)
    {
      target_identified = true;
      end = grid[target_i][target_j];
      
      if(target_identified && end.wall) 
        target_identified = false;
      else if(target_identified)
        end.col = color(255, 0, 0);
    }
    
  }
  
  if(start_identified && target_identified)
  {
    
    if(!q.isEmpty() && !found)
    {
      Cell current = q.remove();
      if(current == end)
      {
          found = true;
          child = end;
          println("Found\n" + end.i + "\t" + end.j);
      }
      else
      {
          if(current.explore_Neighbours(grid, q, end))
          {
              found = true;
              child = end;
              println("Found\n" + end.i + "\t" + end.j);
          }
      }
    }
    else if(q.isEmpty())
    {
       finished = true;
    }
    else if(found)
    {
        child = find_parent(child);
        end.col = color(255, 0, 0);
        
    } 
    
  }
  
  fill(0);
  textSize(20);
  text("Choose the starting cell, then the end cell.\nPress SPACE to start again.\nPress ENTER to exit.", 10, 722);
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
   else
   {
     current.setCol(color(0, 192, 255));
     finished = true;
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
        if(walls.contains(new Pair(i, j)))
          grid[i][j].setWall(true);
     }
  }
}

void randomize_walls()
{
   walls = new HashSet<Pair<Integer, Integer>>();
   Pair<Integer, Integer> p;
   int number_of_walls = ((rows*cols) / 3);
   Random rnd = new Random();
   
   for(int n=0; n<number_of_walls; n++)
   {
       int i = rnd.nextInt(rows);
       int j = rnd.nextInt(cols);
       p = new Pair(i, j);
       if(walls.contains(p))
       {
         n--;
       }
       else
         walls.add(p);
         
   }
   
}

void mouseClicked()
{
  if(!clicked && start_identified)
  {
    clicked = true;    
  }
  
}
