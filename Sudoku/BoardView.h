//
//  BoardView.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView


//@property <CLASS> boardModel;
@property (assign) NSInteger selectedRow;
@property (assign) NSInteger selectedCol;

@end
