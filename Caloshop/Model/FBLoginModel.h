//
//  FBLoginModel.h
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicModel.h"

@class FBLoginModel;
@protocol FBLoginModelDelegate <BasicModelDelegate>
@optional
-(void)didLoginFB;
-(void)failToLoginFB:(NSError*)error;
-(void)fbFetchProfile;
-(void)failToFetchProfile:(NSError*)error;
-(void)didFetchProfile:(id)FBprofile;

-(BOOL)didSavedProfileData;
-(void)failToSaveProfileData:(NSError*)error;


@end

@interface FBLoginModel : BasicModel

@property (nonatomic, weak) id<FBLoginModelDelegate> delegate;

@property (nonatomic) NSString* birthday;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* fbID;
@property (nonatomic) NSString* fbname;
@property (nonatomic) NSString* gender;
@property (nonatomic) NSString* username;
@property (nonatomic) NSArray* intersts;
@property (nonatomic) NSArray* groups;
@property (nonatomic) NSArray* likes;

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* height;
@property (nonatomic) NSString* weight;
@property (nonatomic) NSString* address;

@property (nonatomic) NSMutableData* avatar;

@property (nonatomic) NSArray* FBPermissions;

@property (nonatomic) Profile* profile;

-(id)initWithProfileData:(id)profileData;
-(void)FBLogin;

-(void)profileSetWithData:(NSDictionary*)userData;
@end
