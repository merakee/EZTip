//
//  EZTipQuartzView.h
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright 2009 Indriam Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EZTipQuartzView : UIView {
	NSString *billAmountTextQV;
	NSNumber *tipPercentQV;
	NSNumber *tipAmountQV;
	NSNumber *numberOfPeopleQV;
	NSNumber *totalAmountQV;
	NSNumber *totalBillAmountQV;
	NSNumber *totalTipAmountQV;
	NSString *currencySymbolQV;
}

@property (nonatomic, retain) NSString *billAmountTextQV;
@property (nonatomic, retain) NSNumber *tipPercentQV;
@property (nonatomic, retain) NSNumber *tipAmountQV;
@property (nonatomic, retain) NSNumber *numberOfPeopleQV;
@property (nonatomic, retain) NSNumber *totalAmountQV;
@property (nonatomic, retain) NSNumber *totalBillAmountQV;
@property (nonatomic, retain) NSNumber *totalTipAmountQV;
@property (nonatomic, retain) NSString *currencySymbolQV;

#pragma mark Local Drawing Methods
- (void)drawBillAmountInContext:(CGContextRef)context;
- (void)drawTipPercentInContext:(CGContextRef)context;
- (void)drawTipAmountInContext:(CGContextRef)context;
- (void)drawNumberOfPeopleInContext:(CGContextRef)context;
- (void)drawTotalAmountInContext:(CGContextRef)context;
- (void)drawTotalBillAmountInContext:(CGContextRef)context;

@end
