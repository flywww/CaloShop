//
//  BuyPageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "BuyPageViewController.h"
#import "UploadOrderModel.h"
#import <DAKeyboardControl.h>

@interface BuyPageViewController ()

@property (nonatomic) UIView* containerView;

@property (nonatomic) UIImageView* mainImage;
@property (nonatomic) UILabel* productName;
@property (nonatomic) UITextField* nameField;
@property (nonatomic) UITextField* addressField;
@property (nonatomic) UITextField* phoneField;
@property (nonatomic) UIButton* buyButtom;
@property (nonatomic) UIImageView* cloudImage;
@property(nonatomic,strong) UITapGestureRecognizer* tap;

@end

@implementation BuyPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"CaloShop";
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.mainImage];
    [self.containerView addSubview:self.productName];
    [self.containerView addSubview:self.nameField];
    [self.containerView addSubview:self.addressField];
    [self.containerView addSubview:self.phoneField];
    [self.containerView addSubview:self.buyButtom];
    [self.containerView addSubview:self.cloudImage];
    //gesture
    [self.view addGestureRecognizer:self.tap];

    [self keyboardControl];
    
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.containerView autoSetDimensionsToSize:CGSizeMake(320, 504)];
    [self.containerView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [self.containerView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.containerView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
    
    [self.mainImage autoSetDimensionsToSize:CGSizeMake(175, 175)];
    [self.mainImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.mainImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.containerView withOffset:22];
    
    [self.productName autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainImage withOffset:8];
    
    [self.nameField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.nameField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.nameField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.productName withOffset:15];
    
    [self.addressField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.addressField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.addressField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameField withOffset:10];
    
    [self.phoneField autoSetDimensionsToSize:CGSizeMake(240, 40)];
    [self.phoneField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.phoneField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.addressField withOffset:10];
    
    
    [self.buyButtom autoSetDimensionsToSize:CGSizeMake(175, 40)];
    [self.buyButtom autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.buyButtom autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneField withOffset:20];
    
    [self.cloudImage autoSetDimensionsToSize:CGSizeMake(320, 126)];
    [self.cloudImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.containerView];
    [self.cloudImage autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];

}

-(void)keyboardControl
{
    __weak BuyPageViewController* this = self;
    self.view.keyboardTriggerOffset = 200;
    
    [self.view addKeyboardNonpanningWithActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        if (this.view.keyboardWillRecede)
        {
            [UIView animateWithDuration:1 animations:^
             {
                 CGRect newFrame = this.containerView.frame;
                 newFrame.origin.y = -200;
                 this.containerView.frame = newFrame;
             }];
        }
        else
        {
            [UIView animateWithDuration:1 animations:^
             {
                 CGRect newFrame = this.containerView.frame;
                 newFrame.origin.y = 0;
                 this.containerView.frame = newFrame;
             }];
        }
    }];
}

-(void)dismissKeyBoard:(id)sender
{
    [self.view endEditing:YES];
}

-(void)sendAction:(id)sender
{
    [self.view endEditing:YES];
    
    //check text is correct
    if([TextFieldChecker isEmpty:self.nameField]||[TextFieldChecker isEmpty:self.addressField]||[TextFieldChecker isEmpty:self.phoneField])
    {
        NSLog(@"errrrrrror");
    }
    else
    {
        //save default info
        
        //send to parse server
        UploadOrderModel* orderModel = [[UploadOrderModel alloc]init];
        [orderModel uploadOlderWithName:self.nameField.text andPhone:self.phoneField.text andAddress:self.addressField.text andReward:self.productDictionary];
    }
    
    
    //mark today's reward get
    
    //go to main page when it done
}


#pragma mark - property initialize

-(UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc]initForAutoLayout];
    }
    return _containerView;
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
        _nameField.layer.borderColor = [UIColor colorWithHexString:@"#B5B5B6"].CGColor;
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
        _addressField.layer.borderColor = [UIColor colorWithHexString:@"#B5B5B6"].CGColor;
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
        _phoneField.layer.borderColor = [UIColor colorWithHexString:@"#B5B5B6"].CGColor;
        _phoneField.layer.borderWidth=1.0;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneField;
}

-(UIButton *)buyButtom
{
    if (!_buyButtom)
    {
        _buyButtom=[[UIButton alloc]initForAutoLayout];
        [_buyButtom setImage:[UIImage imageNamed:@"material_btn_buynow"] forState:UIControlStateNormal];
        [_buyButtom addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButtom;
}

-(UIImageView *)cloudImage
{
    if (!_cloudImage)
    {
        _cloudImage = [[UIImageView alloc]initForAutoLayout];
        _cloudImage.image = [UIImage imageNamed:@"05_material_bg_cloud"];
    }
    
    return _cloudImage;
}

-(UITapGestureRecognizer *)tap
{
    if(!_tap)
    {
        _tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard:)];
    }
    return _tap;
}

@end
