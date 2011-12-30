//
//  LeveyHUDTopMask.m
//  LeveyHUD
//
//  Created by Levey on 12/12/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import "LeveyHUDTopMask.h"

@implementation LeveyHUDTopMask

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float shadowHeight = 6;
    CGRect fillRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - shadowHeight);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor colorWithWhite:.0f alpha:.5f] setFill];
    CGContextFillRect(context, fillRect);
    
    [[UIColor colorWithWhite:.3f alpha:1.0f] setFill];
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 4.0f, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, fillRect.size.height - 1, fillRect.size.width, 1));
}


@end
