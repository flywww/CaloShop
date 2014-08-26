//
//  ProductPageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "ProductPageViewController.h"
#import <UIImageView+WebCache.h>

@interface ProductPageViewController ()


@property (nonatomic) UIScrollView* productView;


@property (nonatomic) UILabel* testText;
@property (nonatomic) UILabel* testText2;


@property (nonatomic) UIImageView* mainImage;
@property (nonatomic) UIButton* buyButton;
@property (nonatomic) UILabel* productName;
@property (nonatomic) UILabel* price;
@property (nonatomic) UILabel* mainDescribe;
@property (nonatomic) UIImageView* image1;
@property (nonatomic) UILabel* describe1;
@property (nonatomic) UIImageView* image2;
@property (nonatomic) UILabel* describe2;
@property (nonatomic) UIImageView* image3;
@property (nonatomic) UILabel* describe3;
@property (nonatomic) UIImageView* image4;
@property (nonatomic) UILabel* describe4;
@property (nonatomic) UIImageView* image5;
@property (nonatomic) UILabel* describe5;


@end

@implementation ProductPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.productView];
    [self.productView addSubview:self.mainImage];
    
    
    NSLog(@"PriductPageView - %@", self.productDictionary);
    NSLog(@"?????? - %@", self.productDictionary[@"image3"]);
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.productView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [self.productView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    [self.productView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.productView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
    
    //
    [self.mainImage autoSetDimensionsToSize:CGSizeMake(175, 175)];
    [self.mainImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.productView withOffset:22];
    [self.mainImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
//    [self.mainImage autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.productView];
//    [self.mainImage autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.productView];
//    
    
    
    
    
//    [self.testText autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.productView];
//    [self.testText autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
//    
//    [self.testText2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.testText withOffset:30];
//    [self.testText2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
//    [self.testText2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.productView];
    
    
//    NSDictionary* views =@{@"view": self.productView,
//                           @"a":self.testText,
//                           @"b":self.testText2};
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(504)]|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:views]];
//    
//    [self.productView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[a]-|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:views]];
//    [self.productView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[b]-|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:views]];
//    [self.productView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[a]-[b]"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:views]];
}

#pragma mark - property init

-(UIScrollView *)productView
{
    if (!_productView)
    {
        _productView = [[UIScrollView alloc]initForAutoLayout];
        _productView.contentSize=CGSizeMake(320, 568-64);
        _productView.backgroundColor = [UIColor whiteColor];
    }
    return _productView;
}

-(UIImageView *)mainImage
{
    if (!_mainImage)
    {
        _mainImage = [[UIImageView alloc]initForAutoLayout];
        [_mainImage sd_setImageWithURL:[self.productDictionary[@"mainImage"] url] placeholderImage:[UIImage imageNamed:@"EmptyImage"]];
    }
    return _mainImage;
}

-(UIButton *)buyButton
{
    if (!_buyButton)
    {
        _buyButton=[[UIButton alloc]initForAutoLayout];
    }
    return _buyButton;
}















-(UILabel *)testText
{
    if (!_testText)
    {
        _testText = [[UILabel alloc]initForAutoLayout];
        _testText.numberOfLines = 0;
        _testText.lineBreakMode = NSLineBreakByWordWrapping;
        _testText.textAlignment = NSTextAlignmentLeft;
        _testText.backgroundColor = [UIColor greenColor];
        _testText.preferredMaxLayoutWidth = 280;
        _testText.text = @"fnwefnjkwenfoinwefnwekfnkwejnfkjewnfkjnwefnkewjnfkjwenfkjnwekfnwelfejwnflewjnfkjewnfjknewfkjnewkjnfkejwnfkjewnfklewjnfjkenwfkjnweflkjnewlkjfnjnewlkjfnwkejnfkjwenfjknwefkjnweklfnlwejnflkewnflwenfkjlwenflwenfewnfkwefkjjkwenfkjewnfklewjnfjkenwfkjnweflkjnewlkjfnwkejnfkjwenfjknwefkjnweklfnlwejnflkewnflwenfkjlwenflwenfewnfkwefkjjkwenfkjewnfklewjnfjkenwfkjnweflkjnewlkjfnwkejnfkjwenfjknwefkjnweklfnlwejnflkewnflwenfkjlwenflwenfewnfkwefkjjkwe";
        [_testText sizeToFit];
    }
    return _testText;
}

-(UILabel *)testText2
{
    if (!_testText2)
    {
        _testText2 = [[UILabel alloc]initForAutoLayout];
        _testText2.numberOfLines = 0;
        _testText2.lineBreakMode = NSLineBreakByWordWrapping;
        _testText2.textAlignment = NSTextAlignmentLeft;
        _testText2.backgroundColor = [UIColor yellowColor];
        _testText2.preferredMaxLayoutWidth = 280;
        _testText2.text = @"哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉哈哈哈哈哈哈哈哈拉拉拉拉拉拉拉拉";
        [_testText2 sizeToFit];
    }
    return _testText2;
}


@end
