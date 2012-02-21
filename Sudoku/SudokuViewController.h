//
//  SudokuViewController.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/9/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoardView;
@class ButtonsView;
@class SudokuBoard;

@interface SudokuViewController : UIViewController

@property (strong, nonatomic) BoardView *boardView;
@property (strong, nonatomic) ButtonsView *buttonView;
@property (strong, nonatomic) SudokuBoard *boardModel;

@end
