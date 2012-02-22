//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "SudokuBoard.h"
#import "BoardTile.h"

@implementation SudokuBoard

@synthesize board = _board;

- (id) init { // Create empty board
    self = [super init];
    if (self) {
        self.board = [[NSMutableArray alloc] init];
        // initialize _board array with all 0s and all tiles editable
        for (int i = 0; i < 81; i++) {
            BoardTile *tile = [[BoardTile alloc] init];
            tile.number = i % 9 + 1;
            if (tile.number == 5) {
                tile.editable = NO;
            }
            NSLog(@"Initializing tile %i; editable?:%d", tile.number, tile.editable);
            [_board insertObject:tile atIndex:i];
        }
    }
    
    return self;
}

- (void) freshGame:(NSString *)boardString { // Load a new game encoded with given string
    for (int i = 0; i < boardString.length; i++) {
        NSLog(@"%i", [boardString characterAtIndex:i]);
        
        BoardTile *tile = [_board objectAtIndex:i];
        int num = [boardString characterAtIndex:i];
        
        if ('0' <= num && num <= '9') {
            tile.editable = NO;
            [tile clearAllPencilMarks];
            [tile setNumber:num - '0'];
        } else {
            tile.editable = YES;
            [tile clearAllPencilMarks];
            [tile setNumber:0];
        }
    }
}

- (int) numberAtRow:(int)row Column:(int)col { // Fetch the number stored in the cell { Zero indicates empty
    //NSLog(@"numberAtRow:%i Column:%i", row, col);
   return [[_board objectAtIndex:row * 9 + col] number];
}

- (void) setNumber:(int)n AtRow:(int)row Column:(int)col { // Set the number at cell 
    BoardTile *tile = [_board objectAtIndex:row * 9 + col];

    NSLog(@"setNumber:%i AtRow:%i Column:%i editable?:%d", n, row, col, tile.editable);
    
    if (tile.editable) {
        tile.number = n;
    }
}

- (void) clearNumberAtRow:(int)row Column:(int)col { // Clear the number at cell
    BoardTile *tile = [_board objectAtIndex:row * 9 + col];

    [tile setNumber:0];
    [tile clearAllPencilMarks];
}

- (BOOL) numberIsFixedAtRow:(int)row Column:(int)col { // Determines if fixed number at cell
    //NSLog(@"numberIsFixedAtRow:(%d) Column:(%d)[%d]:%d", row, col, [[_board objectAtIndex:row*9+col] number], ![[_board objectAtIndex:row * 9 + col] editable]);
    return ![[_board objectAtIndex:row * 9 + col] editable];
}

- (BOOL) isConflictingEntryAtRow:(int)row Column:(int)col { // Does the number conflict with row, col, or 3x3 square?
    NSInteger num = [[_board objectAtIndex:row*9 + col] number];
    // Check Row Conflict
    for (int i = 0; i < 9; i++) {
        if ([[_board objectAtIndex:row*9 + i] number] == num && i != col) {
            return YES;
        }        
    }
    
    // Check Column Conflict
    for (int j = 0; j < 9; j++) {
        if ([[_board objectAtIndex:j*9 + col] number] == num && j != row) {
            return YES;
        }
    }
    
    // Check 3x3 conflict
    
    return NO;
}

- (BOOL) anyPencilsSetAtRow:(int)row Column:(int)col { // Are there any penciled values?
    return [[_board objectAtIndex:row * 9 + col] pencils];
}

- (int) numberOfPencilsAtRow:(int)row Column:(int)col { // Number of penciled values at cell
    return [[_board objectAtIndex:row * 9 + col] pencilsCount];
}

- (BOOL) isSetPencil:(int)n AtRow:(int)row Column:(int)col { // Is the value n penciled in?
    return [[_board objectAtIndex:row * 9 + col] pencilSet:n];
}

- (void) setPencil:(int)n AtRow:(int)row Column:(int)col { // Pencil the value n in.
    NSLog(@"setPencil:%d AtRow:%d Column:%d", n, row, col);
    [[_board objectAtIndex:row * 9 + col] setPencil:n];
}

- (void) clearPencil:(int)n AtRow:(int)row Column:(int)col { // Clear pencil value n
    [[_board objectAtIndex:row * 9 + col] clearPencil:n]; 
}

- (void) clearAllPencilsAtRow:(int)row Column:(int)col { // Clear all penciled in values
    [[_board objectAtIndex:row * 9 + col] clearAllPencilMarks];
}

@end
