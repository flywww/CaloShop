//
//  HelpTool.h
//  Caloshop
//
//  Created by 林盈志 on 7/30/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpTool : NSObject

//String
+(NSString*)trimeEndandHeadWhiteSpace:(NSString*)string;

//Date
+(NSInteger)transformNSDateToNumber:(NSDate*)date;
+(NSDate*)getLocalDate;
+(NSString*)getStringLocalDateWithoutTime;
+(NSDate *)getLocalDateWithOutTime:(NSDate*)date;
+(NSDate *)getLocalDateWithOutTime;
+(NSString*)transDateToStringWithDate:(NSDate*)date andFormate:(NSString*)formate;

@end
