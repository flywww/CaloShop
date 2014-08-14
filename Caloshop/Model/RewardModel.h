//
//  RewardModel.h
//  Caloshop
//
//  Created by 林盈志 on 7/29/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@class RewardModel;
@protocol RewardModelDelegate<BasicModelDelegate>
@optional
//Fetch todays reward action
-(void)didFetchReward:(NSDictionary*)rewardDetail andProductDetail:(NSDictionary*)productDetail;
-(void)failToFetchReward:(NSError*)error;



//Coredata action
-(void)failToSaveRewardData:(NSError*)error;
-(void)didSavedRewardData;
@end

@interface RewardModel : BasicModel
@property(nonatomic,weak) id<RewardModelDelegate> delegate;


-(void)fetchReward:(NSDate*)date;


@end
