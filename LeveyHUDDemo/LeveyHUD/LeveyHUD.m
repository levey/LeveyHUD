//
//  LeveyHUD.m
//  LeveyHUD
//
//  Created by Levey on 11/28/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//
//  Amend by so898 on 20/12/2012
//  Copyright (c) 2012 R³ Studio. All rights reserved.
//
//  Modify by juanmaohu 01/12/2014

#import <QuartzCore/QuartzCore.h>
#import "LeveyHUD.h"
#import "LeveyHUDMask.h"

static const float MaskOffset = 30.0f;
static LeveyHUD *_sharedHUD = nil;

@implementation LeveyHUD

#pragma mark - Initialization
- (id)init
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] bounds]])
    {
        self.hidden = YES;
        self.windowLevel = UIWindowLevelAlert;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.shadowColor = [UIColor blackColor];
        _label.shadowOffset = CGSizeMake(0, 1);
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        [self addSubview:_label];
        
        CGFloat maskHeight = ([[UIScreen mainScreen] bounds].size.height - MaskOffset ) / 2;
        _topMask = [[LeveyHUDMask alloc] initWithFrame:CGRectMake(0, - MaskOffset, 320, maskHeight)];
        [self addSubview:_topMask];
        
        _bottomMask = [[LeveyHUDMask alloc] initWithFrame:CGRectMake(0, maskHeight + MaskOffset * 2, 320, maskHeight)];
        _bottomMask.transform = CGAffineTransformMakeRotation(M_PI);
        [self addSubview:_bottomMask];
    }
    
    return  self;
}

+ (id)sharedHUD
{
    if (!_sharedHUD) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedHUD = [[LeveyHUD alloc] init];
        });
    }
    
    return _sharedHUD;
}

#pragma mark - view's methods
- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(0, self.center.y - 15, self.bounds.size.width, 30);
}


#pragma mark - instant methods
- (void)appearWithText:(NSString *)text
{
    _label.text = text;
    if (!self.hidden)
    {
        return;
    }
    
    self.hidden = NO;
    _label.hidden = YES;
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1.0f;
        _topMask.frame = CGRectOffset(_topMask.frame, 0, MaskOffset);
        _bottomMask.frame = CGRectOffset(_bottomMask.frame, 0, -MaskOffset);
    } completion:^(BOOL finished) {
        if (finished) {
            _label.hidden = NO;
        }
    }];
}
- (void)disappear
{
    if (self.hidden)
    {
        return;
    }
    
    [UIView animateWithDuration:0 animations:^{
        self.alpha = 0.0f;
        _topMask.frame = CGRectOffset(_topMask.frame, 0, -MaskOffset);
        _bottomMask.frame = CGRectOffset(_bottomMask.frame, 0, MaskOffset);
    } completion:^(BOOL finished) {
        if (finished) {
            _label.text = @"";
            self.hidden = YES;
        }
    }];
}

- (void)delayDisappear:(NSTimeInterval)delay withText:(NSString *)text
{
    _label.text = text;
    [self performSelector:@selector(disappear) withObject:nil afterDelay:delay];
}

@end
