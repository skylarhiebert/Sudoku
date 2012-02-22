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

@interface SudokuViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) BoardView *boardView;
@property (strong, nonatomic) ButtonsView *buttonView;
@property (strong, nonatomic) SudokuBoard *boardModel;
@property BOOL pencilEnabled;
@property (strong, nonatomic) NSArray *simpleGames;
@property (strong, nonatomic) NSArray *hardGames;

- (IBAction)pencilPressed:(UIButton *)sender;
- (IBAction)numberPressed:(UIButton *)sender;
- (IBAction)clearCellPressed:(UIButton *)sender;
- (IBAction)menuPressed:(UIButton *)sender;

@end
