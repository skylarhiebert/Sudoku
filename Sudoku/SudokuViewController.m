//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/9/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "SudokuViewController.h"
#import "BoardView.h"
#import "ButtonsView.h"

@implementation SudokuViewController

@synthesize boardView;
@synthesize buttonView;

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
    boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [boardView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:boardView];
    buttonView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 320, 320, 140)];
    [buttonView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:buttonView];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        boardView.frame = CGRectMake(0, 0, 320, 320);
        buttonView.frame = CGRectMake(0, 320, 320, 140);
    } else {
        boardView.frame = CGRectMake(0, 0, 300, 300);
        buttonView.frame = CGRectMake(300, 0, 180, 300);
    }
}

@end
