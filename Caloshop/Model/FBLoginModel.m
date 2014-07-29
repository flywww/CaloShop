//
//  FBLoginModel.m
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "FBLoginModel.h"
@interface FBLoginModel()<NSURLConnectionDelegate>

@property (nonatomic, copy) id temp;


@end
@implementation FBLoginModel

//部署CoreData
//存到Core data（profile）


-(id)initWithProfileData:(id)profileData
{
    self = [self init];
    if (self)
    {
       self.birthday = profileData[@"birthday"];
       self.email    = profileData[@"email"];
       self.fbID     = profileData[@"fbID"];
       self.fbname   = profileData[@"fbname"];
       self.gender   = profileData[@"gender"];
       self.username = profileData[@"username"];
       self.avatar   = profileData[@"avatar"];
    }
    
    return self;
}

-(void)FBLogin
{
    self.FBPermissions=@[@"publish_actions",
                         @"public_profile",
                         @"user_birthday",
                         @"email",
                         @"user_interests",
                         @"user_groups",
                         @"user_likes"];
    
    [self checkNetworkAndDoNext:^
    {
        [PFFacebookUtils logInWithPermissions:self.FBPermissions block:^(PFUser *user, NSError *error)
         {
             //NSLog(@"[FB login] user info : %@ and error info : %@",user,error);
             if (!user)
             {
                 if (!error)
                 {
                     //user cancelled the Facebook login
                     NSLog(@"user cancelled the Facebook login");
                     
                     if ([self.delegate respondsToSelector:@selector(failToLoginFB:)])
                     {
                         [self.delegate failToLoginFB:error];
                     }
                     else
                     {
                         NSLog(@"fail to login");
                     }
                     [self alertViewWithError:@"user cancelled the Facebook login"];
                 }
                 else
                 {
                     //error occurred
                     NSLog(@"error occurred");
                     
                     if ([self.delegate respondsToSelector:@selector(failToLoginFB:)])
                     {
                         [self.delegate failToLoginFB:error];
                     }
                     else
                     {
                         NSLog(@"fail to login");
                     }
                     [self alertViewWithError:[NSString stringWithFormat:@"fail to login : %@",error]];
                 }
             }
             else if(user.isNew)
             {
                 //User with facebook signed up and logged in!
                 NSLog(@"User with facebook signed up and logged in!");
                 //UI Alert - 感謝註冊噢
                 [self fbFetchProfile];
                 if ([self.delegate respondsToSelector:@selector(didLoginFB)])
                 {
                     [self.delegate didLoginFB];
                 }
                 else
                 {
                     NSLog(@"new user did login");
                 }
             }
             else
             {
                 //User with facebook logged in
                 NSLog(@"User with facebook logged in");
                 //UI Alert View show 登入成功
                 [self fbFetchProfile];
                 if ([self.delegate respondsToSelector:@selector(didLoginFB)])
                 {
                     [self.delegate didLoginFB];
                 }
                 else
                 {
                     NSLog(@"old user did login");
                 }
             }
         }];
    }
    andFail:^
    {
        if ([self.delegate respondsToSelector:@selector(failToLoginFB:)])
        {
            NSError* error = [[NSError alloc]initWithDomain:@"Network fail" code:0 userInfo:nil];
            [self.delegate failToLoginFB:error];
        }
        else
        {
            NSLog(@"fail to login");
        }
        [self alertViewWithError:@"network error"];
    }];
   
}

#pragma mark - FB fetch data
-(void)fbFetchProfile
{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        NSLog(@"start fetch profile");
        if (!error)
        {
            //Save profile data to parse
            [PFUser currentUser][@"fbname"]       = result[@"name"];
            [PFUser currentUser][@"gender"]       = result[@"gender"];
            [PFUser currentUser][@"birthday"]     = result[@"birthday"];
            [PFUser currentUser][@"email"]        = result[@"email"];
            [PFUser currentUser][@"fbID"]         = result[@"id"];
            [PFUser currentUser][@"updated_time"] = result[@"updated_time"];
            [[PFUser currentUser] saveInBackground];
            [PFUser enableAutomaticUser];
            //NSLog(@"user catch data: %@",[PFUser currentUser]);
            
            [self profileSetWithData:result];
            
            [self fbFetchInterests];
            [self fbFetchGroups];
            [self fbFetchLikes];
            //Avatar Fetch
            self.avatar = [[NSMutableData alloc] init];//avatar initalization
            NSString* fbURL = @"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1";
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:fbURL,result[@"id"]]];
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                      cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  timeoutInterval:2.0f];
            // Run network request asynchronously
            NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            
            
            
            if ([self.delegate respondsToSelector:@selector(didFetchProfile:)])
            {
                [self.delegate didFetchProfile:result];
            }
            else
            {
                NSLog(@"did login");
            }
        }
        else
        {
            NSLog(@"Fetch profile error:%@",error);
            [self alertViewWithError:[NSString stringWithFormat:@"Fetch profile error : %@",error]];
        }
    }];
}


-(void)fbFetchInterests
{
     __block NSMutableArray* interestsArray=@[].mutableCopy;
    [FBRequestConnection startWithGraphPath:@"/me/interests"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,id result,NSError *error)
     {

             [(NSArray*)result[@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
              {
                  [interestsArray addObject:(NSArray*)result[@"data"][idx][@"name"]];
              }];
         if (!error)
         {
             self.intersts=interestsArray;
             [PFUser currentUser][@"Interests"]     = interestsArray;
             [[PFUser currentUser] saveInBackground];
             //NSLog(@"did Fetch interests:%@",self.intersts);
         }
         else
         {
             NSLog(@"Fetch interests error:%@",error);
            [self alertViewWithError:[NSString stringWithFormat:@"Fetch interests error: %@",error]];
         }
     }];
}

-(void)fbFetchGroups
{
    __block NSMutableArray* groupsArray=@[].mutableCopy;
    [FBRequestConnection startWithGraphPath:@"/me/groups"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,id result,NSError *error)
     {

             [(NSArray*)result[@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
              {
                  [groupsArray addObject:(NSArray*)result[@"data"][idx][@"name"]];
                  
              }];
            if (!error)
            {
                self.groups=groupsArray;
                [PFUser currentUser][@"groups"]         = groupsArray;
                [[PFUser currentUser] saveInBackground];
                //NSLog(@"did Fetch groups:%@",self.groups);
            }
            else
            {
                NSLog(@"Fetch Groups error:%@",error);
                [self alertViewWithError:[NSString stringWithFormat:@"Fetch groups error: %@",error]];
            }
     }];
}

-(void)fbFetchLikes
{
    __block NSMutableArray* likesArray=@[].mutableCopy;
    __block NSMutableArray* likesCategoryArray=@[].mutableCopy;
    [FBRequestConnection startWithGraphPath:@"/me/likes"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,id result,NSError *error)
     {
         [(NSArray*)result[@"data"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
              [likesArray addObject:(NSArray*)result[@"data"][idx][@"name"]];
              [likesCategoryArray addObject:(NSArray*)result[@"data"][idx][@"category"]];
          }];
         if (!error)
         {
             self.likes=likesArray;
             [PFUser currentUser][@"likes"]     = likesArray;
             [PFUser currentUser][@"likesCategory"] = likesCategoryArray;
             [[PFUser currentUser] saveInBackground];
             NSLog(@"did Fetch likes:%@",self.likes);
         }
         else
         {
             NSLog(@"Fetch likes error:%@",error);
             [self alertViewWithError:[NSString stringWithFormat:@"Fetch likes error: %@",error]];
         }
     }];
}

#pragma mark - NSURLConnectionDataDelegate

/* Callback delegate methods used for downloading the user's profile picture */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // As chuncks of the image are received, we build our data file
    //NSLog(@"%@",data);

    [self.avatar appendData:data];
    self.profile.avatar=self.avatar;
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // All data has been downloaded, now we can set the image in the header image view
    //self.headerImageView.image = [UIImage imageWithData:self.imageData];

    PFFile* avatarFile=[PFFile fileWithName:@"avatar.jpg" data:self.avatar];
    [PFUser currentUser][@"avatar"]=avatarFile;
    [[PFUser currentUser] saveInBackground];
}


#pragma mark - Coredata setting



-(void)alertViewWithError:(NSString*)error
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Opps!!" andMessage:error];
    
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {}];
    [alertView show];
}

@end
