//
//  WaterProgressView.h
//  Caloshop
//
//  Created by 林盈志 on 8/14/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WaterViewDelegate <NSObject>
@optional
-(void)didTapAction;

@end


@interface WaterProgressView : UIView

@property (nonatomic,weak) id<WaterViewDelegate>delegate;
@property (nonatomic) UIColor* currentWaterColor;

-(void)setProgress:(CGFloat)progress;
@property (nonatomic) UIImageView* productImg;


@end