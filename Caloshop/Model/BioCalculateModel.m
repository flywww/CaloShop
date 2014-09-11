//
//  BioCalculateModel.m
//  Caloshop
//
//  Created by 林盈志 on 9/10/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "BioCalculateModel.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>


@interface BioCalculateModel()

@property (nonatomic) CMMotionManager* motionManager;
@property (nonatomic, strong) CMStepCounter *stepCounter;
@property (nonatomic, strong) CMMotionActivityManager *activityManager;

@end

@implementation BioCalculateModel

-(void)startStepMonitering
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(todayStepsCounting) userInfo:nil repeats:YES];
}


-(NSInteger)todayStepsCounting
{
    __block NSInteger steps = 0;
    //M7 Device
    if (([CMStepCounter isStepCountingAvailable] || [CMMotionActivityManager isActivityAvailable]))
    {
        [self.stepCounter queryStepCountStartingFrom:[HelpTool getLocalDateWithOutTime]
                                                  to:[HelpTool getLocalDate]
                                             toQueue:[[NSOperationQueue alloc] init]
                                         withHandler:^(NSInteger numberOfSteps, NSError *error)
        {
            steps = numberOfSteps;
            if ([self.delegate respondsToSelector:@selector(todaysStepsUpdate:)])
            {
                [self.delegate todaysStepsUpdate:steps];
            }
        }];
    }
    return steps;
}

-(CMStepCounter *)stepCounter
{
    if (!_stepCounter)
    {
        _stepCounter=[[CMStepCounter alloc] init];
    }
    return _stepCounter;
}

@end
