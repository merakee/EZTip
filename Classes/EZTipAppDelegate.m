//
//  EZTipAppDelegate.m
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright Indriam Inc 2009. All rights reserved.
//

#import "EZTipAppDelegate.h"
#import "EZTipViewController.h"
#import "AppConstants.h"


@implementation EZTipAppDelegate

@synthesize window;
@synthesize ezTipViewController;

//local variables

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	CGRect bounds = [[UIScreen mainScreen] bounds];
	window = [[UIWindow alloc] initWithFrame:bounds];
	
	// view controllers
	ezTipViewController =[[EZTipViewController alloc] initWithAppDelegate:self];
	
	// persistance 
	
    // Override point for customization after application launch
    [window addSubview:ezTipViewController.view];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)dealloc {
    [window release];
	[ezTipViewController release];
	//variables
	
	// call super
    [super dealloc];
}

#pragma mark Local Methods

#pragma mark Persistance Methods

@end
