//
//  HelpTool.m
//  Caloshop
//
//  Created by 林盈志 on 7/30/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "HelpTool.h"

@implementation HelpTool

//String operation
+(NSString*)trimeEndandHeadWhiteSpace:(NSString*)string
{
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return trimmedString;
}



//Date Operation(ps: the date automatic transform to local time)
+(NSInteger)transformNSDateToNumber:(NSDate*)date
{
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //NSLog(@"dateString = %d",[dateString intValue]);
    return [dateString integerValue];
}

+(NSDate*)getLocalDate
{
    NSDate* date = [[NSDate alloc]init];
    NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    return localDate;
}

+(NSString*)getStringLocalDateWithoutTime
{
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];;
}

+(NSString*)transDateToStringWithDate:(NSDate*)date andFormate:(NSString*)formate
{
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter stringFromDate:date];
}


+(NSDate *)getLocalDateWithOutTime:(NSDate*)date
{
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    
    [comps setHour:00];
    [comps setMinute:00];
    [comps setSecond:00];
    [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+(NSDate *)getLocalDateWithOutTime
{
    
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:[NSDate date]];
    
    [comps setHour:00];
    [comps setMinute:00];
    [comps setSecond:00];
    [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}



@end
