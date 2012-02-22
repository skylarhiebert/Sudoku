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
    _pencilEnabled = NO;
    _boardModel = [[SudokuBoard alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    _boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    _boardView.boardModel = _boardModel;
    [_boardView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_boardView];
    _buttonView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 320, 320, 140)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"plist"];
    _simpleGames = [[NSArray alloc] initWithContentsOfFile:path];
    path = [[NSBundle mainBundle] pathForResource:@"hard" ofType:@"plist"];
    _hardGames = [[NSArray alloc] initWithContentsOfFile:path];
    
    [_boardModel freshGame:[self randomSimpleGame]];
    [_boardView selectFirstAvailableCell];
    
    // Add buttons to buttonView
    for (int i = 0; i < 9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        NSString *title = [NSString stringWithFormat:@"%d", i+1];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button.layer setBorderWidth:3.0];
        [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [button addTarget:self action:@selector(numberPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        //[button setBackgroundColor:[UIColor whiteColor]];

        //[button s
        [_buttonView addSubview:button];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    button.tag = 10;
    [button.layer setBorderWidth:3.0];
    [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [button setImage:[UIImage imageNamed:@"pencil.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pencilPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (_pencilEnabled) {
        [button setBackgroundColor:[UIColor grayColor]];
    } else {
        [button setBackgroundColor:[UIColor whiteColor]];
    }
    
    
    [_buttonView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    button.tag = 11;
    [button.layer setBorderWidth:3.0];
    [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [button setImage:[UIImage imageNamed:@"text_cancel.png"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(clearCellPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    button.tag = 12;
    [button.layer setBorderWidth:3.0];
    [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [button setImage:[UIImage imageNamed:@"menu-i.gif.png"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(menuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:button];

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
    [_boardModel clearAllPencilsAtRow:row Column:col];
    [_boardModel clearNumberAtRow:row Column:col];

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
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"New Hard Game") {
            NSLog(@"New Hard Game Button");
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Clear Conflicting Cells") {
            NSLog(@"Clear Conflicting Cells");
        } else if ([actionSheet buttonTitleAtIndex:buttonIndex] == @"Clear All Cells") {
            NSLog(@"Clear All Cells");
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
