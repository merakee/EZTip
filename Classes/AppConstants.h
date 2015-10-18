/*
 *  AppConstants.h
 *  EZTip
 *
 *  Created by Bijit Halder on 7/29/09.
 *  Copyright 2009 Indriam Inc. All rights reserved.
 *
 */

// Parameters
static const int kMaxDigitsForBillAmount = 5;
static const int kDefaultTipPercent = 16;
static const int kMinTipPercent = 0;
static const int kMaxTipPercent = 100;
static const int kDefaultNumberOfPeople = 1;
static const int kMinNumberOfPeople = 1;
static const int kMaxNumberOfPeople = 99;
static const int kRoundMode = 0;    // round for each , 1 round for all
static const float kEpsilon = 0.00; // adjustment for floor and ceil function in calculation

// button index table
static const int kButtonToValueTable[11] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0};

/* EZ Tip display parameters */
#define kNumberOfKeyPadButtons 12
#define kTipPercentAdjustButtons 2
#define kNumberOfPeopleAdjustButtons 2

// images
static NSString *const kEZTipViewBackGroundImage = @"EZTipBackGround.png";

// buttons
static NSString *const kKeyPadButtonsNormal1 = @"KeyPadButtonOneNormal.png";
static NSString *const kKeyPadButtonsHighlighted1 = @"KeyPadButtonOneHighlighted.png";
static NSString *const kKeyPadButtonsNormal2 = @"KeyPadButtonTwoNormal.png";
static NSString *const kKeyPadButtonsHighlighted2 = @"KeyPadButtonTwoHighlighted.png";
static NSString *const kKeyPadButtonsNormal3 = @"KeyPadButtonThreeNormal.png";
static NSString *const kKeyPadButtonsHighlighted3 = @"KeyPadButtonThreeHighlighted.png";
static NSString *const kKeyPadButtonsNormal4 = @"KeyPadButtonFourNormal.png";
static NSString *const kKeyPadButtonsHighlighted4 = @"KeyPadButtonFourHighlighted.png";
static NSString *const kKeyPadButtonsNormal5 = @"KeyPadButtongFiveNormal.png";
static NSString *const kKeyPadButtonsHighlighted5 = @"KeyPadButtonFiveHighlighted.png";
static NSString *const kKeyPadButtonsNormal6 = @"KeyPadButtonSixNormal.png";
static NSString *const kKeyPadButtonsHighlighted6 = @"KeyPadButtonSixHighlighted.png";
static NSString *const kKeyPadButtonsNormal7 = @"KeyPadButtonSevenNormal.png";
static NSString *const kKeyPadButtonsHighlighted7 = @"KeyPadButtonSevenHighlighted.png";
static NSString *const kKeyPadButtonsNormal8 = @"KeyPadButtonEightNormal.png";
static NSString *const kKeyPadButtonsHighlighted8 = @"KeyPadButtonEightHighlighted.png";
static NSString *const kKeyPadButtonsNormal9 = @"KeyPadButtonNineNormal.png";
static NSString *const kKeyPadButtonsHighlighted9 = @"KeyPadButtonNineHighlighted.png";
static NSString *const kKeyPadButtonsNormal10 = @"KeyPadButtonZeroNormal.png";
static NSString *const kKeyPadButtonsHighlighted10 = @"KeyPadButtonZeroHighlighted.png";
static NSString *const kKeyPadButtonsNormal11 = @"KeyPadButtonDotNormal.png";
static NSString *const kKeyPadButtonsHighlighted11 = @"KeyPadButtonDotHighlighted.png";
static NSString *const kKeyPadButtonsNormal12 = @"KeyPadButtonDelNormal.png";
static NSString *const kKeyPadButtonsHighlighted12 = @"KeyPadButtonDelHighlighted.png";

static NSString *const kTipPercentAdjustButtonIncreaseNormal = @"AdjustButtonIncreaseNormal.png";
static NSString *const kTipPercentAdjustButtonIncreaseHighlighted = @"AdjustButtonIncreaseHighlighted.png";
static NSString *const kTipPercentAdjustButtonDecreaseNormal = @"AdjustButtonDecreaseNormal.png";
static NSString *const kTipPercentAdjustButtonDecreaseHighlighted = @"AdjustButtonDecreaseHighlighted.png";
static NSString *const kNumberOfPeopleAdjustButtonIncreaseNormal = @"AdjustButtonIncreaseNormal.png";
static NSString *const kNumberOfPeopleAdjustButtonIncreaseHighlighted = @"AdjustButtonIncreaseHighlighted.png";
static NSString *const kNumberOfPeopleAdjustButtonDecreaseNormal = @"AdjustButtonDecreaseNormal.png";
static NSString *const kNumberOfPeopleAdjustButtonDecreaseHighlighted = @"AdjustButtonDecreaseHighlighted.png";

// layput parameters
static const float kDisplayCoordinate[7][4] = {{25.0, 20.0, 290.0, 60.0},
                                               {25.0, 90.0, 140.0, 60.0},
                                               {180.0, 90.0, 55.0, 60.0},
                                               {25.0, 155.0, 140.0, 60.0},
                                               {180.0, 155.0, 80.0, 60.0},
                                               {25.0, 220.0, 285.0, 60.0},
                                               {5.0, 270.0, 310.0, 30.0}};

static const float kButtonCoordinate[17][4] = {{5.0, 305.0, 70.0, 50.0},
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
                                               {5.0, 270.0, 310.0, 30.0}};

static const float kSwitchColor[4] = {150.0 / 255.0, 150.0 / 255.0, 150.0 / 255.0, 1.0};
static const float kCurrencySymbolFontSize[5] = {22.0, 14.0, 10.0, 6.0, 2.0};
static const float kCurrencySymbolFontSizeMain[5] = {26.0, 16.0, 10.0, 6.0, 2.0};

/* Persistancy related */
static NSString *const kAppStateFileName = @"appStateFileName.plist";
static NSString *const kKeyForAppState = @"appstate";
static NSString *const kKeyForBillAmount = @"billamount";
static NSString *const kKeyForTipPercent = @"tippercent";
static NSString *const kKeyForNumberOfPeople = @"numberofpeople";
static NSString *const kKeyForTipMethodIndex = @"tipmethodindex";

/* Debug related */
static const float floatkButtonColor = 1.0;
static const float floatkButtonOpacity = 1.0;
