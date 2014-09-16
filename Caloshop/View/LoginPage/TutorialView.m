//
//  TutorialView.m
//  Caloshop
//
//  Created by 林盈志 on 9/1/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "TutorialView.h"

static NSString * const tutorialTitle1 = @"歡迎使用";
static NSString * const tutorialTitle2 = @"歡迎使用";
static NSString * const tutorialTitle3 = @"歡迎使用";
static NSString * const tutorialTitle4 = @"歡迎使用";

static NSString * const tutorialDescription1 = @"首次使用CaloShop卡洛哩販賣店\n以下將簡單對您說明使用方式\n您也可以直接登入使用";
static NSString * const tutorialDescription2 = @"首次使用CaloShop卡洛哩販賣店\n以下將簡單對您說明使用方式\n您也可以直接登入使用";
static NSString * const tutorialDescription3 = @"首次使用CaloShop卡洛哩販賣店\n以下將簡單對您說明使用方式\n您也可以直接登入使用";
static NSString * const tutorialDescription4 = @"首次使用CaloShop卡洛哩販賣店\n以下將簡單對您說明使用方式\n您也可以直接登入使用";

@interface TutorialView ()
{
    NSString* whichcPage;
    
}
@property (nonatomic) UIImageView* backgroundImag;
@property (nonatomic) UILabel* mainTitle;
@property (nonatomic) UIImageView* titleIcon;
@property (nonatomic) UILabel* title;
@property (nonatomic) UILabel* desc;
@property (nonatomic) UIButton* fbLoginButton;

@property (nonatomic) NSString* page;

@end
@implementation TutorialView

- (id)initWithPage:(NSString*)page
{
    self = [super init];
    if (self)
    {
        whichcPage = page;
        [self addSubview:self.backgroundImag];
        [self addSubview:self.mainTitle];
        [self addSubview:self.titleIcon];
        [self addSubview:self.title];
        [self addSubview:self.desc];
        [self addSubview:self.fbLoginButton];
        
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    [self.backgroundImag autoSetDimensionsToSize:CGSizeMake(320, 568)];
    [self.backgroundImag autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
    [self.backgroundImag autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self.backgroundImag autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self];
    [self.backgroundImag autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self];
    
    [self.mainTitle autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.mainTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:50];
    
    [self.titleIcon autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.titleIcon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainTitle withOffset:43];
    
    [self.title autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.title autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleIcon withOffset:35];
    
    [self.desc autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.desc autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.title withOffset:10];
    
    [self.fbLoginButton autoSetDimensionsToSize:CGSizeMake(220, 40)];
    [self.fbLoginButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImag];
    [self.fbLoginButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:-20];
}


-(UIImageView *)backgroundImag
{
    if (!_backgroundImag)
    {
        _backgroundImag = [[UIImageView alloc]initForAutoLayout];
        _backgroundImag.image = [UIImage imageNamed:@"01_TutorialPage_backonly"];
    }
    
    return _backgroundImag;
}

-(UILabel *)mainTitle
{
    if (!_mainTitle)
    {
        _mainTitle = [[UILabel alloc]initForAutoLayout];
        _mainTitle.font = [UIFont fontWithName:fMyriadPro_Bold_It size:24];
        _mainTitle.textColor = [UIColor whiteColor];
        _mainTitle.text = @"";
    }
    return _mainTitle;
}

-(UIImageView *)titleIcon
{
    if (!_titleIcon)
    {
        _titleIcon = [[UIImageView alloc]initForAutoLayout];
        
        if([whichcPage isEqual: @"page1"])
        {
            _titleIcon.image = [UIImage imageNamed:@"01_TutorialPage_PicA"];
        }
        else if([whichcPage isEqual: @"page2"])
        {
            _titleIcon.image = [UIImage imageNamed:@"01_TutorialPage_PicB"];
        }
        else if ([whichcPage isEqual: @"page3"])
        {
            _titleIcon.image = [UIImage imageNamed:@"01_TutorialPage_PicC"];
        }
        else if ([whichcPage isEqual: @"page4"])
        {
            _titleIcon.image = [UIImage imageNamed:@"01_TutorialPage_PicD"];
        }
    }
    return  _titleIcon;
}

-(UILabel *)title
{
    if (!_title)
    {
        _title = [[UILabel alloc]initForAutoLayout];
        _title.font = [UIFont fontWithName:fApple_LiGothic size:18];
        _title.textColor = [UIColor whiteColor];
        
        if([whichcPage isEqual: @"page1"])
        {
            _title.text = tutorialTitle1;
        }
        else if([whichcPage isEqual: @"page2"])
        {
            _title.text = tutorialTitle2;
        }
        else if ([whichcPage isEqual: @"page3"])
        {
            _title.text = tutorialTitle3;
        }
        else if ([whichcPage isEqual: @"page4"])
        {
            _title.text = tutorialTitle4;
        }
    }
    return _title;
}


-(UILabel *)desc
{
    if (!_desc)
    {
        _desc = [[UILabel alloc]initForAutoLayout];
        _desc.font = [UIFont fontWithName:fApple_LiGothic size:18];
        _desc.preferredMaxLayoutWidth = 320;
        _desc.numberOfLines = 0;
        _desc.lineBreakMode = NSLineBreakByWordWrapping;
        _desc.textColor = [UIColor whiteColor];
        
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        paragrahStyle.lineSpacing = 4;
        paragrahStyle.alignment = NSTextAlignmentCenter;
        
        if([whichcPage isEqual: @"page1"])
        {
            NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragrahStyle,};
            _desc.attributedText = [[NSAttributedString alloc] initWithString:tutorialDescription1
                                                                   attributes:attributtes];
        }
        else if([whichcPage isEqual: @"page2"])
        {
            NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragrahStyle,};
            _desc.attributedText = [[NSAttributedString alloc] initWithString:tutorialDescription2
                                                                   attributes:attributtes];        }
        else if ([whichcPage isEqual: @"page3"])
        {
            NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragrahStyle,};
            _desc.attributedText = [[NSAttributedString alloc] initWithString:tutorialDescription3
                                                                   attributes:attributtes];
        }
        else if ([whichcPage isEqual: @"page4"])
        {
            NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragrahStyle,};
            _desc.attributedText = [[NSAttributedString alloc] initWithString:tutorialDescription4
                                                                   attributes:attributtes];        }
    }
    return _desc;
}


-(UIButton *)fbLoginButton
{
    if (!_fbLoginButton)
    {
        _fbLoginButton = [[UIButton alloc]initForAutoLayout];
        [_fbLoginButton setImage:[UIImage imageNamed:@"01_material_btn_FBlogin"] forState:UIControlStateNormal];
        [_fbLoginButton addTarget:self action:@selector(LoginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fbLoginButton;
}


-(void)LoginAction
{
    
    if ([self.delegate respondsToSelector:@selector(buttomClickAction)])
    {
        [self.delegate buttomClickAction];
    }
}



@end
