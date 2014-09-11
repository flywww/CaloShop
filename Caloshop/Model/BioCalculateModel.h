//
//  BioCalculateModel.h
//  Caloshop
//
//  Created by 林盈志 on 9/10/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BioCalculateModelDelegate <NSObject>
@optional
-(void)todaysStepsUpdate:(NSInteger)steps;
@end


@interface BioCalculateModel : NSObject

@property (nonatomic,weak) id<BioCalculateModelDelegate> delegate;
-(void)startStepMonitering;

@end
