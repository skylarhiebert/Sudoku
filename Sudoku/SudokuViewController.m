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

@implementation SudokuViewController

@synthesize boardView = _boardView;
@synthesize buttonView = _buttonView;
@synthesize boardModel = _boardModel;
@synthesize pencilEnabled = _pencilEnabled;

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
	// Do any additional setup after loading the view, typically from a nib.
    _boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, 320, 320) AndBoardModel:_boardModel];
    [_boardView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_boardView];
    _buttonView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 320, 320, 140)];
    [_buttonView setBackgroundColor:[UIColor grayColor]];
    
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
    NSLog(@"numberPressed:");
    
}

- (IBAction)clearCellPressed:(UIButton *)sender {
    NSLog(@"clearCellPressed:");
}

- (IBAction)menuPressed:(UIButton *)sender {
    NSLog(@"menuPressed:");
}

@end
