//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/9/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SudokuViewController.h"
#import "BoardView.h"
#import "ButtonsView.h"
#import "SudokuBoard.h"

@interface SudokuViewController() 

- (NSString *)randomSimpleGame; 
- (NSString *)randomHardGame; 
   
@end

@implementation SudokuViewController

@synthesize boardView = _boardView;
@synthesize buttonView = _buttonView;
@synthesize boardModel = _boardModel;
@synthesize pencilEnabled = _pencilEnabled;
@synthesize simpleGames = _simpleGames;
@synthesize hardGames = _hardGames;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize games arrays
    NSString *path = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"plist"];
    _simpleGames = [[NSArray alloc] initWithContentsOfFile:path];
    path = [[NSBundle mainBundle] pathForResource:@"hard" ofType:@"plist"];
    _hardGames = [[NSArray alloc] initWithContentsOfFile:path];
    
    // Initialize Board Model
    _pencilEnabled = NO;
    _boardModel = [[SudokuBoard alloc] init];
        [_boardModel freshGame:[self randomSimpleGame]];

    // Create BoardView
    _boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    _boardView.boardModel = _boardModel;
    [_boardView setBackgroundColor:[UIColor whiteColor]];
    [_boardView selectFirstAvailableCell];
    [self.view addSubview:_boardView];
    
    // Create ButtonView
    _buttonView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 320, 320, 140)];
    
    // Add buttons to buttonView
    for (int i = 0; i < 12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button.layer setBorderWidth:3.0];
        [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
        if (i < 9) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
            NSString *title = [NSString stringWithFormat:@"%d", i+1];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 9) { // Pencil
            [button setImage:[UIImage imageNamed:@"pencil.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(pencilPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 10) { // Clear Cell
            [button setImage:[UIImage imageNamed:@"text_cancel.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clearCellPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else { // Menu
            [button setImage:[UIImage imageNamed:@"menu-i.gif.png"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(menuPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        button.tag = i+1;
        [_buttonView addSubview:button];
    }

    [self.view addSubview:_buttonView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        _boardView.frame = CGRectMake(0, 0, 320, 320);
        _buttonView.frame = CGRectMake(0, 320, 320, 140);
    } else {
        _boardView.frame = CGRectMake(0, 0, 300, 300);
        _buttonView.frame = CGRectMake(300, 0, 180, 300);
    }
}

- (IBAction)pencilPressed:(UIButton *)sender {
    NSLog(@"pencilPressed:");
    _pencilEnabled = sender.selected = !_pencilEnabled;
    if (_pencilEnabled) {
        [sender setBackgroundColor:[UIColor grayColor]];
    } else {
        [sender setBackgroundColor:[UIColor whiteColor]];
    }
    sender.highlighted = NO;
    [_buttonView setNeedsDisplay];
}

- (IBAction)numberPressed:(UIButton *)sender {
    NSLog(@"numberPressed:%i", sender.tag);
    if (_pencilEnabled) {
        [_boardModel setPencil:sender.tag AtRow:[_boardView selectedRow] Column:[_boardView selectedCol]];
    } else {
        [_boardModel setNumber:sender.tag AtRow:[_boardView selectedRow] Column:[_boardView selectedCol]];
        
    }
    [_boardView setNeedsDisplay];
}

- (IBAction)clearCellPressed:(UIButton *)sender {
    NSLog(@"clearCellPressed:");
    const int row = [_boardView selectedRow];
    const int col = [_boardView selectedCol];
    if ([_boardModel numberOfPencilsAtRow:row Column:col] > 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting all penciled in numbers" 
                                                        message:@"Are you sure?" 
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"Yes", nil];
        [alert setTag:1];
        [alert show];
    } else {
        [_boardModel clearNumberAtRow:row Column:col];
    }
    [_boardView setNeedsDisplay];
}

- (IBAction)menuPressed:(UIButton *)sender {
    NSLog(@"menuPressed:");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Main Menu" 
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"New Easy Game", @"New Hard Game", @"Clear Conflicting Cells", @"Clear All Cells", nil];
    [sheet showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [actionSheet cancelButtonIndex]) {
        NSLog(@"Cancel Button");
    } else {
        if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"New Easy Game") {
            NSLog(@"New Easy Game Button");
            [_boardModel freshGame:[self randomSimpleGame]];
            [_boardView selectFirstAvailableCell];
            [_boardView setNeedsDisplay];
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"New Hard Game") {
            NSLog(@"New Hard Game Button");
            [_boardModel freshGame:[self randomHardGame]];
            [_boardView selectFirstAvailableCell];
            [_boardView setNeedsDisplay];
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Clear Conflicting Cells") {
            NSLog(@"Clear Conflicting Cells");
            [_boardModel clearAllConflictingCells];
            [_boardView setNeedsDisplay];
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Clear All Cells") {
            NSLog(@"Clear All Cells");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" 
                                                            message:@"Are you sure you want to clear all of the cells?" 
                                                           delegate:self 
                                                  cancelButtonTitle:@"No" 
                                                  otherButtonTitles:@"Yes", nil];
            [alert setTag:0];
            [alert show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet tag] == 0) {
        NSLog(@"actionSheet tag == 0");
        if (buttonIndex != [actionSheet cancelButtonIndex]) { // Yes
            [_boardModel clearAllEditableCells];
            [_boardView setNeedsDisplay];
        } 
    } else {
        NSLog(@"actionSheet tag != 0 buttonIndex != cancelButtonIndex:%d", buttonIndex != [actionSheet cancelButtonIndex]);
        if (buttonIndex != [actionSheet cancelButtonIndex]) { // Yes
            [_boardModel clearAllPencilsAtRow:[_boardView selectedRow] Column:[_boardView selectedCol]];
            [_boardView setNeedsDisplay];
        } 
    }

}

- (NSString *)randomSimpleGame {
    const int n = [_simpleGames count];
    const int i = arc4random() % n;
    return [_simpleGames objectAtIndex:i];
}

- (NSString *)randomHardGame {
    const int n = [_hardGames count];
    const int i = arc4random() % n;
    return [_hardGames objectAtIndex:i];
}

@end
