//
//  SudokuBoard.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "SudokuBoard.h"

@implementation SudokuBoard

@synthesize board = _board;
@synthesize userBoard = _userBoard;

- (id) init { // Create empty board
    
}

- (void) freshGame:(NSString *)boardString { // Load a new game encoded with given string
    for (int i = 0; i < boardString.length; i++) {
        NSLog(@"%i", [boardString characterAtIndex:i]);
    }
}

- (int) numberAtRow:(int)row Column:(int)col { // Fetch the number stored in the cell { Zero indicates empty

}

- (void) setNumber:(int)n AtRow:(int)row Column:(int)col { // Set the number at cell

}

- (BOOL) numberIsFixedAtRow:(int)row Column:(int)col { // Determines if fixed number at cell
    if ([_board objectAtIndex:(row * 9 + col)] == @"0") {
        return NO;
    }
    return YES;
}

- (BOOL) isConflictingEntryAtRow:(int)row Column:(int)col { // Does the number conflict with row, col, or 3x3 square?
    // Check Row Conflict
    int test = 
    for (int i = 0; i < 9; i++) {
        if ([) {
            <#statements#>
        }
    }
    
    // Check Column Conflict
    for (int j = 0; j < 9; j++) {
        <#statements#>
    }
    
    // Check 3x4 conflict
}

- (BOOL) anyPencilsSetAtRow:(int)row Column:(int)col { // Are there any pencilved values?

}

- (int) numberOfPencilsAtRow:(int)row Column:(int)col { // Number of penciled values at cell

}

- (BOOL) isSetPencil:(int)n AtRow:(int)row Column:(int)col { // Is the value n penciled in?

}

- (void) setPencil:(int)n AtRow:(int)row Column:(int)col { // Pencil the value n in.

}

- (void) clearPencil:(int)n AtRow:(int)row Column:(int)col { // Clear pencil value n

}

- (void) clearAllPencilsAtRow:(int)row Column:(int)col { // Clear all penciled in values

}

@end
