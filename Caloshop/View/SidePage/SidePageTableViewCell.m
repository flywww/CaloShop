//
//  SidePageTableViewCell.m
//  Caloshop
//
//  Created by 林盈志 on 8/19/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "SidePageTableViewCell.h"

@interface SidePageTableViewCell()

@property (nonatomic) UIView* seperateLine1;
@property (nonatomic) UIView* seperateLine2;

@end
@implementation SidePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor colorWithHexString:@"#c0e2d7"];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
//        self.textColor = [UIColor whiteColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:@"Apple LiGothic" size:23];
        
        [self addSubview:self.seperateLine1];
        [self addSubview:self.seperateLine2];
    }
    return self;
}


-(void)updateConstraints
{
    [super updateConstraints];
    
    [self.seperateLine1 autoSetDimensionsToSize:CGSizeMake(235, 2.5)];
    [self.seperateLine1 autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.seperateLine1 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    
    [self.seperateLine2 autoSetDimensionsToSize:CGSizeMake(235, 2.5)];
    [self.seperateLine2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:70-2.5];
    [self.seperateLine2 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];

}

-(UIView *)seperateLine1
{
    if (!_seperateLine1)
    {
        _seperateLine1 = [[UIView alloc]initForAutoLayout];
        _seperateLine1.backgroundColor = [UIColor whiteColor];
    }
    return _seperateLine1;
}
-(UIView *)seperateLine2
{
    if (!_seperateLine2)
    {
        _seperateLine2 = [[UIView alloc]initForAutoLayout];
        _seperateLine2.backgroundColor = [UIColor whiteColor];
    }
    return _seperateLine2;
}

@end
