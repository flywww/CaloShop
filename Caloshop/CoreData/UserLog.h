//
//  UserLog.h
//  Caloshop
//
//  Created by 林盈志 on 7/30/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserLog : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * steps;
@property (nonatomic, retain) NSNumber * reachGoal;
@property (nonatomic, retain) NSString * rewardID;

@end
