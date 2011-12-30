//
//  LeveyHUD.m
//  LeveyHUD
//
//  Created by Levey on 11/28/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import "LeveyHUD.h"
#import "LeveyHUDBottomMask.h"
#import "LeveyHUDTopMask.h"



#define MASKOFFSET 30.0f
static LeveyHUD *_sharedHUD = nil;

@implementation LeveyHUD

#pragma mark - Initialization
- (id)init
{
    if (self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]]) 
    {
        self.hidden = YES;
        self.windowLevel = UIWindowLevelAlert;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:_spinner];
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = UITextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.shadowColor = [UIColor blackColor];
        _label.shadowOffset = CGSizeMake(0, 1);
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        [self addSubview:_label];
        
        _topMask = [[LeveyHUDTopMask alloc] initWithFrame:CGRectMake(0, -30, 320, 226)];
        _topMask.hidden = YES;
        [self addSubview:_topMask];
        _bottomMask = [[LeveyHUDBottomMask alloc] initWithFrame:CGRectMake(0, 284, 320, 226.0f)];
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
            _sharedHUD = [[self alloc] init];
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

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}
- (void)release
{
    
}


- (id)autorelease
{
    return self;
}
- (void)dealloc
{
    [_topMask release];
    [_bottomMask release];
    [_label release];
    [_sharedHUD release];
    [super dealloc];
}

#pragma mark - view's methods
- (void)layoutSubviews
{
    [super layoutSubviews];

    _label.frame = CGRectMake(0, self.center.y - 25.0f, self.bounds.size.width, 30);
}


#pragma mark - instant methods
- (void)appearWithText:(NSString *)text
{
    float x =  (self.bounds.size.width - [text sizeWithFont:_label.font].width)/2;
    _spinner.frame = CGRectMake(x - 38, self.center.y - 30.0f, 40, 40);
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
            [_spinner startAnimating];
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
            [_spinner stopAnimating];
            _label.text = @"";
            self.hidden = YES;
        }
    }];    
}

- (void)delayDisappear:(NSTimeInterval)delay withText:(NSString *)text
{
    [_spinner stopAnimating];
    _label.text = text;
    [self performSelector:@selector(disappear) withObject:nil afterDelay:delay];
}

@end
