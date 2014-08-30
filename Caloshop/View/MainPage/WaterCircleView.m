//
//  WaterCircleView.m
//  Caloshop
//
//  Created by 林盈志 on 8/30/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "WaterCircleView.h"

#import "WaterCircleView.h"

@interface WaterCircleView ()
{
    float waterCircleDiameter;
}


@end

@implementation WaterCircleView

- (id)init
{
    self = [super init];
    if (self)
    {
        waterCircleDiameter =250;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds=YES;
        self.layer.cornerRadius = waterCircleDiameter/2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw white circle
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 10);
    CGContextAddArc(context, waterCircleDiameter/2, waterCircleDiameter/2, waterCircleDiameter/2, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
}
@end
