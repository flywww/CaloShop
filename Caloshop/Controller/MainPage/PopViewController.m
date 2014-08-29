//
//  PopViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/19/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()
{
    NSString* whichView;
    
    
}

@property (nonatomic) UIImageView* popViewBackGround;
@property (nonatomic) UIButton* 

@end

@implementation PopViewController

-(id)initWithCategory:(NSString*)category
{
    self = [self init];
    if (self)
    {
        whichView = category;
    }
    return self;
}


- (void)viewDidLoad
{
    [self.view addSubview:self.popViewBackGround];
}

-(void)updateViewConstraints
{
    [self.popViewBackGround autoSetDimensionsToSize:CGSizeMake(270, 414)];
    [self.popViewBackGround autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.view];
    [self.popViewBackGround autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.popViewBackGround autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
    [self.popViewBackGround autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
}


-(UIImageView *)popViewBackGround
{
    if (!_popViewBackGround)
    {
        if ([whichView  isEqual:@"succeed"])
        {
            _popViewBackGround = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11_material_popup_succeed"]];
        }
        else if ([whichView isEqual:@"fail"])
        {
            _popViewBackGround = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11_material_popup_failed"]];
        }
        else if ([whichView isEqual:@"check"])
        {
            _popViewBackGround = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11_material_popup_recheck"]];
        }
    }
    return _popViewBackGround;
}



@end
