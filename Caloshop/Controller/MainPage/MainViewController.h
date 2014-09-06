//
//  MainViewController.h
//  Caloshop
//
//  Created by 林盈志 on 7/24/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MainViewController :ViewController

@property (nonatomic) NSDictionary* productDictionary;
@property (nonatomic) NSDictionary* rewardDictionary;

//Side page setting
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end
