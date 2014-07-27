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


@end
