/*
 * Simple Curses version of mine sweeper. Written based on my obfucticated
 * version. David Malone <dwmalone@maths.tcd.ie>
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ncurses.h>

#define BOMBED 64	/* Bit to show location is bombed */
#define UNMARKED 32	/* Bit to show location is unmarked */
#define CLEARED 16	/* Bit to show location has been clicked on */
#define ABOMBM 15	/* Mask for extracting number of adjecent bombs */

#define ON_ADJECENT(i,j,t) do {\
	t(i-1,j-1); t(i,j-1); t(i+1,j-1); \
	t(i-1,j);             t(i+1,j); \
	t(i-1,j+1); t(i,j+1); t(i+1,j+1); \
	} while(0)

void setup_bombs(int,int);
void recursive_click(int,int);
void recursive_inc(int,int);
void drawboard();
char bd2ch(char);
char bd2ech(char);
void die(char *);

int width=10,heigth=10,bombs=15,visable=0,marked=0;
int winwidth, winheigth;
char *board,c[64];

int main(int argc,char **argv) {
	int i,j;
	int command;
	time_t start;
	char *message = "";

	/*
	 * Get game parameters from the command line.
	 */
	if( argc > 1 ) { width = atoi(argv[1]); argc--; argv++; }
	if( argc > 1 ) { heigth = atoi(argv[1]); argc--; argv++; }
	if( argc > 1 ) { bombs = atoi(argv[1]); argc--; argv++; }

	if( width <= 0 || heigth <= 0 || bombs <= 0 || bombs >= width*heigth )
		die("Bad Game!\n");

	/*
	 * Initialise the board - we place the bombs later to avoid
	 * the situation where the first location they click is bombed.
	 */
	if( (board = calloc(width*heigth,sizeof(char))) == NULL )
		die("Not enough memory available!\n");

	for(i = 0; i < heigth; i++)
		for(j = 0; j < width; j++)
			board[i*width+j] = UNMARKED;

	/*
	 * Get curses going.
	 */
	if( initscr() == NULL || cbreak() == ERR || noecho() == ERR )
		die("Curses startup problem.\n");
	nonl();
	intrflush(stdscr, FALSE);
	keypad(stdscr, TRUE);
	getmaxyx(stdscr, winheigth, winwidth);
	if( heigth+3 > winheigth || width+2 > winwidth )
		die("Screen too small.\n");
	
	srand(start = time(NULL));
	drawboard();

	i = j = 0;
	while(1) {
		move(winheigth-1, 0);
		printw("bombs remaining: %d time: %d %s", bombs - marked,
			(int)difftime(time(NULL),start) ,message);
		move(i+1,j+1);
		refresh();

		if( (command = getch()) == ERR )
			die("Problem reading next command!\n");

		switch( command ) {
		case 'q':
			die("Splitter!\n");
			break;
		case KEY_DOWN:
		case 'j':
			if( i < heigth-1 ) i++;
			break;
		case KEY_UP:
		case 'k':
			if( i > 0 ) i--;
			break;
		case KEY_LEFT:
		case 'h':
			if( j > 0 ) j--;
			break;
		case KEY_RIGHT:
		case 'l':
			if( j < width-1 ) j++;
			break;
		case 'm':
			if( board[i*width+j]&CLEARED ) {
				message = "Can't mark clear!";
				break;
			}
			if( board[i*width+j] & UNMARKED )
				marked++;
			else
				marked--;
			board[i*width+j] ^= UNMARKED;
			move(i+1,j+1); addch(bd2ch(board[i*width+j]));
			break;
		case ' ':
			if( visable == 0 )
				setup_bombs(i,j);
			if( board[i*width+j]&BOMBED ) {
				board[i*width+j] |= CLEARED;
				for(i = 0; i < heigth; i++)
					for(j = 0; j < width; j++) {
						move(i+1,j+1); addch(bd2ech(board[i*width+j]));
					}
				refresh();
				die("Boom!\n");
			}
			recursive_click(i,j);
			break;
		case 'L' - '@':
			clear();
			drawboard();
			break;
		default:
			message = "Unknown Command.\n";
		}

		if( visable+bombs>=width*heigth )
			die("Well done.\n");
	}
}

/*
 * Place bombs uniformly in locations except (r,s)
 */

void setup_bombs(int r,int s) {
	int i,j,k,l,m,n;

	for( k = 0; k < bombs; k++ ) {
		n = 0; /* count of suitable locations examined for this bomb */
		for( i = 0; i < heigth; i++ ) {
			for( j = 0; j < width; j++ ) {
				if( !(board[i*width+j]&BOMBED) &&
				    i != r && j != s ) {
					n++; /* location is suitable */
					if( rand()%n == 0 ) {
						l=i; /* accept with prob=1/n */
						m=j;
					}
				}
			}
		} 
		board[l*width+m] |= BOMBED;
		ON_ADJECENT(l,m,recursive_inc);
	}
}

/*
 * Increment bomb count on this location.
 */

void recursive_inc(int i,int j) {
	if( i>=0 && i<heigth && j>=0 && j<width )
		board[i*width+j]++;
}

/*
 * Click on location i,j and if it is a location with 0 bombed neighbours
 * then recurse on the neighbours.
 */

void recursive_click(int i,int j) {
	if( i>=0 && i<heigth && j>=0 && j<width && !(board[i*width+j]&CLEARED) ) {
		board[i*width+j] |= CLEARED|UNMARKED;
		move(i+1,j+1); addch(bd2ch(board[i*width+j]));
		visable++;
		if( (board[i*width+j]&ABOMBM) == 0 )
			ON_ADJECENT(i,j,recursive_click);
	}
}

/*
 * Draw the whole board in curses mode.
 */
void drawboard() {
	int i,j;

	/* Top border */
	move(0,0);
	addch('+');
	for( j = 0; j < width; j++ ) addch('-');
	addch('+');
	/* Main board */
	for(i = 0; i < heigth; i++) {
		move(i+1,0);
		addch('|');
		for(j = 0; j < width; j++)
			addch(bd2ch(board[i*width+j]));
		addch('|');
	} 
	/* Bottom border */
	move(heigth+1,0);
	addch('+');
	for( j = 0; j < width; j++ ) addch('-');
	addch('+');
	refresh();
}
 
/*
 * Convert a board code to a character.
 */
char bd2ch(char b) {
	if( b == (CLEARED|UNMARKED) )
		return ' ';
	else if( !(b&UNMARKED) )
		return '*';
	else if( !(b&CLEARED) )
		return '.';
	else
		return '0' + (b&ABOMBM);
}

/*
 * Convert a board code to a character for the game over board.
 */
char bd2ech(char b) {
	if( (b&BOMBED) && (b&CLEARED) )
		return '#';
	else if( b&BOMBED )
		return '*';
	else if( !(b&UNMARKED) )
		return 'X';
	else if( (b&ABOMBM) == 0 )
		return ' ';
	else
		return '0' + (b&ABOMBM);
}

/*
 * Clean up curses and exit.
 */
void die(char *s) {
	endwin();
	fprintf(stderr, "\n%s", s);
	exit(0);
}
