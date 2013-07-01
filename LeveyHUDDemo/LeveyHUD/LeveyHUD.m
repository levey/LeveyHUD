//
//  LeveyHUD.m
//  LeveyHUD
//
//  Created by Levey on 11/28/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//
//  Amend by so898 on 20/12/2012
//  Copyright (c) 2012 R³ Studio. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "LeveyHUD.h"
#import "LeveyHUDMask.h"

#define MASKOFFSET 30.0f
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
        
        _topMask = [[LeveyHUDMask alloc] initWithFrame:CGRectMake(0, -30, 320, 226)];
        _topMask.hidden = YES;
        [self addSubview:_topMask];
        _bottomMask = [[LeveyHUDMask alloc] initWithFrame:CGRectMake(0, 284, 320, 226.0f)];
        _bottomMask.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        _bottomMask.hidden = YES;
        [self addSubview:_bottomMask];
        
    }
    return  self;
}

+ (id)sharedHUD
{
    @synchronized(self)
    {
        if (_sharedHUD == nil)
        {
            [self new];
        }
    }
    return _sharedHUD;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (_sharedHUD == nil) {
            _sharedHUD = [super allocWithZone:zone];
            return _sharedHUD;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
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
    //float x =  (self.bounds.size.width - [text sizeWithFont:_label.font].width)/2;
    _label.text = text;
    if (self.hidden == NO)
    {
        return;
    }
    
    self.hidden = NO;
    _topMask.alpha = 0.0f;
    _bottomMask.alpha = 0.0f;
    _topMask.hidden = NO;
    _bottomMask.hidden = NO;
    self.alpha = 0.0f;
    _label.hidden = YES;
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1.0f;
        _topMask.alpha = 1.0f;
        _bottomMask.alpha = 1.0f;
        _topMask.frame = CGRectOffset(_topMask.frame, 0, MASKOFFSET);
        _bottomMask.frame = CGRectOffset(_bottomMask.frame, 0, -MASKOFFSET);
    } completion:^(BOOL finished) {
        if (finished) {
            _label.hidden = NO;
        }
    }];
}
- (void)disappear
{
    if (self.hidden == YES)
    {
        return;
    }
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0.0f;
        _topMask.alpha = 0.0f;
        _bottomMask.alpha = 0.0f;
        _topMask.frame = CGRectOffset(_topMask.frame, 0, -MASKOFFSET);
        _bottomMask.frame = CGRectOffset(_bottomMask.frame, 0, MASKOFFSET);
    } completion:^(BOOL finished) {
        if (finished) {
            _topMask.hidden = YES;
            _bottomMask.hidden = YES;
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
