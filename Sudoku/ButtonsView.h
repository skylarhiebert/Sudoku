//
//  ButtonsView.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonsView : UIView

@property (assign) NSInteger selectedRow;
@property (assign) NSInteger selectedCol;
@property BOOL pencilEnabled;


@end
