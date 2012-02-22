//
//  BoardTile.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/22/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "BoardTile.h"

@implementation BoardTile

@synthesize number;
@synthesize editable;
@synthesize pencils;
@synthesize pencil_marks;

- (id) init { // Create empty board
    self = [super init];
    if (self) {
        number = 0;
        editable = YES;
        pencils = NO;
        // initialize pencils array with all 0s
        for (int j = 0; j < 9; j++) {
            [pencil_marks insertObject:[NSNumber numberWithInt:0] atIndex:j];
        }
    }
    
    return self;
}

- (void) clearAllPencilMarks {
    for (int i = 0; i < 9; i++) {
        [pencil_marks replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
    }
    pencils = NO;
}

- (void) clearPencil:(int)n {
    [pencil_marks replaceObjectAtIndex:n-1 withObject:[NSNumber numberWithInt:0]];

    if ([self pencilsCount] == 0) {
        pencils = NO;
    }
}

- (void) setPencil:(int)n {
    pencils = YES;
    [pencil_marks replaceObjectAtIndex:n-1 withObject:[NSNumber numberWithInt:n]];
}

- (BOOL) pencilSet:(int)n {
    return [[pencil_marks objectAtIndex:n-1] intValue] == 0;
}

- (int) pencilsCount {
    int count = 0;
    if (pencils) { 
        for (NSNumber *n in pencil_marks) {
            if ([n intValue] != 0) {
                count++;
            }
        }
    }
    return count;
}

@end
