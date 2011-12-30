//
//  LeveyHUD.h
//  LeveyHUD
//
//  Created by Levey on 11/28/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeveyHUDTopMask, LeveyHUDBottomMask;
@interface LeveyHUD : UIWindow
{
    UIActivityIndicatorView *_spinner;
    UILabel *_label;
    LeveyHUDTopMask *_topMask;
    LeveyHUDBottomMask *_bottomMask;
}

+ (id)sharedHUD;

- (void)appearWithText:(NSString *)text;
- (void)disappear;
- (void)delayDisappear:(NSTimeInterval)delay withText:(NSString *)text;

@end
