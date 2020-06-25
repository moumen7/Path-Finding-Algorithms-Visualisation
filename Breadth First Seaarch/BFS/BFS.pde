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
   randomize_walls();
   init();
   end = grid[target_i][target_j];
   child = null;
   q = new LinkedList<Cell>(); 
   
}
int screenState = 0;
final int menuScreen = 0;
final int bfsScreen = 1;

void draw()
{
    if(screenState == menuScreen)
    {
       drawMenu();
    }
    else if(screenState == bfsScreen)
    {
       drawBFS(); 
    }
  
  
  
}
void drawMenu()
{
   float x = 100;
   float y = 50;
   float w = 150;
   float h = 80;
   
   background(255);
   rect(x,y,w,h);
   fill(255);
   if(mousePressed)
   {
    if(mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h)
    {
     println("The mouse is pressed and over the button");
     fill(0);
     screenState = bfsScreen;
    } 
  }
  
}


void drawBFS()
{
  
  if(!clicked && mousePressed && !start_identified)
  {
     start_i = mouseY / w;
     start_j = mouseX / h;
      
     start_identified = true;
     root = grid[start_i][start_j];
     
     if(root.wall)
     {
        start_identified = false;
        clicked = false;
     }  
     else
     {
       root.parent = null;
       root.setVisited(true);
       root.col = color(0, 255, 0);
       q.add(root);
     }
     println(start_i);
     println(start_j);  
  }
  else if(clicked && mousePressed && !target_identified)
  {
    target_i = mouseY / w;
    target_j = mouseX / h;
    target_identified = true;
    end = grid[target_i][target_j];
    
    if(end.wall) 
      target_identified = false;
    else
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
    
    if(found)
    {
        child = find_parent(child);
         end.col = color(255, 0, 0);
        
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
   else
     current.setCol(color(0, 192, 255));
   
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
