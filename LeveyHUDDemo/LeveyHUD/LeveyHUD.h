//
//  LeveyHUD.h
//  LeveyHUD
//
//  Created by Levey on 11/28/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//
//  Amend by so898 on 20/12/2012
//  Copyright (c) 2012 R³ Studio. All rights reserved.

#import <UIKit/UIKit.h>
@class LeveyHUDMask;
@interface LeveyHUD : UIWindow
{
    UILabel *_label;
    LeveyHUDMask *_topMask;
    LeveyHUDMask *_bottomMask;
}

+ (id)sharedHUD;

- (void)appearWithText:(NSString *)text;
- (void)disappear;
- (void)delayDisappear:(NSTimeInterval)delay withText:(NSString *)text;

@end
