//
//  BoardView.m
//  Sudoku
//
//  Created by Skylar Hiebert on 2/19/12.
//  Copyright (c) 2012 Washington State University. All rights reserved.
//

#import "BoardView.h"
#import "SudokuBoard.h"

@interface BoardView() {
    UITapGestureRecognizer *fingerTapRecognizer;
}

-(void) addTapGestureRecognizer;
-(void) handleFingerTap:(UIGestureRecognizer*)sender;

@end

@implementation BoardView

@synthesize selectedRow = _selectedRow, selectedCol = _selectedCol, boardModel = _boardModel;

- (id)initWithFrame:(CGRect)frame AndBoardModel:(SudokuBoard *) boardModel
{
    self = [super initWithFrame:frame];
    if (self) {
        _boardModel = boardModel;
        [self addTapGestureRecognizer];
    }
    return self;
}


-(void) addTapGestureRecognizer {
    NSLog(@"addTapGestureRecognizer:boardView");
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
    const CGFloat delta = gridSize / 3;
    const CGFloat d = delta / 3;
    
    const int row = (int) ((tapPoint.y - origin.y) / d);
    const int col = (int) ((tapPoint.x - origin.x) / d);
    
    if (0 <= row && row < 9 && 0 <= col && col < 9) {
        if (row != _selectedRow || col != _selectedCol) {
            //if (boardModel != nil ** ![board NumberIsFixedtRow:row Column:col]) {
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
            //}
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGRect myBounds = [self bounds];
    const CGFloat gridSize = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width : myBounds.size.height;
    const CGPoint center = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(center.x - gridSize/2, center.y - gridSize/2);
    const CGFloat delta = gridSize / 3;
    const CGFloat d = delta / 3;
    const CGFloat s = d / 3;
      	
    // Draw delta squares 3x3
    for(int row = 0; row < 3; row++) {
        for(int col = 0; col < 3; col++) {       
            // Draw internal delta grid 3x3
            for (int dRow = 0; dRow < 3; dRow++) {
                for (int dCol = 0; dCol < 3 ; dCol++) {
                    //NSLog(@"col,row:%i, %d ; dCol,dRow:%i, %i", col, row, dCol, dRow);
                    /*
                    if (origin.x + _selectedCol * d == origin.x + col * delta + dCol * d && 
                        origin.y + _selectedRow * d == origin.y + row * delta + dRow * d) {
                        NSLog(@"setColor:lightGray");
                        [[UIColor lightGrayColor] setFill];
                    } else {
                        [[UIColor whiteColor] setFill];
                    }
                     */
                    CGContextSetLineWidth(context, 2);
                    [[UIColor blackColor] setStroke];
                    CGContextAddRect(context, CGRectMake(origin.x + col * delta + dCol * d, 
                                                         origin.y + row * delta + dRow * d, 
                                                         d, d));
                    CGContextStrokePath(context);
                    
                    // Draw internal s grid if it exists here
                    // TODO: Create draw code if condition
                    if (0) {
                        for (int sRow = 0; sRow < 3; sRow++) {
                            for (int sCol = 0; sCol < 3 ; sCol++) {
                                CGContextSetLineWidth(context, 1);
                                [[UIColor blackColor] setStroke];
                                CGContextAddRect(context, CGRectMake(origin.x + col * delta + dCol * d + sCol * s, 
                                                                     origin.y + row * delta + dRow * d + sRow * s, 
                                                                     s, s));
                                CGContextStrokePath(context);
                            }
                        }
                    }
                }
            }
            CGContextSetLineWidth(context, 6);
            [[UIColor blackColor] setStroke];
            CGContextAddRect(context, CGRectMake(origin.x + col * delta, origin.y + row * delta, delta, delta));
            CGContextStrokePath(context);
        }
    }
    
    // Draw board border
    //CGContextSetLineWidth(context, 5);
    //[[UIColor blackColor] setStroke];
    //CGContextAddRect(context, CGRectMake(origin.x, origin.y, gridSize, gridSize));
    //CGContextStrokePath(context);

    
    [[UIColor lightGrayColor] setFill];
    CGContextFillRect(context, CGRectMake(origin.x + _selectedCol * d, 
                                          origin.y + _selectedRow * d, 
                                          d, d));
}


@end
