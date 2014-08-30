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
    NSString* viewTitle;
}

@property (nonatomic) UIImageView* popViewContent;
@property (nonatomic) UIImageView* popViewTitleView;
@property (nonatomic) UILabel* popViewTitle;


@end

@implementation PopViewController

-(id)initWithCategory:(NSString*)category andTitle:(NSString*)title
{
    self = [super init];
    if (self)
    {
        whichView = category;
        viewTitle = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [self.view addSubview:self.popViewContent];
    [self.view addSubview:self.popViewTitleView];
    [self.view addSubview:self.popViewTitle];
    
    [self.view addSubview:self.middleBtn];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.rightBtn];
}

-(UIImageView *)popViewContent
{
    if (!_popViewContent)
    {
        if ([whichView  isEqual:PopViewCallSucceed])
        {
            _popViewContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 270, 414)];
            _popViewContent.image = [UIImage imageNamed:@"11_material_popup_succeed"];
            
        }
        else if ([whichView isEqual:PopViewCallFail])
        {
            _popViewContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 270, 414)];
            _popViewContent.image = [UIImage imageNamed:@"11_material_popup_failed"];
        }
        else if ([whichView isEqual:PopViewCallCheck])
        {
            _popViewContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 270, 414)];
            _popViewContent.image = [UIImage imageNamed:@"11_material_popup_recheck"];
        }
        else if ([whichView isEqual:PopViewCallStart])
        {
            _popViewContent = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 270, 414)];
            _popViewContent.image = [UIImage imageNamed:@"11_material_popup_firstime"];
        }
    }
    return _popViewContent;
}

-(UIImageView *)popViewTitleView
{
    if (!_popViewTitleView)
    {
        _popViewTitleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"11_material_newmissionbar_NOwords"]];
        
        
        _popViewTitleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 270, 41)];
        _popViewTitleView.image = [UIImage imageNamed:@"11_material_newmissionbar_NOwords"];
        //_popViewTitle.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _popViewTitleView;
}

-(UIButton *)leftBtn
{
    if (!_leftBtn)
    {
        if ([whichView  isEqual:PopViewCallSucceed])
        {
            _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(29, 399, 100, 44)];
            [_leftBtn setImage:[UIImage imageNamed:@"11_material_popup_succeed_okay"] forState:UIControlStateNormal];
            [_leftBtn setImage:[UIImage imageNamed:@"11_material_popup_succeed_okay2"] forState:UIControlStateHighlighted];
            [_leftBtn addTarget:self action:@selector(LeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([whichView isEqual:PopViewCallCheck])
        {
            _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(29, 399, 100, 44)];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_recheck_previoulsy"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_recheck_previoulsy2"] forState:UIControlStateHighlighted];
            [_rightBtn addTarget:self action:@selector(LeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _leftBtn;
}

-(UIButton *)rightBtn
{
    if (!_rightBtn)
    {
        if ([whichView  isEqual:PopViewCallSucceed])
        {
            _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(141, 399, 100, 44)];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_succeed_abstain"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_succeed_abstain2"] forState:UIControlStateHighlighted];
            [_rightBtn addTarget:self action:@selector(RightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([whichView isEqual:PopViewCallCheck])
        {
            _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(141, 399, 100, 44)];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_recheck_abstain"] forState:UIControlStateNormal];
            [_rightBtn setImage:[UIImage imageNamed:@"11_material_popup_recheck_abstain2"] forState:UIControlStateHighlighted];
            [_rightBtn addTarget:self action:@selector(RightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _rightBtn;
}

-(UIButton *)middleBtn
{
    if (!_middleBtn)
    {
        if ([whichView isEqual:PopViewCallFail])
        {
            _middleBtn = [[UIButton alloc]initWithFrame:CGRectMake(65, 399, 140, 44)];
            [_middleBtn setImage:[UIImage imageNamed:@"11_material_popup_failed_accept"] forState:UIControlStateNormal];
            [_middleBtn setImage:[UIImage imageNamed:@"11_material_popup_failed_accept2"] forState:UIControlStateHighlighted];
            [_middleBtn addTarget:self action:@selector(MiddleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([whichView isEqual:PopViewCallStart])
        {
            _middleBtn = [[UIButton alloc]initWithFrame:CGRectMake(65, 399, 140, 44)];
            [_middleBtn setImage:[UIImage imageNamed:@"11_material_popup_firstime_accept"] forState:UIControlStateNormal];
            [_middleBtn setImage:[UIImage imageNamed:@"11_material_popup_firstime_accept1"] forState:UIControlStateHighlighted];
            [_middleBtn addTarget:self action:@selector(MiddleBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _middleBtn;
}

-(UILabel *)popViewTitle
{
    if (!_popViewTitle)
    {
        _popViewTitle = [[UILabel alloc]initWithFrame:CGRectMake(77, 20, 190, 15)];
        _popViewTitle.font = [UIFont fontWithName:fApple_LiGothic size:15];
        _popViewTitle.textAlignment=NSTextAlignmentCenter;
        _popViewTitle.textColor = [UIColor whiteColor];
        _popViewTitle.text = viewTitle;
    }
    return _popViewTitle;
}


-(void)MiddleBtnAction
{
    if ([whichView isEqual:PopViewCallFail])
    {
        
    }
    else if ([whichView isEqual:PopViewCallStart])
    {
        
    }

}

-(void)RightBtnAction
{
    if ([whichView  isEqual:PopViewCallSucceed])
    {
       
    }
    else if ([whichView isEqual:PopViewCallCheck])
    {
        
    }
}

-(void)LeftBtnAction
{
    if ([whichView  isEqual:PopViewCallSucceed])
    {
        
    }
    else if ([whichView isEqual:PopViewCallCheck])
    {
        
    }
}

@end
