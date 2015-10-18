//
//  EZTipViewController.m
//  EZTip
//
//  Created by Bijit Halder on 7/29/09.
//  Copyright 2009 Indriam Inc. All rights reserved.
//

#import "EZTipViewController.h"

@implementation EZTipViewController

@synthesize ezTipQuartzView;

// local variables
// app delegate
id mainAppDelegate;

// app state variables
int appState;
float billAmount;
int tipPercent;
int numberOfPeople;
int tipMethodIndex;
NSNumber *tempNSNumberVC;
NSString *AppStateFilePath;
NSMutableString *billAmountMS;
NSString *currencySymbol;

// temp variable
int numberOfDigits;
int numberOfFracDigits;
NSString *tempString;
CGRect tempRect;

#pragma mark Core View Controller Methods
// init method
- (id)initWithAppDelegate:(id)appDelegate {
    if (self = [super init]) {
        // intialize variable
        billAmountMS = [[NSMutableString alloc] initWithString:@""];
        // set app Delegate
        mainAppDelegate = appDelegate;
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];

    // window size
    CGRect bounds = [[UIScreen mainScreen] bounds];
    ezTipBackGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kEZTipViewBackGroundImage]];
    ezTipQuartzView = [[EZTipQuartzView alloc] initWithFrame:bounds];
    ezTipQuartzView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];

    // set all buttons
    [self setAllButtons];

    // attach backgorund image
    [self.view addSubview:ezTipBackGroundImageView];
    [ezTipBackGroundImageView release];

    // attach the Main Quartz view
    [self.view addSubview:ezTipQuartzView];
    [ezTipQuartzView release];

    // attach the button views
    [self attachAllButtons];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

// Implement viewWillAppear method for setting up the dsiplay
- (void)viewWillAppear:(BOOL)animated {
    // load parameters
    [self getAppState];

    // set currency symbol
    tempString =
        [[NSString alloc] initWithFormat:@"%@", [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]];
    if ([tempString isEqualToString:@""]) {
        currencySymbol = [[NSString alloc] initWithString:@"$"];
    } else {
        currencySymbol = [[NSString alloc] initWithString:tempString];
    }
    // NSLog(@"%@    TS: %@",currencySymbol,tempString);
    [tempString release];

    // set tio method swich
    tipMethodControlSwitch.selectedSegmentIndex = tipMethodIndex;

    // set all parameters
    [self refreshDisplay];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self saveAppState];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) ||
            (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
}

- (void)dealloc {
    // buttons
    for (int ind = 0; ind < kNumberOfKeyPadButtons; ind++) {
        [keyPadButtons[ind] release];
    }

    for (int ind = 0; ind < kTipPercentAdjustButtons; ind++) {
        [tipPercentAdjustButtons[ind] release];
    }

    for (int ind = 0; ind < kNumberOfPeopleAdjustButtons; ind++) {
        [numberOfPeopleAdjustButtons[ind] release];
    }
    [tipMethodControlSwitch release];

    // views
    [ezTipBackGroundImageView release];
    [ezTipQuartzView release];

    // variables
    [billAmountMS release];
    [currencySymbol release];

    [super dealloc];
}

#pragma mark Local Methods
- (void)setAllButtons {
    int buttonIndex = 0;
    // Create all key pad buttons
    for (int ind = 0; ind < kNumberOfKeyPadButtons; ind++) {
        keyPadButtons[ind] = [UIButton buttonWithType:UIButtonTypeCustom];
        keyPadButtons[ind].tag = buttonIndex + 1;
        tempString = [[NSString alloc] initWithFormat:@"KeyPadButton%dNormal.png", ind + 1];
        [keyPadButtons[ind] setImage:[UIImage imageNamed:tempString] forState:UIControlStateNormal];
        [tempString release];
        tempString = [[NSString alloc] initWithFormat:@"KeyPadButton%dHighlighted.png", ind + 1];
        [keyPadButtons[ind] setImage:[UIImage imageNamed:tempString] forState:UIControlStateHighlighted];
        [tempString release];
        // keyPadButtons[ind].backgroundColor = [UIColor colorWithWhite:kButtonColor alpha:kButtonOpacity];
        tempRect = CGRectMake(kButtonCoordinate[buttonIndex][0], kButtonCoordinate[buttonIndex][1],
                              kButtonCoordinate[buttonIndex][2], kButtonCoordinate[buttonIndex][3]);
        keyPadButtons[ind].frame = tempRect;
        [keyPadButtons[ind] setTitle:@"" forState:UIControlStateNormal];
        [keyPadButtons[ind] addTarget:self
                               action:@selector(keyPadButtonPressed:)
                     forControlEvents:UIControlEventTouchUpInside];
        buttonIndex++;
    }

    // Create all tip percent adjuest buttons
    for (int ind = 0; ind < kTipPercentAdjustButtons; ind++) {
        tipPercentAdjustButtons[ind] = [UIButton buttonWithType:UIButtonTypeCustom];
        tipPercentAdjustButtons[ind].tag = buttonIndex + 1;
        if (ind == 0) {
            [tipPercentAdjustButtons[ind] setImage:[UIImage imageNamed:kTipPercentAdjustButtonIncreaseNormal]
                                          forState:UIControlStateNormal];
            [tipPercentAdjustButtons[ind] setImage:[UIImage imageNamed:kTipPercentAdjustButtonIncreaseHighlighted]
                                          forState:UIControlStateHighlighted];
        } else {
            [tipPercentAdjustButtons[ind] setImage:[UIImage imageNamed:kTipPercentAdjustButtonDecreaseNormal]
                                          forState:UIControlStateNormal];
            [tipPercentAdjustButtons[ind] setImage:[UIImage imageNamed:kTipPercentAdjustButtonDecreaseHighlighted]
                                          forState:UIControlStateHighlighted];
        }

        tempRect = CGRectMake(kButtonCoordinate[buttonIndex][0], kButtonCoordinate[buttonIndex][1],
                              kButtonCoordinate[buttonIndex][2], kButtonCoordinate[buttonIndex][3]);
        tipPercentAdjustButtons[ind].frame = tempRect;
        [tipPercentAdjustButtons[ind] setTitle:@"" forState:UIControlStateNormal];
        buttonIndex++;
    }
    // add action
    [tipPercentAdjustButtons[0] addTarget:self
                                   action:@selector(increaseTipPercent:)
                         forControlEvents:UIControlEventTouchUpInside];
    [tipPercentAdjustButtons[1] addTarget:self
                                   action:@selector(decreaseTipPercent:)
                         forControlEvents:UIControlEventTouchUpInside];

    // Create all number of people adjuest buttons
    for (int ind = 0; ind < kTipPercentAdjustButtons; ind++) {
        numberOfPeopleAdjustButtons[ind] = [UIButton buttonWithType:UIButtonTypeCustom];
        numberOfPeopleAdjustButtons[ind].tag = buttonIndex + 1;
        if (ind == 0) {
            [numberOfPeopleAdjustButtons[ind] setImage:[UIImage imageNamed:kNumberOfPeopleAdjustButtonIncreaseNormal]
                                              forState:UIControlStateNormal];
            [numberOfPeopleAdjustButtons[ind]
                setImage:[UIImage imageNamed:kNumberOfPeopleAdjustButtonIncreaseHighlighted]
                forState:UIControlStateHighlighted];
        } else {
            [numberOfPeopleAdjustButtons[ind] setImage:[UIImage imageNamed:kNumberOfPeopleAdjustButtonDecreaseNormal]
                                              forState:UIControlStateNormal];
            [numberOfPeopleAdjustButtons[ind]
                setImage:[UIImage imageNamed:kNumberOfPeopleAdjustButtonDecreaseHighlighted]
                forState:UIControlStateHighlighted];
        }

        tempRect = CGRectMake(kButtonCoordinate[buttonIndex][0], kButtonCoordinate[buttonIndex][1],
                              kButtonCoordinate[buttonIndex][2], kButtonCoordinate[buttonIndex][3]);
        numberOfPeopleAdjustButtons[ind].frame = tempRect;
        [numberOfPeopleAdjustButtons[ind] setTitle:@"" forState:UIControlStateNormal];
        buttonIndex++;
    }
    // add action
    [numberOfPeopleAdjustButtons[0] addTarget:self
                                       action:@selector(increaseNumberOfPeople:)
                             forControlEvents:UIControlEventTouchUpInside];
    [numberOfPeopleAdjustButtons[1] addTarget:self
                                       action:@selector(decreaseNumberOfPeople:)
                             forControlEvents:UIControlEventTouchUpInside];

    // Tip Method segmented control
    tipMethodControlSwitch = [[UISegmentedControl alloc] initWithItems:nil];
    tipMethodControlSwitch.frame = CGRectMake(kButtonCoordinate[buttonIndex][0], kButtonCoordinate[buttonIndex][1],
                                              kButtonCoordinate[buttonIndex][2], kButtonCoordinate[buttonIndex][3]);

    tipMethodControlSwitch.segmentedControlStyle = UISegmentedControlStyleBar;
    tipMethodControlSwitch.tintColor =
        [UIColor colorWithRed:kSwitchColor[0] green:kSwitchColor[1] blue:kSwitchColor[2] alpha:kSwitchColor[3]];
    [tipMethodControlSwitch insertSegmentWithTitle:@"Exact" atIndex:0 animated:NO];
    [tipMethodControlSwitch setWidth:80.0 forSegmentAtIndex:0];
    [tipMethodControlSwitch insertSegmentWithTitle:@"Round Tip" atIndex:1 animated:NO];
    [tipMethodControlSwitch setWidth:115.0 forSegmentAtIndex:1];
    [tipMethodControlSwitch insertSegmentWithTitle:@"Round Total" atIndex:2 animated:NO];
    [tipMethodControlSwitch setWidth:115.0 forSegmentAtIndex:2];
    tipMethodControlSwitch.selectedSegmentIndex = tipMethodIndex;
    [tipMethodControlSwitch addTarget:self
                               action:@selector(tipMethodControlSwitchPressed:)
                     forControlEvents:UIControlEventValueChanged];
    NSLog(@"%s -> %d", __PRETTY_FUNCTION__, __LINE__);
}

- (void)attachAllButtons {
    // attached all key pad buttons
    for (int ind = 0; ind < kNumberOfKeyPadButtons; ind++) {
        [self.view addSubview:keyPadButtons[ind]];
    }

    // attached all tip percent adjust buttons
    for (int ind = 0; ind < kTipPercentAdjustButtons; ind++) {
        [self.view addSubview:tipPercentAdjustButtons[ind]];
    }

    // attach all number of people adjuest buttons
    for (int ind = 0; ind < kNumberOfPeopleAdjustButtons; ind++) {
        [self.view addSubview:numberOfPeopleAdjustButtons[ind]];
    }

    // attach Tip Method segmented control
    [self.view addSubview:tipMethodControlSwitch];
}

- (void)refreshDisplay {

    // NSLog(@"Bill: %.2f, Tip Per:%d%%, number of Peple: %d\n",billAmount,tipPercent,numberOfPeople);
    // calculate paramters
    float totalTip = round(billAmount * tipPercent) / 100.0;
    float totalBillAmout, totalEachAmount;
    float tipEach;
    // NSLog(@"BA: %f, TP: %d, TT: %f",billAmount,tipPercent,totalTip);

    if (kRoundMode == 0) {
        //=========== Round each ========================
        if (tipMethodIndex == 0) {

            // total each and total bill
            if (numberOfPeople == 1) {
                tipEach = totalTip;
                totalEachAmount = tipEach + billAmount;
            } else {
                tipEach = round(100.0 * (totalTip / numberOfPeople)) / 100.0;
                totalEachAmount = tipEach + ceil(100.0 * (billAmount / numberOfPeople)) / 100.0;
            }

            totalTip = tipEach * numberOfPeople;
            totalBillAmout = totalEachAmount * numberOfPeople;

            // NSLog(@"BA: %f, TP: %d, TT: %f, TE: %f, TEA: %f, TB:
            // %f",billAmount,tipPercent,totalTip,tipEach,totalEachAmount, totalBillAmout);
        } else if (tipMethodIndex == 1) {
            tipEach = round(totalTip / numberOfPeople);

            if (tipEach <= 0) {
                tipEach = ceil(totalTip / numberOfPeople);
            }

            // total each and total bill
            if (numberOfPeople == 1) {
                totalEachAmount = tipEach + billAmount;
            } else {
                totalEachAmount = tipEach + ceil(100.0 * (billAmount / numberOfPeople)) / 100.0;
            }
            totalTip = tipEach * numberOfPeople;
            totalBillAmout = totalEachAmount * numberOfPeople;
        } else if (tipMethodIndex == 2) {
            totalEachAmount = round((billAmount + totalTip) / numberOfPeople);
            tipEach = totalEachAmount - round(100.0 * (billAmount / numberOfPeople)) / 100.0;

            if ((totalEachAmount <= 0) || (tipEach <= 0.0)) {
                totalEachAmount = ceil((billAmount + totalTip) / numberOfPeople);
            }
            if (numberOfPeople == 1) {
                tipEach = totalEachAmount - billAmount;
            } else {
                tipEach = totalEachAmount - round(100.0 * (billAmount / numberOfPeople) + kEpsilon) / 100.0;
            }

            // total each and total bill
            totalTip = tipEach * numberOfPeople;
            totalBillAmout = totalEachAmount * numberOfPeople;
        }
    }
    //=========== Round ALL ========================
    else {
        if (tipMethodIndex == 0) {
            tipEach = ceil(100.0 * totalTip / numberOfPeople) / 100.0;

            // total each and total bill
            totalEachAmount = ceil((tipEach + (billAmount / numberOfPeople)) * 100.0) / 100.0;
            totalTip = tipEach * numberOfPeople;
            totalBillAmout = totalEachAmount * numberOfPeople;
        } else if (tipMethodIndex == 1) { // round tip
            totalTip = round(totalTip);
            if (totalTip <= 0) {
                totalTip = ceil(totalTip);
            }
            tipEach = round(100.0 * totalTip / numberOfPeople) / 100.0;

            // total each and total bill
            totalEachAmount = round((tipEach + (billAmount / numberOfPeople)) * 100.0) / 100.0;
            totalBillAmout = round(100.0 * totalEachAmount * numberOfPeople) / 100.0;

        } else if (tipMethodIndex == 2) {
            totalBillAmout = round(billAmount + totalTip);

            if ((totalBillAmout <= 0.0) || (totalBillAmout <= billAmount)) {
                totalBillAmout = ceil(billAmount + totalTip);
            }

            // total each and total bill
            totalEachAmount = round(100.0 * (totalBillAmout / numberOfPeople)) / 100.0;
            totalTip = totalBillAmout - billAmount;
            tipEach = round(100.0 * totalTip / numberOfPeople) / 100.0;
        }
    }

    // non zero values
    billAmount = (billAmount < 0.0) ? 0.0 : billAmount;
    tipEach = (tipEach < 0.0) ? 0.0 : tipEach;
    totalEachAmount = (totalEachAmount < 0.0) ? 0.0 : totalEachAmount;
    totalTip = (totalTip < 0.0) ? 0.0 : totalTip;
    totalBillAmout = (totalBillAmout < 0.0) ? 0.0 : totalBillAmout;
    //==============================================

    // set parameters
    ezTipQuartzView.billAmountTextQV = billAmountMS;

    tempNSNumberVC = [[NSNumber alloc] initWithInt:tipPercent];
    ezTipQuartzView.tipPercentQV = tempNSNumberVC;
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithFloat:tipEach];
    ezTipQuartzView.tipAmountQV = tempNSNumberVC;
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithInt:numberOfPeople];
    ezTipQuartzView.numberOfPeopleQV = tempNSNumberVC;
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithFloat:totalEachAmount];
    ezTipQuartzView.totalAmountQV = tempNSNumberVC;
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithFloat:totalBillAmout];
    ezTipQuartzView.totalBillAmountQV = tempNSNumberVC;
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithFloat:totalTip];
    ezTipQuartzView.totalTipAmountQV = tempNSNumberVC;
    [tempNSNumberVC release];

    ezTipQuartzView.currencySymbolQV = currencySymbol;

    // set display
    [ezTipQuartzView setNeedsDisplay];
}
- (void)setParametersForDigits {
    float tempBillAmount;
    tempBillAmount = floor(billAmount);
    int tempBillAmountFrac = round(100 * (billAmount - tempBillAmount));
    billAmount = tempBillAmount + ((float)tempBillAmountFrac) / 100.0;
    billAmount = round(billAmount * 100.0) / 100.0;

    // fractional part
    if (tempBillAmountFrac > 0) {
        if (fmod(tempBillAmountFrac, 10) == 0) {
            numberOfFracDigits = 1;
        } else {
            numberOfFracDigits = 2;
        }
    } else {
        numberOfFracDigits = -1;
    }

    // NSLog(@"Bill amount: %.2f, int amount: %f, frac amount: %d",billAmount, tempBillAmount,tempBillAmountFrac);

    // integer part
    numberOfDigits = 0;
    for (int ind = 0; ind < kMaxDigitsForBillAmount; ind++) {
        if (tempBillAmount > 0) {
            numberOfDigits++;
        } else {
            break;
        }
        tempBillAmount = floor(tempBillAmount / 10.0);
    }

    // set string
    if ((numberOfDigits > 0) || (numberOfFracDigits > 0)) {
        tempNSNumberVC = [[NSNumber alloc] initWithFloat:billAmount];
        [billAmountMS setString:[tempNSNumberVC stringValue]];
        [tempNSNumberVC release];

        if (numberOfDigits == 0) {
            numberOfDigits = 1;
        }
        if (numberOfFracDigits == 1) {
            numberOfFracDigits = 2;
            [billAmountMS appendString:@"0"];
        }
    } else {
        [billAmountMS setString:@""];
    }

    // NSLog(@"Sring:%@ Bill Amount: %f (digits: %d, decimal Location:
    // %d)\n",billAmountMS,billAmount,numberOfDigits,numberOfFracDigits);
}

#pragma mark Action Methods
- (void)keyPadButtonPressed:(id)sender {
    int buttonIndex = (int)[sender tag];
    int buttonValue = kButtonToValueTable[buttonIndex];
    int preRoundedValue;
    NSRange lastIndex;

    // update AppState
    [self updateAppStateTo:0];

    // take action on key pad button
    if (buttonIndex <= 10) {
        if ((numberOfFracDigits == 1) || (numberOfFracDigits == 0)) { // check if fractional
            numberOfFracDigits++;
            tempNSNumberVC = [[NSNumber alloc] initWithInt:buttonValue];
            [billAmountMS appendString:[tempNSNumberVC stringValue]];
            [tempNSNumberVC release];
        } else if (numberOfFracDigits < 0) { // integer part
            if (numberOfDigits < kMaxDigitsForBillAmount) {
                numberOfDigits++;
                tempNSNumberVC = [[NSNumber alloc] initWithInt:buttonValue];
                [billAmountMS appendString:[tempNSNumberVC stringValue]];
                [tempNSNumberVC release];
            }
        }
    } else if (buttonIndex == 11) {
        if (numberOfFracDigits < 0) {
            numberOfFracDigits = 0;
            [billAmountMS appendString:@"."];
        }
    } else if (buttonIndex == 12) {
        if ((numberOfFracDigits <= 2) && (numberOfFracDigits >= 0)) { // check if fractional
            numberOfFracDigits--;
            lastIndex = NSMakeRange([billAmountMS length] - 1, 1);
            [billAmountMS deleteCharactersInRange:lastIndex];
        } else if (numberOfFracDigits < 0) { // integer part
            if (numberOfDigits > 0) {
                numberOfDigits--;
                lastIndex = NSMakeRange([billAmountMS length] - 1, 1);
                [billAmountMS deleteCharactersInRange:lastIndex];
            }
        }
    }

    // calculate bill amount
    billAmount = [billAmountMS floatValue];
    preRoundedValue = (int)round(billAmount * 100.0);
    // NSLog(@"%@ - %f - RV %d",billAmountMS,billAmount,preRoundedValue);

    billAmount = ((float)preRoundedValue) / 100.0;
    // NSLog(@"NBP: Bill Amount: %.3f (digits: %d, fractional digits:
    // %d)\n",billAmount,numberOfDigits,numberOfFracDigits);
    // display new amount
    [self refreshDisplay];
}

- (void)increaseTipPercent:(id)sender {
    [self updateAppStateTo:1];
    tipPercent = (tipPercent < kMaxTipPercent) ? (tipPercent + 1) : kMaxTipPercent;
    [self refreshDisplay];
}

- (void)decreaseTipPercent:(id)sender {
    [self updateAppStateTo:1];
    tipPercent = (tipPercent > kMinTipPercent) ? (tipPercent - 1) : kMinTipPercent;
    [self refreshDisplay];
}
- (void)increaseNumberOfPeople:(id)sender {
    [self updateAppStateTo:1];
    numberOfPeople = (numberOfPeople < kMaxNumberOfPeople) ? (numberOfPeople + 1) : kMaxNumberOfPeople;
    [self refreshDisplay];
}

- (void)decreaseNumberOfPeople:(id)sender {
    [self updateAppStateTo:1];
    numberOfPeople = (numberOfPeople > kMinNumberOfPeople) ? (numberOfPeople - 1) : kMinNumberOfPeople;
    [self refreshDisplay];
}
- (void)tipMethodControlSwitchPressed:(id)sender {
    [self updateAppStateTo:1];
    tipMethodIndex = (int)[sender selectedSegmentIndex];
    [self refreshDisplay];
}

- (void)updateAppStateTo:(int)state {
    //	NSLog(@"App state: %d, Requested State: %d",appState,state);

    if ((appState == 0) && (state == 1)) {
        [self setParametersForDigits];
        appState = 1;
    } else if ((appState == 1) && (state == 0)) {
        billAmount = 0.0;
        [self setParametersForDigits];
        appState = 0;
    }
}

#pragma mark Persistance Methods
- (void)getAppState {
    AppStateFilePath = [self appStateFilePath];

    if ([[NSFileManager defaultManager] fileExistsAtPath:AppStateFilePath]) {
        NSDictionary *appStateDictionary = [[NSDictionary alloc] initWithContentsOfFile:AppStateFilePath];
        appState = [[appStateDictionary objectForKey:kKeyForAppState] intValue];
        billAmount = [[appStateDictionary objectForKey:kKeyForBillAmount] floatValue];
        // NSLog(@"GBA:......%.3f",billAmount);
        tipPercent = [[appStateDictionary objectForKey:kKeyForTipPercent] intValue];
        numberOfPeople = [[appStateDictionary objectForKey:kKeyForNumberOfPeople] intValue];
        tipMethodIndex = [[appStateDictionary objectForKey:kKeyForTipMethodIndex] intValue];
        [appStateDictionary release];
    } else // start with default state
    {
        appState = 0;
        billAmount = 0.0;
        tipPercent = 16;
        numberOfPeople = 1;
        tipMethodIndex = 0;
        // save the default app state
        [self saveAppState];
    }

    // check parameters
    tipPercent = (tipPercent < kMinTipPercent) ? kDefaultTipPercent : tipPercent;
    tipPercent = (tipPercent > kMaxTipPercent) ? kDefaultTipPercent : tipPercent;
    numberOfPeople = (numberOfPeople < kMinNumberOfPeople) ? kDefaultNumberOfPeople : numberOfPeople;
    numberOfPeople = (numberOfPeople > kMaxNumberOfPeople) ? kDefaultNumberOfPeople : numberOfPeople;

    // set number of digit and decimal location
    [self setParametersForDigits];
}

// save App State
- (void)saveAppState {
    // set directory data
    AppStateFilePath = [self appStateFilePath];
    NSMutableDictionary *AppStateDictionaryMu = [[NSMutableDictionary alloc] init];
    tempNSNumberVC = [[NSNumber alloc] initWithFloat:billAmount];
    // NSLog(@"BA:......%.3f",billAmount);
    [AppStateDictionaryMu setObject:tempNSNumberVC forKey:kKeyForBillAmount];
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithInt:tipPercent];
    [AppStateDictionaryMu setObject:tempNSNumberVC forKey:kKeyForTipPercent];
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithInt:numberOfPeople];
    [AppStateDictionaryMu setObject:tempNSNumberVC forKey:kKeyForNumberOfPeople];
    [tempNSNumberVC release];

    tempNSNumberVC = [[NSNumber alloc] initWithInt:tipMethodIndex];
    [AppStateDictionaryMu setObject:tempNSNumberVC forKey:kKeyForTipMethodIndex];
    [tempNSNumberVC release];

    // write file
    [AppStateDictionaryMu writeToFile:AppStateFilePath atomically:YES];

    // release all objects
    [AppStateDictionaryMu release];
}

// Implement App State FilePath
- (NSString *)appStateFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kAppStateFileName];
}

@end
