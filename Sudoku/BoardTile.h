//
//  BoardTile.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/22/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardTile : NSObject

@property NSInteger number;
@property BOOL editable;
@property BOOL pencils;
@property (strong, nonatomic) NSMutableArray *pencil_marks;

- (void) clearAllPencilMarks;
- (void) clearPencil:(int)n;
- (void) setPencil:(int)n;
- (BOOL) isSetPencil:(int)n;
- (int) pencilsCount;

@end
