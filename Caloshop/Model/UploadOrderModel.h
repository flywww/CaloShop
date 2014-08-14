//
//  UploadOrderModel.h
//  Caloshop
//
//  Created by 林盈志 on 8/8/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@protocol UploadOrderModelDelegate <BasicModelDelegate>

@optional
-(void)didUploadOrder;
-(void)failToUploadOrderWithError:(NSError*)error;

@end


@interface UploadOrderModel : BasicModel

@property (nonatomic,weak) id<UploadOrderModelDelegate> delegate;


-(void)uploadOlderWithName:(NSString *)name andPhone:(NSString *)phone andAddress:(NSString *)address andReward:(NSDictionary*)reward;
-(NSString*)checkInfoWithName:(NSString*)name andPhone:(NSString*)phone andAddress:(NSString*)address;
-(void)autoFillProfile;

@end
