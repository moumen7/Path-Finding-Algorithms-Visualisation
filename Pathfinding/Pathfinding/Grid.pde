class Grid
{
   Cell root, end;
   Cell grid[][];
   boolean found;
   boolean target_identified;
   boolean start_identified;
   int cols = 20;
   int rows = 20;
   int w, h;
   int start_i=0, start_j=0;
   int target_i = rows-1, target_j=cols-1;
  Set<Pair<Integer, Integer>> walls;
  Grid()
  {
     target_identified = false;
     start_identified = false;
     found = false;
     w = width / rows - 10;
     h = height / cols ;
     grid = new Cell[rows][cols];
      end = grid[target_i][target_j];
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
void init()
{
  for(int i=0; i<rows; i++)
  {
     for(int j=0; j<cols; j++)
     {
        grid[i][j] = new Cell(i, j, w, h);
        if(walls.contains(new Pair(i, j)))
          grid[i][j].setWall(true);
     }
  }
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


}
