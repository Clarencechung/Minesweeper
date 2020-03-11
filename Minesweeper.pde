import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
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
    for(int i= 0; i < 30; i++)
    {
        int mineR = (int)(Math.random()*NUM_ROWS);
        int mineC = (int)(Math.random()*NUM_COLS);
        if(!mines.contains(buttons[mineR][mineC]))
        {
            mines.add(buttons[mineR][mineC]);
        }
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
     for (int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].isClicked() == false){
                return false;
            }
        }
    }
    return true;
}

public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(!buttons[r][c].isClicked() == true && mines.contains(buttons[r][c]))
                buttons[r][c].clicked = true;
    String lose = new String("YOU LOSE");
    for(int i = 0; i < lose.length();i++)
        buttons[8][i+6].setLabel(lose.substring(i,i+1));
}
public void displayWinningMessage()
{
    String win = new String("YOU WIN");
    for(int i = 0; i < win.length();i++)
    {
        buttons[9][i+9].setLabel(win.substring(i,i+1));
    }
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
    int numMines = 0;
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
            if (flagged == false)
            {
                flagged = true;
                clicked = true;
            }
        }
        else if(mines.contains(this))
       {
            displayLosingMessage();
       }
        else if(countMines(myRow,myCol) > 0)
        {
            setLabel("" + countMines(myRow,myCol));
        }  
        else
        {
            if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].isClicked())
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].isClicked())
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].isClicked())
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].isClicked())
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].isClicked())
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].isClicked())
                buttons[myRow-1][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].isClicked())
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].isClicked())
                buttons[myRow-1][myCol+1].mousePressed();
        }
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
        public boolean isClicked()
    {
        return clicked;
    }
}
