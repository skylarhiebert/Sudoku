//
//  SudokuBoard.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SudokuBoard : NSObject

@property (strong, nonatomic) NSMutableArray *board;
//@property (strong, nonatomic) NSMutableArray *userBoard;

- (id) init; // Create empty board
- (void) freshGame:(NSString *)boardString; // Load a new game encoded with given string
- (int) numberAtRow:(int)row Column:(int)col; // Fetch the number stored in the cell; Zero indicates empty
- (void) setNumber:(int)n AtRow:(int)row Column:(int)col; // Set the number at cell
- (void) clearNumberAtRow:(int)row Column:(int)col; // Clears the number at cell
- (BOOL) numberIsFixedAtRow:(int)row Column:(int)col; // Determines if fixed number at cell
- (BOOL) isConflictingEntryAtRow:(int)row Column:(int)col; // Does the number conflict with row, col, or 3x3 square?
- (BOOL) anyPencilsSetAtRow:(int)row Column:(int)col; // Are there any penciled values?
- (int) numberOfPencilsAtRow:(int)row Column:(int)col; // Number of penciled values at cell
- (BOOL) isSetPencil:(int)n AtRow:(int)row Column:(int)col; // Is the value n penciled in?
- (void) setPencil:(int)n AtRow:(int)row Column:(int)col; // Pencil the value n in.
- (void) clearPencil:(int)n AtRow:(int)row Column:(int)col; // Clear pencil value n
- (void) clearAllPencilsAtRow:(int)row Column:(int)col; // Clear all penciled in values


@end
