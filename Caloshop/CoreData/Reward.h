//
//  Reward.h
//  Caloshop
//
//  Created by 林盈志 on 7/30/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reward : NSManagedObject

@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSData * pureImage;
@property (nonatomic, retain) NSData * mainImage;
@property (nonatomic, retain) NSString * mainDescribe;
@property (nonatomic, retain) NSData * image1;
@property (nonatomic, retain) NSData * image2;
@property (nonatomic, retain) NSData * image3;
@property (nonatomic, retain) NSData * image4;
@property (nonatomic, retain) NSData * image5;
@property (nonatomic, retain) NSString * describe1;
@property (nonatomic, retain) NSString * describe2;
@property (nonatomic, retain) NSString * describe3;
@property (nonatomic, retain) NSString * describe4;
@property (nonatomic, retain) NSString * describe5;
@property (nonatomic, retain) NSNumber * rewardGoal;
@property (nonatomic, retain) NSNumber * rewardPrice;
@property (nonatomic, retain) NSDate * rewardDate;
@property (nonatomic, retain) NSString * rewardTitle;
@property (nonatomic, retain) NSString * rewardID;

@end
