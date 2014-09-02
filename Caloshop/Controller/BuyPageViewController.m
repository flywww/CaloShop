//
//  BuyPageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "BuyPageViewController.h"

@interface BuyPageViewController ()

@property (nonatomic) UIImageView* mainImage;
@property (nonatomic) UILabel* productName;
@property (nonatomic) UITextField* nameField;
@property (nonatomic) UITextField* addressField;
@property (nonatomic) UITextField* phoneField;
@property (nonatomic) UIButton* buyButtom;

@end

@implementation BuyPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self.view addSubview:self.mainImage];
    [self.view addSubview:self.productName];
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.addressField];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.buyButtom];


}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.mainImage autoSetDimensionsToSize:CGSizeMake(175, 175)];
    [self.mainImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.mainImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:22];
    
    [self.productName autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainImage withOffset:8];
    
    [self.nameField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.nameField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.nameField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.productName withOffset:15];
    
    [self.addressField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.addressField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.addressField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameField withOffset:10];
    
    [self.phoneField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.phoneField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.phoneField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressField withOffset:10];
    
    
    [self.buyButtom autoSetDimensionsToSize:CGSizeMake(175, 40)];
    [self.buyButtom autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.buyButtom autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneField withOffset:20];


}

-(UIImageView *)mainImage
{
    if (!_mainImage)
    {
        _mainImage = [[UIImageView alloc]initForAutoLayout];
        [_mainImage sd_setImageWithURL:[self.productDictionary[@"mainImage"] url]
                      placeholderImage:[UIImage imageNamed:@"EmptyImage"]
                               options:0
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];
    }
    return _mainImage;
}

-(UILabel *)productName
{
    if (!_productName)
    {
        _productName = [[UILabel alloc]initForAutoLayout];
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.preferredMaxLayoutWidth = 320;
        _productName.text = self.productDictionary[@"name"];
        _productName.font = [UIFont fontWithName:fDFPHeiLight_B5 size:18];
        _productName.textColor = [UIColor colorWithHexString:@"#4E4D4D"];
        [_productName sizeToFit];
    }
    return _productName;
}

-(UITextField *)nameField
{
    if (!_nameField)
    {
        _nameField = [[UITextField alloc]initForAutoLayout];
        _nameField.textAlignment = NSTextAlignmentCenter;
        _nameField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _nameField.textColor = [UIColor colorWithHexString:@"#727171"];
        _nameField.placeholder = @"收件人姓名";
        _nameField.borderStyle = UITextBorderStyleLine;
        _nameField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _nameField.layer.borderWidth=1.0;
    }
    return _nameField;
}

-(UITextField *)addressField
{
    if (!_addressField)
    {
        _addressField = [[UITextField alloc]initForAutoLayout];
        _addressField.textAlignment = NSTextAlignmentCenter;
        _addressField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _addressField.textColor = [UIColor colorWithHexString:@"#727171"];
        _addressField.placeholder = @"收件人地址";
        _addressField.borderStyle = UITextBorderStyleLine;
        _addressField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _addressField.layer.borderWidth=1.0;
    }
    return _addressField;
}

-(UITextField *)phoneField
{
    if (!_phoneField)
    {
        _phoneField = [[UITextField alloc]initForAutoLayout];
        _phoneField.textAlignment = NSTextAlignmentCenter;
        _phoneField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _phoneField.textColor = [UIColor colorWithHexString:@"#727171"];
        _phoneField.placeholder = @"聯絡電話";
        _phoneField.borderStyle = UITextBorderStyleLine;
        _phoneField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _phoneField.layer.borderWidth=1.0;
    }
    return _phoneField;
}

-(UIButton *)buyButtom
{
    if (!_buyButtom)
    {
        _buyButtom=[[UIButton alloc]initForAutoLayout];
        [_buyButtom setImage:[UIImage imageNamed:@"material_btn_buynow"] forState:UIControlStateNormal];
        [_buyButtom addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButtom;
}


@end
