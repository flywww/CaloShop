//
//  TextFieldChecker.m
//  Caloshop
//
//  Created by 林盈志 on 9/9/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "TextFieldChecker.h"

@implementation TextFieldChecker

+(BOOL)validateEmail:(NSString *)email
{
    
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
    return YES;
}

+ (BOOL)validatePhone:(NSString *)phone
{
    return YES;
}

+(BOOL)isEmpty:(UITextField *)textFiled;
{
    if (([textFiled.text isEqual:@""])||([textFiled.text isEqual:nil]))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
