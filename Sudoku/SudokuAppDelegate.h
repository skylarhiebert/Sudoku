//
//  SudokuAppDelegate.h
//  Sudoku
//
//  Created by Skylar Hiebert on 2/9/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SudokuViewController;

@interface SudokuAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SudokuViewController *viewController;

@end
