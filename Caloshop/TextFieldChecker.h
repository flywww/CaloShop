//
//  TextFieldChecker.h
//  Caloshop
//
//  Created by 林盈志 on 9/9/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldChecker : NSObject

+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validatePhone:(NSString *)phone;
+ (BOOL)isEmpty:(UITextField *)textFiled;

@end
