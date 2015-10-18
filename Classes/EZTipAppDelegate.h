//
//  EZTipAppDelegate.h
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright Indriam Inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EZTipViewController;


@interface EZTipAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow                        *window;
	EZTipViewController             *ezTipViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EZTipViewController *ezTipViewController;

#pragma mark Local Methods

#pragma mark Persistancy Methods

@end
