//
//  ButtonsView.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "ButtonsView.h"

@implementation ButtonsView

@synthesize selectedRow = _selectedRow, selectedCol = _selectedCol;
@synthesize pencilEnabled = _pencilEnabled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void) layoutSubviews {
    static const int buttonTagsPortrait[2][6] = {
        1,2,3,4,5,11,6,7,8,9,10,12
    };
    static const int buttonTagsLandscape[6][2] = {
        1,6,2,7,3,8,4,9,5,10,11,12
    };
    const CGRect myBounds = [self bounds];
    
    if (myBounds.size.width > myBounds.size.height) { // portrait
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/6, myBounds.size.height/2);
        for (int row = 0; row < 2; row++) {
            for (int col = 0; col < 6; col++) {
                const int tag = buttonTagsPortrait[row][col];
                UIView *button = [self viewWithTag:tag];
                button.frame = CGRectMake(buttonSize.width*col, buttonSize.height*row, buttonSize.width, buttonSize.height);
            }
        }
    } else { // landscape
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/2, myBounds.size.height/6);
        for (int row = 0; row < 6; row++) {
            for (int col = 0; col < 2; col++) {
                const int tag = buttonTagsLandscape[row][col];
                UIView *button = [self viewWithTag:tag];
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
