//
//  Profile.h
//  Caloshop
//
//  Created by 林盈志 on 7/27/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * fbID;
@property (nonatomic, retain) NSString * fbname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * updated_time;
@property (nonatomic, retain) NSData * avatar;

@end
