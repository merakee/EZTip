/*
 *  AppConstants.h
 *  EZTip
 *
 *  Created by Bijit Halder on 7/29/09.
 *  Copyright 2009 Indriam Inc. All rights reserved.
 *
 */

// Parameters
#define kMaxDigitsForBillAmount 5
#define kDefaultTipPercent   16
#define kMinTipPercent       0
#define kMaxTipPercent       100
#define kDefaultNumberOfPeople   1
#define kMinNumberOfPeople   1
#define kMaxNumberOfPeople   99
#define kRoundMode          0 // round for each , 1 round for all
#define kEpsilon            0.00 //adjustment for floor and ceil function in calculation

// button index table
static const int kButtonToValueTable[11]={0,1,2,3,4,5,6,7,8,9,0};


/* EZ Tip display parameters */
#define kNumberOfKeyPadButtons 12
#define kTipPercentAdjustButtons 2
#define kNumberOfPeopleAdjustButtons 2

//images
#define kEZTipViewBackGroundImage               @"EZTipBackGround.png"

// buttons
#define kKeyPadButtonsNormal1                   @"KeyPadButtonOneNormal.png"
#define kKeyPadButtonsHighlighted1              @"KeyPadButtonOneHighlighted.png"
#define kKeyPadButtonsNormal2                   @"KeyPadButtonTwoNormal.png"
#define kKeyPadButtonsHighlighted2              @"KeyPadButtonTwoHighlighted.png"
#define kKeyPadButtonsNormal3                   @"KeyPadButtonThreeNormal.png"
#define kKeyPadButtonsHighlighted3              @"KeyPadButtonThreeHighlighted.png"
#define kKeyPadButtonsNormal4                   @"KeyPadButtonFourNormal.png"
#define kKeyPadButtonsHighlighted4              @"KeyPadButtonFourHighlighted.png"
#define kKeyPadButtonsNormal5                   @"KeyPadButtongFiveNormal.png"
#define kKeyPadButtonsHighlighted5              @"KeyPadButtonFiveHighlighted.png"
#define kKeyPadButtonsNormal6                   @"KeyPadButtonSixNormal.png"
#define kKeyPadButtonsHighlighted6              @"KeyPadButtonSixHighlighted.png"
#define kKeyPadButtonsNormal7                   @"KeyPadButtonSevenNormal.png"
#define kKeyPadButtonsHighlighted7              @"KeyPadButtonSevenHighlighted.png"
#define kKeyPadButtonsNormal8                   @"KeyPadButtonEightNormal.png"
#define kKeyPadButtonsHighlighted8              @"KeyPadButtonEightHighlighted.png"
#define kKeyPadButtonsNormal9                   @"KeyPadButtonNineNormal.png"
#define kKeyPadButtonsHighlighted9              @"KeyPadButtonNineHighlighted.png"
#define kKeyPadButtonsNormal10                  @"KeyPadButtonZeroNormal.png"
#define kKeyPadButtonsHighlighted10             @"KeyPadButtonZeroHighlighted.png"
#define kKeyPadButtonsNormal11                  @"KeyPadButtonDotNormal.png"
#define kKeyPadButtonsHighlighted11             @"KeyPadButtonDotHighlighted.png"
#define kKeyPadButtonsNormal12                  @"KeyPadButtonDelNormal.png"
#define kKeyPadButtonsHighlighted12             @"KeyPadButtonDelHighlighted.png"

#define kTipPercentAdjustButtonIncreaseNormal           @"AdjustButtonIncreaseNormal.png"
#define kTipPercentAdjustButtonIncreaseHighlighted      @"AdjustButtonIncreaseHighlighted.png"
#define kTipPercentAdjustButtonDecreaseNormal           @"AdjustButtonDecreaseNormal.png"
#define kTipPercentAdjustButtonDecreaseHighlighted      @"AdjustButtonDecreaseHighlighted.png"
#define kNumberOfPeopleAdjustButtonIncreaseNormal             @"AdjustButtonIncreaseNormal.png"
#define kNumberOfPeopleAdjustButtonIncreaseHighlighted        @"AdjustButtonIncreaseHighlighted.png"
#define kNumberOfPeopleAdjustButtonDecreaseNormal             @"AdjustButtonDecreaseNormal.png"
#define kNumberOfPeopleAdjustButtonDecreaseHighlighted        @"AdjustButtonDecreaseHighlighted.png"


// layput parameters
static const float kDisplayCoordinate[7][4] ={
{25.0,20.0,290.0,60.0},
{25.0,90.0,140.0,60.0},
{180.0,90.0,55.0,60.0},
{25.0,155.0,140.0,60.0},
{180.0,155.0,80.0,60.0},
{25.0,220.0,285.0,60.0},
{5.0,270.0,310.0,30.0}};

static const float kButtonCoordinate[17][4] ={
{5.0, 305.0, 70.0, 50.0}, 
{85.0, 305.0, 70.0, 50.0}, 
{165.0, 305.0, 70.0, 50.0}, 
{245.0, 305.0, 70.0, 50.0}, 
{5.0, 365.0, 70.0, 50.0}, 
{85.0, 365.0, 70.0, 50.0}, 
{165.0, 365.0, 70.0, 50.0}, 
{245.0, 365.0, 70.0, 50.0}, 
{5.0, 425.0, 70.0, 50.0}, 
{85.0, 425.0, 70.0, 50.0}, 
{165.0, 425.0, 70.0, 50.0}, 
{245.0, 425.0, 70.0, 50.0}, 
{268.0, 78.0, 45.0, 25.0}, 
{268.0, 108.0, 45.0, 25.0}, 
{268.0, 143.0, 45.0, 25.0}, 
{268.0, 173.0, 45.0, 25.0}, 
{5.0,270.0,310.0,30.0}};

static const float kSwitchColor[4] ={150.0/255.0,150.0/255.0,150.0/255.0,1.0};
static const float kCurrencySymbolFontSize[5]={22.0,14.0,10.0,6.0,2.0};
static const float kCurrencySymbolFontSizeMain[5]={26.0,16.0,10.0,6.0,2.0};

/* Persistancy related */
#define kAppStateFileName       @"appStateFileName.plist"
#define kKeyForAppState         @"appstate"
#define kKeyForBillAmount       @"billamount"
#define kKeyForTipPercent       @"tippercent"
#define kKeyForNumberOfPeople   @"numberofpeople"
#define kKeyForTipMethodIndex   @"tipmethodindex"

/* Debug related */
#define kButtonColor 1.0
#define kButtonOpacity 1.0
