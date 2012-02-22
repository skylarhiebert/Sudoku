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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
            if (_boardModel != nil && ![_boardModel numberIsFixedAtRow:row Column:col]) {
                _selectedRow = row;
                _selectedCol = col;
                [self setNeedsDisplay];
            }
        }
    }
}

-(void) selectFirstAvailableCell {
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
            if (![_boardModel numberIsFixedAtRow:i Column:j]) {
                _selectedCol = j;
                _selectedRow = i;
            }
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"drawRect:");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGRect myBounds = [self bounds];
    const CGFloat gridSize = (myBounds.size.width < myBounds.size.height) ? myBounds.size.width - 6 : myBounds.size.height - 6;
    const CGPoint center = CGPointMake(myBounds.size.width/2, myBounds.size.height/2);
    const CGPoint origin = CGPointMake(center.x - gridSize/2, center.y - gridSize/2);
    const CGFloat delta = gridSize / 3;
    const CGFloat d = delta / 3;
    const CGFloat s = d / 3;
    
    CGContextSetLineWidth(context, 6);
    [[UIColor blackColor] setStroke];
    CGContextAddRect(context, CGRectMake(origin.x, origin.y, gridSize, gridSize));

    
    [[UIColor lightGrayColor] setFill];
    CGContextFillRect(context, CGRectMake(origin.x + _selectedCol * d, 
                                          origin.y + _selectedRow * d, 
                                          d, d));
      	
    // Draw delta squares 3x3
    for(int row = 0; row < 3; row++) {
        for(int col = 0; col < 3; col++) {       
            // Draw internal delta grid 3x3
            for (int dRow = 0; dRow < 3; dRow++) {
                for (int dCol = 0; dCol < 3 ; dCol++) {
                    CGContextSetLineWidth(context, 1);
                    const int nRow = row * 3 + dRow;
                    const int nCol = col * 3 + dCol;
                    [[UIColor blackColor] setStroke];

                    CGContextAddRect(context, CGRectMake(origin.x + col * delta + dCol * d, 
                                                         origin.y + row * delta + dRow * d, 
                                                         d, d));
                    CGContextStrokePath(context);
                    
                    int number = [_boardModel numberAtRow:nRow Column:nCol];
                    if (number != 0 && ![_boardModel anyPencilsSetAtRow:dRow Column:dCol]) {
                        UIFont *font = [UIFont boldSystemFontOfSize:30];
                        if ([_boardModel numberIsFixedAtRow:nRow Column:nCol]) {
                            [[UIColor blackColor] setFill];
                        } else if ([_boardModel isConflictingEntryAtRow:nRow Column:nCol]) {
                            [[UIColor redColor] setFill];
                        } else {
                            [[UIColor blueColor] setFill];
                        }
                        const NSString *text = [NSString stringWithFormat:@"%d", number];
                        const CGSize textSize = [text sizeWithFont:font];
                        const CGFloat x = origin.x + nCol * d + 0.5*(d - textSize.width);
                        const CGFloat y = origin.y + nRow * d + 0.5*(d - textSize.height);
                        const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
                        [text drawInRect:textRect withFont:font];
                    } else if ([_boardModel anyPencilsSetAtRow:dRow Column:dCol]) { // Draw internal s grid
                        for (int sRow = 0; sRow < 3; sRow++) {
                            for (int sCol = 0; sCol < 3 ; sCol++) {
                                CGContextSetLineWidth(context, 1);
                                [[UIColor blackColor] setStroke];
                                CGContextAddRect(context, CGRectMake(origin.x + col * delta + dCol * d + sCol * s, 
                                                                     origin.y + row * delta + dRow * d + sRow * s, 
                                                                     s, s));
                                CGContextStrokePath(context);
                                const int sNum = sRow * 3 + sCol + 1;
                                if ([_boardModel isSetPencil:sNum AtRow:dRow Column:dCol]) {
                                    UIFont *font = [UIFont boldSystemFontOfSize:12];
                                    [[UIColor blackColor] setFill];
                                    const NSString *text = [NSString stringWithFormat:@"%d", sNum];
                                    const CGSize textSize = [text sizeWithFont:font];
                                    const CGFloat x = origin.x + nCol * d + s * sCol + 0.5*(s - textSize.width);
                                    const CGFloat y = origin.y + nRow * d + s * sRow + 0.5*(s - textSize.height);
                                    const CGRect textRect = CGRectMake(x, y, textSize.width, textSize.height);
                                    [text drawInRect:textRect withFont:font];
                                }

                            }
                        }
                    }
                }
            }
            CGContextSetLineWidth(context, 3);
            [[UIColor blackColor] setStroke];
            CGContextAddRect(context, CGRectMake(origin.x + col * delta, origin.y + row * delta, delta, delta));
            CGContextStrokePath(context);
        }
    }
}


@end
