//
//  AppUIManager.h
//  EZTip
//
//  Created by Bijit Halder on 10/18/15.
//
//

#import <Foundation/Foundation.h>

@interface AppUIManager : NSObject

+ (NSParagraphStyle *)getParagrahStyleWithLineBreakMode:(NSLineBreakMode *)lineBreak
                                       andTextAlignment:(NSTextAlignment *)textAlignment;

@end
