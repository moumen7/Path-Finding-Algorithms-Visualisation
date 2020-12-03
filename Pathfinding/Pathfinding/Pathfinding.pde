import java.util.LinkedList; 
import java.util.Queue;
import java.util.Set;
import java.util.HashSet;
import java.util.Random;
import processing.serial.*;
import javafx.util.Pair;
import javax.swing.*;
import controlP5.*;
ControlP5 controlP5;
RadioButton r;
Grid maingrid;
Cell child;
Search bfs;
boolean clicked;
boolean finished;
String last = "";
private JComboBox box;
Serial port;                     //Define the variable port as a Serial object.
int Ss;                          //The dropdown list will return a float value, which we will connvert into an int. we will use this int for that).
String[] comList ;               //A string to hold the ports in.
boolean serialSet;               //A value to test if we have setup the Serial port.
boolean Comselected = false;     //A value to test if you have chosen a port in the list.
void setup()
{
   size(800, 805);
   background(000);
   clicked = false;
   finished = false;
   maingrid = new Grid();
   maingrid.randomize_walls();
   maingrid.init();
   child = null;
  
   controlP5 = new ControlP5(this);
  r = controlP5.addRadioButton("radio",0,630);
  r.setColorLabels(255);
  r.setBackgroundColor(000);
  r.setSize(20, 20) ;
  r.addItem("BFS", 1);
  r.addItem("DFS", 2);
   if(last.equals("BFS"))
   {
   bfs = new BFS();
    r.activate(0);
   }
   else
   {
     bfs = new DFS();
     r.activate(1);
   }
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
  if(!clicked && mousePressed && !maingrid.start_identified)
  {
     maingrid.start_i = mouseY / maingrid.w;
     maingrid.start_j = mouseX / maingrid.h;
     
     if(maingrid.start_i < maingrid.rows &&  maingrid.start_j < maingrid.cols)
     {
       maingrid.start_identified = true;
       maingrid.root = maingrid.grid[maingrid.start_i][maingrid.start_j];
       
       if(maingrid.start_identified && maingrid.root.wall)
       {
          maingrid.start_identified = false;
          clicked = false;
       }  
       else if(maingrid.start_identified)
       {
         maingrid.root.parent = null;
         maingrid.root.setVisited(true);
         maingrid.root.col = color(0, 255, 0);
         bfs.newitem(maingrid.root);
       }
     }
     println(maingrid.start_i);
     println(maingrid.start_j);  
  }
  else if(clicked && mousePressed && !maingrid.target_identified)
  {
    maingrid.target_i = mouseY / maingrid.w;
    maingrid.target_j = mouseX / maingrid.h;
    
    if(maingrid.target_i < maingrid.rows &&  maingrid.target_j < maingrid.cols)
    {
      maingrid.target_identified = true;
      maingrid.end = maingrid.grid[maingrid.target_i][maingrid.target_j];
      
      if(maingrid.target_identified && maingrid.end.wall) 
        maingrid.target_identified = false;
      else if(maingrid.target_identified)
        maingrid.end.col = color(255, 0, 0);
    }
     println(maingrid.target_i);
     println(maingrid.target_j);  
    
  }
  if(maingrid.start_identified && maingrid.target_identified)
  {
      if(!bfs.empty() && !maingrid.found)
      {
      Cell current = bfs.last();
      if(current == maingrid.end)
      {
          maingrid.found = true;
          child = maingrid.end;
          println("Found\n" + maingrid.end.i + "\t" + maingrid.end.j);
      }
      else
      {
          if(bfs.explore_Neighbours(maingrid.grid, maingrid.end,current))
          {
              maingrid.found = true;
              child = maingrid.end;
              println("Found\n" + maingrid.end.i + "\t" + maingrid.end.j);
          }
      }
    }
    else if(bfs.empty())
    {
       finished = true;
    }
    else if(maingrid.found)
    {
        child = find_parent(child);
        maingrid.end.col = color(255, 0, 0);
    } 
    
  }
  fill(255);
  textSize(20);
   stroke(0);
  rect(0,600,805,27); 
  text("Choose the starting cell, then the end cell.\nPress SPACE to start again.\nPress ENTER to exit.", 10, 722);
  maingrid.show();
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
void controlEvent(ControlEvent theEvent) 
{
  if(theEvent.isGroup() && theEvent.name().equals("radio")) 
  {
    if(theEvent.arrayValue()[0] == 1.0)
    {
      bfs = new BFS();
   maingrid = new Grid();
   maingrid.randomize_walls();
   maingrid.init();
     clicked = false;
   finished = false;
       last = "BFS";
    }
    else
    {
   bfs = new DFS();
   maingrid = new Grid();
   maingrid.randomize_walls();
   maingrid.init();
   clicked = false;
   finished = false;
   last = "DFS";
    }
  }
}

void mouseClicked()
{
  if(!clicked && maingrid.start_identified)
  {
    clicked = true;    
  }
  
}
