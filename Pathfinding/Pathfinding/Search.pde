abstract class Search
{
  
  abstract public Cell last();
  abstract public Cell getlast();
  abstract public boolean empty();
  abstract public boolean explore_Neighbours(Cell[][] grid,  Cell end,Cell current);
  abstract public void newitem(Cell newit);
}
