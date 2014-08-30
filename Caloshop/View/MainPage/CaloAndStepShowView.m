//
//  CaloAndStepShowView.m
//  Caloshop
//
//  Created by 林盈志 on 8/18/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "CaloAndStepShowView.h"
#import <UICountingLabel.h>

@interface CaloAndStepShowView()

@property (nonatomic) UILabel* caloLebel;
@property (nonatomic) UILabel* stepLebel;
@property (nonatomic) UICountingLabel* caloValue;
@property (nonatomic) UICountingLabel* stepValue;
@property (nonatomic) UIView* seperateLine;

@end

@implementation CaloAndStepShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.seperateLine];
        [self addSubview:self.caloValue];
        [self addSubview:self.caloLebel];
        [self addSubview:self.stepValue];
        [self addSubview:self.stepLebel];
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.seperateLine autoSetDimensionsToSize:CGSizeMake(1, 50)];
    [self.seperateLine autoCenterInSuperview];
    
    [self.caloValue autoSetDimensionsToSize:CGSizeMake(100, 28)];
    [self.caloValue autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.seperateLine withOffset:5];
    [self.caloValue autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.seperateLine withOffset:-10];
    
    [self.caloLebel autoSetDimensionsToSize:CGSizeMake(100, 20)];
    [self.caloLebel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.caloValue];
    [self.caloLebel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.caloValue withOffset:-5];
    
    [self.stepValue autoSetDimensionsToSize:CGSizeMake(100, 28)];
    [self.stepValue autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.seperateLine withOffset:5];
    [self.stepValue autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.seperateLine withOffset:10];
    
    [self.stepLebel autoSetDimensionsToSize:CGSizeMake(100, 20)];
    [self.stepLebel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.stepValue];
    [self.stepLebel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.stepValue withOffset:-5];
}

-(void)showViewWithNewCalo:(int)newCalo andOldCalo:(int)oldCalo andNewSteps:(int)newSteps andOldSteps:(int)oldSteps
{
    [self.caloValue countFrom:oldCalo to:newCalo];
    [self.stepValue countFrom:oldSteps to:newSteps];
}

-(UILabel *)caloLebel
{
    if (!_caloLebel)
    {
        _caloLebel = [[UILabel alloc]initForAutoLayout];
        _caloLebel.font = [UIFont fontWithName:fDFYuanMedium_B5 size:18];
        _caloLebel.textAlignment=NSTextAlignmentRight;
        _caloLebel.textColor = [UIColor whiteColor];
        _caloLebel.text = @"卡";
    }
    return _caloLebel;
}

-(UILabel *)stepLebel
{
    if (!_stepLebel)
    {
        _stepLebel = [[UILabel alloc]initForAutoLayout];
        _stepLebel.font = [UIFont fontWithName:fDFYuanMedium_B5 size:18];
        _stepLebel.textAlignment=NSTextAlignmentLeft;
        _stepLebel.textColor = [UIColor whiteColor];
        _stepLebel.text = @"步";
    }
    return _stepLebel;
}

-(UICountingLabel *)caloValue
{
    if (!_caloValue)
    {
        _caloValue = [[UICountingLabel alloc]initForAutoLayout];
        _caloValue.font = [UIFont fontWithName:fMyriadPro_It size:30];
        _caloValue.textAlignment=NSTextAlignmentRight;
        _caloValue.textColor = [UIColor whiteColor];
        _caloValue.text = @"0";
        _caloValue.format=@"%d";
        _caloValue.method=UILabelCountingMethodEaseInOut;
    }
    return _caloValue;
}

-(UICountingLabel *)stepValue
{
    if (!_stepValue)
    {
        _stepValue = [[UICountingLabel alloc]initForAutoLayout];
        _stepValue.font = [UIFont fontWithName:fMyriadPro_It size:30];
        _stepValue.textAlignment=NSTextAlignmentLeft;
        _stepValue.textColor = [UIColor whiteColor];
        _stepValue.text = @"0";
        _stepValue.format=@"%d";
        _stepValue.method=UILabelCountingMethodEaseInOut;
    }
    return _stepValue;
}

-(UIView *)seperateLine
{
    if (!_seperateLine)
    {
        _seperateLine = [[UIView alloc]initForAutoLayout];
        _seperateLine.backgroundColor = [UIColor whiteColor];
    }
    return _seperateLine;
}
@end
