//
//  EZTipViewController.h
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright 2009 Indriam Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZTipQuartzView.h"
#import "AppConstants.h"

@interface EZTipViewController : UIViewController

@property(strong, nonatomic) EZTipQuartzView *ezTipQuartzView;

#pragma mark init methods

#pragma mark Local Methods
- (void)setAllButtons;
- (void)attachAllButtons;
- (void)refreshDisplay;
- (void)setParametersForDigits;
- (void)updateAppStateTo:(int)state;

#pragma mark Action Methods
- (void)keyPadButtonPressed:(id)sender;
- (void)increaseTipPercent:(id)sender;
- (void)decreaseTipPercent:(id)sender;
- (void)increaseNumberOfPeople:(id)sender;
- (void)decreaseNumberOfPeople:(id)sender;
- (void)tipMethodControlSwitchPressed:(id)sender;

#pragma mark Persistance Methods
- (void)getAppState;
- (void)saveAppState;
@property(NS_NONATOMIC_IOSONLY, readonly, copy) NSString *appStateFilePath;
@end
