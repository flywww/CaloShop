//
//  UploadOrderModel.m
//  Caloshop
//
//  Created by 林盈志 on 8/8/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "UploadOrderModel.h"

@implementation UploadOrderModel


-(void)uploadOlderWithName:(NSString *)name andPhone:(NSString *)phone andAddress:(NSString *)address andReward:(NSDictionary *)reward
{
    PFObject* orderList = [PFObject objectWithClassName:@"OrderList"];
    
    orderList[@"fbID"] = reward[@"fbID"];
    orderList[@"productID"] = reward[@"productID"];
    orderList[@"name"] = name;
    orderList[@"phone"] = phone;
    orderList[@"address"] = address;
    
    [orderList saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
     
        if (!error)
        {
            
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"訂單測試" andMessage:@"上傳成功"];
            
            [alertView addButtonWithTitle:@"OK"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alert) {}];
            [alertView show];
        }
        else
        {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"訂單測試" andMessage:@"上傳失敗...."];
            
            [alertView addButtonWithTitle:@"OK"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alert) {}];
            [alertView show];
        }
        
        
    }];
    
}

-(NSString*)checkInfoWithName:(NSString *)name andPhone:(NSString *)phone andAddress:(NSString *)address
{
    if ((name == nil)|(phone == nil)|(address == nil))
    {
        return @"資料必須填寫完整喔！！";
    }
    else
    {
        return @"OK";
    }
}

-(void)autoFillProfile
{
    
    
    
    
}
@end
