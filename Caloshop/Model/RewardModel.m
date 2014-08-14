//
//  RewardModel.m
//  Caloshop
//
//  Created by 林盈志 on 7/29/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "RewardModel.h"

@implementation RewardModel

#pragma mark - Fetch reward

-(void)fetchReward:(NSDate*)date
{
    [self checkNetworkAndDoNext:^
    {
        
            //Find today's reward
            PFQuery* rewardQuery = [PFQuery queryWithClassName:@"Reward"];
            [rewardQuery whereKey:@"rewardDate" greaterThanOrEqualTo:date];
            [rewardQuery whereKey:@"rewardDate" lessThan:[[NSDate alloc] initWithTimeInterval:24*60*60 sinceDate:date]];
            NSMutableDictionary* rewardResult = [rewardQuery findObjects][0];
            
            //Find reward's product today
            PFQuery* productQuery = [PFQuery queryWithClassName:@"Product"];
            [productQuery whereKey:@"productID" equalTo:[rewardResult[@"productID"] stringValue]];
            NSMutableDictionary* productResult = [productQuery findObjects][0];
            
            if ([self.delegate respondsToSelector:@selector(didFetchReward:andProductDetail:)])
            {
                [self.delegate didFetchReward:rewardResult andProductDetail:productResult];
            }
            else
            {
                NSLog(@"Sucseed fetch today's reward : %@ and product : %@", rewardResult, productResult);
            }
    
    }
    andFail:^
    {
        if ([self.delegate respondsToSelector:@selector(failToFetchReward:)])
        {
             NSError* error = [[NSError alloc]initWithDomain:@"Network failed" code:0 userInfo:nil];
            [self.delegate failToFetchReward:error];
        }
        else
        {
            NSLog(@"fail to fetch to days because network failed");
        }
        
    }];
}

-(BOOL)isTodaysRewardGet
{
    Reward* reward =[Reward MR_findFirstOrderedByAttribute:@"rewardDate" ascending:NO];
    
    if (reward.rewardDate != NULL)
    {
        return [[HelpTool getLocalDateWithOutTime:reward.rewardDate] isEqualToDate: [HelpTool getLocalDateWithOutTime]];
    }
    else
    {
        return NO;
    }
}

-(void)cleanOldRewardData
{
    NSArray* rewardArray = [Reward MR_findAllSortedBy:@"rewardDate" ascending:NO];
    if ([Reward MR_countOfEntities]>7)
    {
        for (int i=8; i<=[Reward MR_countOfEntities]; i++)
        {
            [rewardArray[i] MR_deleteEntity];
        }
    }
}


-(NSInteger)transformParseDateToNumber:(NSString*)date
{
    return [[[date stringByReplacingOccurrencesOfString:@"-" withString:@""]substringToIndex:8] intValue];
}



#pragma mark - reward coredata

-(void)saveNewRewardWithRewardData:(NSDictionary*)rewardData andProductData:(NSDictionary*)productData
{
   // NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_contextForCurrentThread];
    
    Reward* reward = [Reward MR_createEntity];
    PFFile* file = [[PFFile alloc]init];
    
    
    
    NSLog(@"~~~~~~~~~~~~~%@",productData[@"describe1"]);
    NSLog(@"~~~~~~~~~~~~~%@",productData);
    if (productData[@"name"])        {reward.productName  =  productData[@"name"];              }
    if (productData[@"price"])       {reward.price        =  productData[@"price"];             }
    if (productData[@"pureImage"])   {reward.pureImage    = [productData[@"pureImage"] getData];}
    if (productData[@"mainImage"])   {reward.mainImage    = [productData[@"mainImage"] getData];}
    if (productData[@"mainDescribe"]){reward.mainDescribe =  productData[@"mainDescribe"];      }
    if (productData[@"image1"])      {reward.image1       = [productData[@"image1"] getData];   }
    if (productData[@"image2"])      {reward.image2       = [productData[@"image2"] getData];   }
    if (productData[@"image3"])      {reward.image3       = [productData[@"image3"] getData];   }
    if (productData[@"image4"])      {reward.image4       = [productData[@"image4"] getData];   }
    if (productData[@"image5"])      {reward.image5       = [productData[@"image5"] getData];   }
    if (productData[@"describe1"])   {reward.describe1    =  productData[@"describe1"];         }
    if (productData[@"describe2"])   {reward.describe2    =  productData[@"describe2"];         }
    if (productData[@"describe3"])   {reward.describe3    =  productData[@"describe3"];         }
    if (productData[@"describe4"])   {reward.describe4    =  productData[@"describe4"];         }
    if (productData[@"describe5"])   {reward.describe5    =  productData[@"describe5"];         }
    if (rewardData[@"rewardGoal"])   {reward.rewardGoal   =  rewardData[@"rewardGoal"];         }
    if (rewardData[@"rewardPrice"])  {reward.rewardPrice  =  rewardData[@"rewardPrice"];        }
    if (rewardData[@"rewardDate"])   {reward.rewardDate   =  rewardData[@"rewardDate"];         }
    if (rewardData[@"rewardTitle"])  {reward.rewardTitle  =  rewardData[@"rewardTitle"];        }
    if (rewardData[@"rewardID"])     {reward.rewardID     =  rewardData[@"rewardID"];           }
    

    
    NSLog(@"=============================");
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error)
    {
        NSLog(@"coredata success?%d, coredata error %@",success,error);
        
        if (!error)
        {
            if ([self.delegate respondsToSelector:@selector(didSavedRewardData)])
            {
                [self.delegate didSavedRewardData];
                NSLog(@"coredata reward data show: %@",[Reward MR_findAll]);
                NSLog(@"Reward entities count - %lu",[Reward MR_countOfEntities]);
            }
            else
            {
                NSLog(@"coredata reward data show: %@",[Reward MR_findAll]);
                NSLog(@"did Saved Reward Data");
            }
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(failToSaveRewardData:)])
            {
                [self.delegate failToSaveRewardData:error];
            }
            else
            {
                NSLog(@"fail To Save Reward Data");
            }
        }

    }];
}

#pragma mark - Upload order list


@end
