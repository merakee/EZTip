//
//  EZTipQuartzView.m
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright 2009 Indriam Inc. All rights reserved.
//

#import "EZTipQuartzView.h"
#import "AppConstants.h"
#import "AppUIManager.h"

@implementation EZTipQuartzView

@synthesize billAmountTextQV;
@synthesize tipPercentQV;
@synthesize tipAmountQV;
@synthesize numberOfPeopleQV;
@synthesize totalAmountQV;
@synthesize totalBillAmountQV;
@synthesize totalTipAmountQV;
@synthesize currencySymbolQV;

// local variable

// back ground button
float pointX1, pointY1, pointX2, pointY2;
float edgeRadius;
float lineWidth;

// shadow
float shadowShiftX;
float shadowShiftY;
float shadowBlur;
CGColorRef shadowColor;
CGPoint textPosition;
float textWidth;
int cSymbolLength;

// text related
NSString *tempText;
UIFont *tempFont;
CGRect tempRect;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        billAmountTextQV = @"0.0";
        tipPercentQV = @kDefaultTipPercent;
        tipAmountQV = @0.0f;
        numberOfPeopleQV = @kDefaultNumberOfPeople;
        totalAmountQV = @0.0f;
        totalBillAmountQV = @0.0f;
        totalTipAmountQV = @0.0f;
        currencySymbolQV = @"$";
    }
    return self;
}

#pragma mark Drawing methods
- (void)drawRect:(CGRect)rect {
    // variables
    edgeRadius = 4.0;
    lineWidth = 2.0;
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    cSymbolLength = (int)currencySymbolQV.length;
    cSymbolLength = (cSymbolLength > 5) ? 5 : cSymbolLength;

    // draw bill amount
    [self drawBillAmountInContext:context];

    // draw Tip Percent
    [self drawTipPercentInContext:context];

    // draw Tip Amount
    [self drawTipAmountInContext:context];

    // draw Number of People
    [self drawNumberOfPeopleInContext:context];

    // draw Total Amount
    [self drawTotalAmountInContext:context];

    // draw Bill Total Amount
    [self drawTotalBillAmountInContext:context];
}

// draw bill amount
- (void)drawBillAmountInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[0][0], kDisplayCoordinate[0][1] - 10.0, kDisplayCoordinate[0][2], 10.0);
    tempText = [[NSString alloc] initWithFormat:@"Bill Amount"];
    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Georgia" size:kCurrencySymbolFontSizeMain[cSymbolLength - 1]];
    tempRect =
        CGRectMake(kDisplayCoordinate[0][0] - 18.0, kDisplayCoordinate[0][1] + 5.0, kDisplayCoordinate[0][2], 10.0);
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [currencySymbolQV drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:48.0];
    tempRect = CGRectMake(kDisplayCoordinate[0][0], kDisplayCoordinate[0][1], kDisplayCoordinate[0][2],
                          kDisplayCoordinate[0][3]);

    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [billAmountTextQV drawInRect:tempRect withAttributes:aDict];
}

// draw Tip Amount
- (void)drawTipAmountInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[1][0], kDisplayCoordinate[1][1] - 10.0, kDisplayCoordinate[1][2], 10.0);
    if (numberOfPeopleQV.intValue == 1) {
        tempText = [[NSString alloc] initWithFormat:@"Total Tip"];
    } else {
        tempText = [[NSString alloc] initWithFormat:@"Each Tip"];
    }

    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Georgia" size:kCurrencySymbolFontSize[cSymbolLength - 1]];
    tempRect =
        CGRectMake(kDisplayCoordinate[1][0] - 17.0, kDisplayCoordinate[1][1] + 5.0, kDisplayCoordinate[1][2], 10.0);
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [currencySymbolQV drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:32.0];
    tempRect = CGRectMake(kDisplayCoordinate[1][0], kDisplayCoordinate[1][1] + 5.0, kDisplayCoordinate[1][2],
                          kDisplayCoordinate[1][3]);

    tempText = [[NSString alloc] initWithFormat:@"%.2f", tipAmountQV.floatValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];
}

// draw Tip Percent
- (void)drawTipPercentInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[2][0], kDisplayCoordinate[2][1] - 10.0, kDisplayCoordinate[2][2], 10.0);
    tempText = [[NSString alloc] initWithFormat:@"Tip"];
    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentCenter]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Georgia" size:28.0];
    tempRect =
        CGRectMake(kDisplayCoordinate[2][0] + 55.0, kDisplayCoordinate[2][1] + 8.0, kDisplayCoordinate[2][2], 10.0);
    tempText = [[NSString alloc] initWithFormat:@"%%"];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:32.0];
    tempRect = CGRectMake(kDisplayCoordinate[2][0], kDisplayCoordinate[2][1] + 5.0, kDisplayCoordinate[2][2],
                          kDisplayCoordinate[2][3]);

    tempText = [[NSString alloc] initWithFormat:@"%d", tipPercentQV.intValue];

    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentRight]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];
}

// draw Total Amount
- (void)drawTotalAmountInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[3][0], kDisplayCoordinate[3][1] - 10.0, kDisplayCoordinate[3][2], 10.0);
    if (numberOfPeopleQV.intValue == 1) {
        tempText = [[NSString alloc] initWithFormat:@"Total Bill"];
    } else {
        tempText = [[NSString alloc] initWithFormat:@"Each Total"];
    }
    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Georgia" size:kCurrencySymbolFontSize[cSymbolLength - 1]];
    tempRect =
        CGRectMake(kDisplayCoordinate[3][0] - 17.0, kDisplayCoordinate[3][1] + 5.0, kDisplayCoordinate[3][2], 10.0);
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [currencySymbolQV drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:28.0];
    tempRect = CGRectMake(kDisplayCoordinate[3][0], kDisplayCoordinate[3][1] + 5.0, kDisplayCoordinate[3][2],
                          kDisplayCoordinate[3][3]);

    tempText = [[NSString alloc] initWithFormat:@"%.2f", totalAmountQV.floatValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];
}

// draw Number of People
- (void)drawNumberOfPeopleInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[4][0], kDisplayCoordinate[4][1] - 10.0, kDisplayCoordinate[4][2], 10.0);
    tempText = [[NSString alloc] initWithFormat:@"People"];
    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentCenter]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:32.0];
    tempRect = CGRectMake(kDisplayCoordinate[4][0], kDisplayCoordinate[4][1] + 5.0, kDisplayCoordinate[4][2],
                          kDisplayCoordinate[4][3]);

    tempText = [[NSString alloc] initWithFormat:@"%d", numberOfPeopleQV.intValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentCenter]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];
}

// draw Bill Total Amount
- (void)drawTotalBillAmountInContext:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1.0); // Black
    CGContextSetTextDrawingMode(context, kCGTextFill);
    // tag
    tempFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    tempRect = CGRectMake(kDisplayCoordinate[5][0], kDisplayCoordinate[5][1] - 10.0, kDisplayCoordinate[5][2], 10.0);
    tempText = [[NSString alloc] initWithFormat:@"Total Bill"];
    NSDictionary *aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempText = [[NSString alloc] initWithFormat:@"Total Tip"];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentRight]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Georgia" size:kCurrencySymbolFontSize[cSymbolLength - 1]];
    tempRect =
        CGRectMake(kDisplayCoordinate[5][0] - 17.0, kDisplayCoordinate[5][1] + 5.0, kDisplayCoordinate[5][2], 10.0);
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [currencySymbolQV drawInRect:tempRect withAttributes:aDict];

    tempFont = [UIFont fontWithName:@"Helvetica" size:28.0];
    tempRect = CGRectMake(kDisplayCoordinate[5][0], kDisplayCoordinate[5][1] + 5.0, kDisplayCoordinate[5][2],
                          kDisplayCoordinate[5][3]);

    tempText = [[NSString alloc] initWithFormat:@"%.2f", totalBillAmountQV.floatValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    tempText = [[NSString alloc] initWithFormat:@"%.2f", totalTipAmountQV.floatValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentRight]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];

    CGContextSetTextDrawingMode(context, kCGTextInvisible);
    tempText = [[NSString alloc] initWithFormat:@"%.2f", totalTipAmountQV.floatValue];
    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [tempText drawInRect:tempRect withAttributes:aDict];
    textPosition = CGContextGetTextPosition(context);
    textWidth = textPosition.x - kDisplayCoordinate[5][0];

    CGContextSetTextDrawingMode(context, kCGTextFill);
    tempFont = [UIFont fontWithName:@"Georgia" size:kCurrencySymbolFontSize[cSymbolLength - 1]];
    tempRect = CGRectMake(kDisplayCoordinate[5][0] + kDisplayCoordinate[5][2] - textWidth - 18.0,
                          kDisplayCoordinate[5][1] + 5.0, kDisplayCoordinate[5][2], 10.0);

    aDict = @{
        NSFontAttributeName : tempFont,
        NSParagraphStyleAttributeName : [AppUIManager getParagrahStyleWithLineBreakMode:NSLineBreakByTruncatingTail
                                                                       andTextAlignment:NSTextAlignmentLeft]
    };
    [currencySymbolQV drawInRect:tempRect withAttributes:aDict];
}

@end
