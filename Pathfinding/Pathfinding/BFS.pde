public class BFS extends Search
{
    Queue<Cell> q;
    Vector<Cell> neighbours;
  BFS()
  {
     q = new LinkedList<Cell>(); 
     neighbours = new Vector<Cell>();
      this.neighbours = new Vector<Cell>();
  }
  public Cell last()
  {
    return q.remove();
  }
  public Cell getlast()
  {
    return q.peek();
  }
  public boolean empty()
  {
    return q.size() == 0;
  }
    public void newitem(Cell newit)
  {
    q.add(newit);
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
          
          q.add(neighbour);
          neighbours.add(neighbour);
          neighbour.setVisited(true);
          neighbour.setParent(current);
          if(neighbour == end)
              return true;
      }
      return false;
   }
}
