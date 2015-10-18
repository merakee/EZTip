//
//  AppUIManager.m
//  EZTip
//
//  Created by Bijit Halder on 10/18/15.
//
//

#import "AppUIManager.h"

@implementation AppUIManager

+ (NSParagraphStyle *)getParagrahStyleWithLineBreakMode:(NSLineBreakMode *)lineBreak
                                       andTextAlignment:(NSTextAlignment *)textAlignment {
    NSMutableParagraphStyle *pStyle = [NSMutableParagraphStyle new];
    pStyle.lineBreakMode = lineBreak;
    pStyle.alignment = textAlignment;
    return pStyle;
}
@end
