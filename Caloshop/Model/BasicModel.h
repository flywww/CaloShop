//
//  BasicModel.h
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"

typedef void (^NextBlock)();
typedef void (^FailBlock)();

@protocol BasicModelDelegate <NSObject>

@optional
-(void)networkFail;





@end


@interface BasicModel : NSObject


@property (nonatomic) UserLog* userLog;

@property (nonatomic,weak) id<BasicModelDelegate> delegate;
-(void)checkNetworkAndDoNext:(NextBlock)next;
-(void)checkNetworkAndDoNext:(NextBlock)next andFail:(FailBlock)fail;




/*
 (NSString*)FBID andfbname:(NSString*)FBName andUerName:(NSString*)username andBirthday:(NSString*)Birthday andGender:(NSString*)gender andEmail:(NSString*)email andName:(NSString*)name andHeight:(NSString*)height amdWeight:(NSString*)weight andAddress:(NSString*)address andAvatar:(NSData*)avatar;
 */

@end
