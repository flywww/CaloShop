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
    
    orderList[@"fbID"] = [PFUser currentUser][@"fbID"];
    orderList[@"productID"] = reward[@"productID"];
    orderList[@"name"] = name;
    orderList[@"phone"] = phone;
    orderList[@"address"] = address;
    
    [self checkNetworkAndDoNext:^{
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
    }andFail:^{
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"訂單測試" andMessage:@"上傳失敗...."];
        
        [alertView addButtonWithTitle:@"OK"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alert) {}];
        [alertView show];
    }];
    
}

@end
