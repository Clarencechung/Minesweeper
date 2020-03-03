import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 30;
public final static int NUM_COLS = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );

    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS;r++)
        for (int c = 0; c < NUM_COLS; c++)
            buttons[r][c] = new MSButton(r,c);
    
    
    
    setMines();
}
public void setMines()
{
    while(mines.size() < 20)
    {
        int r = (int)(Math.random() * NUM_ROWS);
        int c = (int)(Math.random() * NUM_COLS);
            if (!mines.contains(mines)) 
        mines.add(buttons[r][c]);
        System.out.println(r + ", " + c);       
    }
}

public void draw()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    // no more open buttons

    return false;
}
public void displayLosingMessage()
{
    textSize(24);
    stroke(255);
    text("You Lose", 240,240);
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
      return true;
    else
      return false;
    }

    
public int countMines(int row, int col)
{
    int numMines = 20;
        if(isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
            numMines++;
        if(isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
            numMines++;
        if(isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
            numMines++;
        if(isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
            numMines++;
        if(isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
            numMines++;
        if(isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
            numMines++;
        if(isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
            numMines++;
        if(isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
            numMines++;
        return numMines;
    }

public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if (mousePressed && (mouseButton == RIGHT))
        {
            flagged = !clicked;
            clicked = false;
        }
        else if(mines.contains(mines))
        {
            displayLosingMessage();

        }
        if(isValid(NUM_ROWS,NUM_COLS+1) == true && buttons[NUM_ROWS][NUM_COLS+1].isMarked())
            buttons[NUM_ROWS][NUM_COLS+1].mousePressed();
        if(isValid(row+1,col+1) == true && buttons[row+1][col+1].isMarked())
            buttons[row+1][col+1].mousePressed();
        if(isValid(row-1,col+1) == true && buttons[row-1][col+1].isMarked())
            buttons[row-1][col+1].mousePressed();
        if(isValid(row+1,col) == true && buttons[row+1][col].isMarked())
            buttons[row+1][col].mousePressed();
        if(isValid(row-1,col) == true && buttons[row-1][col].isMarked())
            buttons[row-1][col].mousePressed();
        if(isValid(row+1,col-1) == true && buttons[row+1][col-1].isMarked())
            buttons[row+1][col-1].mousePressed();
        if(isValid(row,col-1) == true && buttons[row][col-1].isMarked())
            buttons[row][col-1].mousePressed();
        if(isValid(row-1,col-1) == true && buttons[row-1][col-1].isMarked())
            buttons[row-1][col-1].mousePressed();
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}


// import de.bezier.guido.*;
// private Blob[][] blobs; 
// public final static int NUM_ROWS = 20;
// public final static int NUM_COLS = 20;

// void setup ()
// {
//     size(400, 400);
//     // make the manager
//     Interactive.make( this );
//     blobs = new Blob[NUM_ROWS][NUM_COLS];
//     for(int r = 0; r < NUM_ROWS; r++)
//       for(int c = 0; c < NUM_COLS; c++)
//          blobs[r][c] = new Blob(r,c);
// }
// void draw(){}//empty

// public class Blob
// {
//     private int r, c;
//     private float x,y, width, height;
//     private boolean marked;
    
//     public Blob ( int rr, int cc )
//     {
//         width = 400/NUM_COLS;
//         height = 400/NUM_ROWS;
//         r = rr;
//         c = cc; 
//         x = c*width;
//         y = r*height;
//         marked = Math.random() < .5;
//         Interactive.add( this ); // register it with the manager
//     }
//     public boolean isMarked()
//     {
//         return marked;
//     }
//     public boolean isValid(int row, int col)
//     //post condition: returns true if both row and col are valid, false otherwise
//     {
//       if (row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS)
//       return true;
//       else
//       return false;
//     }
    
//     public void mousePressed () 
//     {
//         if(marked == true)
//         {
//           marked = false;
//           if(isValid(r,c-1) && blobs[r][c-1].isMarked())
//             blobs[r][c-1].mousePressed();
//           if(isValid(r,c+1)==true && blobs[r][c+1].isMarked())
//             blobs[r][c+1].mousePressed();
//           if(isValid(r+1,c)==true && blobs[r+1][c].isMarked())
//             blobs[r+1][c].mousePressed();
//           if(isValid(r-1,c)==true && blobs[r-1][c].isMarked())
//             blobs[r-1][c].mousePressed();
//         }
//     }
//     public void draw () 
//     {    
//         if (marked)
//             fill(50);
//         else 
//             fill( 255 );

//         rect(x, y, width, height);
//         fill(0);
//     }
// }
