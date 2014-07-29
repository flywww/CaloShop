//
//  BasicModel.m
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "BasicModel.h"

@implementation BasicModel


-(void)checkNetworkAndDoNext:(NextBlock)next
{
    [self checkNetworkAndDoNext:next andFail:nil];
}

-(void)checkNetworkAndDoNext:(NextBlock)next andFail:(FailBlock)fail
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    if(reach.currentReachabilityStatus==NotReachable)
    {
        if(fail)
        {
            fail();
        }
        else
        {
            if ([self.delegate respondsToSelector:@selector(networkFail)])
            {
                [self.delegate networkFail];
            }
            else
            {
                NSLog(@"fail to fetch book list");
            }
            
        }
        
    }
    else
    {
        next();
    }

    
    
}

-(void)profileSetWithData:(NSDictionary*)userData
{
    
    if(userData[@"id"])          {self.profile.fbID         = userData[@"id"];          }
    if(userData[@"name"])        {self.profile.fbname       = userData[@"name"];        }
    if(userData[@"username"])    {self.profile.username     = userData[@"username"];    }
    if(userData[@"birthday"])    {self.profile.birthday     = userData[@"birthday"];    }
    if(userData[@"gender"])      {self.profile.gender       = userData[@"gender"];      }
    if(userData[@"email"])       {self.profile.email        = userData[@"email"];       }
    if(userData[@"name"])        {self.profile.name         = userData[@"name"];        }
    if(userData[@"height"])      {self.profile.height       = userData[@"height"];      }
    if(userData[@"weight"])      {self.profile.weight       = userData[@"weight"];      }
    if(userData[@"address"])     {self.profile.address      = userData[@"address"];     }
    if(userData[@"avatar"])      {self.profile.avatar       = userData[@"avatar"];      }
    if(userData[@"updated_time"]){self.profile.updated_time = userData[@"updated_time"];}
    
    //Save to persistant storage
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    NSLog(@"entities count - %lu",(unsigned long)[Profile MR_countOfEntities]);
    
    NSArray* profileShow = [Profile MR_findAll];
    NSLog(@"profile in coredata %@",profileShow);
    NSLog(@"profile - fbID %@",self.profile.fbID);
    NSLog(@"profile - height %@",self.profile.height);
}

-(Profile *)profile
{
    if (!_profile)
    {
        if (![Profile MR_findFirst])
        {
            _profile=[Profile MR_createEntity];
        }
        else
        {
            _profile=[Profile MR_findFirst];
        }
    }
    return _profile;
}


@end
