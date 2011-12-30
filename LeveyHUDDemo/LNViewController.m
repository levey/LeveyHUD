//
//  LNViewController.m
//  LeveyHUDDemo
//
//  Created by Levey on 12/30/11.
//  Copyright (c) 2011 lunaapp.com. All rights reserved.
//

#import "LNViewController.h"
#import "LeveyHUD.h"
@implementation LNViewController


- (void)enoughBaby
{
    [[LeveyHUD sharedHUD] delayDisappear:1.0f withText:@"Done."];
}

- (IBAction)showBtnClicked:(id)sender 
{
    [[LeveyHUD sharedHUD] appearWithText:@"Loading..."];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(enoughBaby) userInfo:nil repeats:NO];
}
@end
