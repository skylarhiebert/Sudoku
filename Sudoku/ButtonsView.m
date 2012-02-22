//
//  ButtonsView.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "ButtonsView.h"

@interface ButtonsView() {
    //UITapGestureRecognizer *fingerTapRecognizer;
}

//-(void) addTapGestureRecognizer;
//-(void) handleFingerTap:(UIGestureRecognizer*)sender;

@end

@implementation ButtonsView

@synthesize selectedRow = _selectedRow, selectedCol = _selectedCol;
@synthesize pencilEnabled = _pencilEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self addTapGestureRecognizer];
    }
    return self;
}

/*
-(void) addTapGestureRecognizer {
    NSLog(@"addTapGestureRecognizer:");
    fingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFingerTap:)];
    fingerTapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:fingerTapRecognizer];
    
}

-(void) handleFingerTap:(UIGestureRecognizer*)sender {
    NSLog(@"handleFingerTap:");
    const CGPoint tapPoint = [sender locationInView:sender.view];
    const CGRect myBounds = [self bounds];
    const CGFloat gridSize = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width : myBounds.size.height;
    const CGPoint center = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(center.x - gridSize/2, center.y - gridSize/2);
    
    if (myBounds.size.width > myBounds.size.height) { // portrait
        const int row = (int) ((tapPoint.y - origin.y) / 2);
        const int col = (int) ((tapPoint.x - origin.x) / 6);
        if (0 <= row && row < 2 && 0 <= col && col < 6) {
            if (row != _selectedRow || col != _selectedCol) {
                //if (board != nil ** ![board NumberIsFixedtRow:row Column:col]) {
                NSLog(@"Selected portrait row, col in buttonsView %i %i", row, col);
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
                //}
            }
        } 
    } else { // landscape
        const int row = (int) ((tapPoint.y - origin.y) / 6);
        const int col = (int) ((tapPoint.x - origin.x) / 2);
        if (0 <= row && row < 6 && 0 <= col && col < 2) {
            if (row != _selectedRow || col != _selectedCol) {
                //if (board != nil ** ![board NumberIsFixedtRow:row Column:col]) {
                NSLog(@"Selected landscape row, col in buttonsView %i %i", row, col);
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
                //}
            }
        }      
    }
}
*/

- (void) layoutSubviews {
    //CGContextRef context = UIGraphicsGetCurrentContext();
    static const int buttonTagsPortrait[2][6] = {
        1,2,3,4,5,11,6,7,8,9,10,12
    };
    static const int buttonTagsLandscape[6][2] = {
        1,6,2,7,3,8,4,9,5,10,11,12
    };
    const CGRect myBounds = [self bounds];
   // CGContextSetLineWidth(context, 2);
  //  [[UIColor blackColor] setStroke];
    
    if (myBounds.size.width > myBounds.size.height) { // portrait
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/6, myBounds.size.height/2);
        for (int row = 0; row < 2; row++) {
            for (int col = 0; col < 6; col++) {
                const int tag = buttonTagsPortrait[row][col];
                UIView *button = [self viewWithTag:tag];
                //[button setBackgroundColor:[UIColor redColor]];
                button.frame = CGRectMake(buttonSize.width*col, buttonSize.height*row, buttonSize.width, buttonSize.height);
            }
        }
    } else { // landscape
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/2, myBounds.size.height/6);
        for (int row = 0; row < 6; row++) {
            for (int col = 0; col < 2; col++) {
                const int tag = buttonTagsLandscape[row][col];
                UIView *button = [self viewWithTag:tag];
                //[button setBackgroundColor:[UIColor redColor]];
                button.frame = CGRectMake(buttonSize.width*col, buttonSize.height*row, buttonSize.width, buttonSize.height);
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
