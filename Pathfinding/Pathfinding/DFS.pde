import java.util.Stack;
class DFS extends Search
{
  Stack<Cell> s;
  Vector<Cell> neighbours;
  DFS()
  {
     s = new Stack<Cell>(); 
     neighbours = new Vector<Cell>();
    
  }
  public Cell last()
  {
    return s.pop();
  }
  public Cell getlast()
  {
    return s.peek();
  }
  public void newitem(Cell newit)
  {
    s.push(newit);
  }
  public boolean empty()
  {
    return s.size() == 0;
  }
   public boolean explore_Neighbours(Cell[][] grid,  Cell end,Cell current)
   {
     int di[] = { -1, 1, 0, 0, -1, -1, 1, 1};
     int dj[] = { 0, 0, 1, -1, 1, -1, -1, 1};
      
      for(int k=0; k<di.length; k++)
      {
          int new_i = current.i + di[k];
          int new_j =current.j + dj[k];
          
          if(new_i < 0 || new_j < 0)
              continue;
          if(new_i >= 20 || new_j >= 20)
              continue;
          
          Cell neighbour = grid[new_i][new_j];
          if(neighbour.visited == true)
              continue;
          if(neighbour.wall == true)
              continue;
          
          s.push(neighbour);
          neighbours.add(neighbour);
          neighbour.setVisited(true);
          neighbour.setParent(current);
          if(neighbour == end)
              return true;
      }
      return false;
   }
}
