//
//  ProductPageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "ProductPageViewController.h"
#import "BuyPageViewController.h"
#import <UIImageView+WebCache.h>

@interface ProductPageViewController ()

@property (nonatomic) UIScrollView* productView;

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
@property (nonatomic) UIButton* buyButton2;

@property (nonatomic) UIImageView* cloudView;

@end

@implementation ProductPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"CaloShop";
    
    [self viewLayout];
}

#pragma mark - Buttom action

-(void)buyAction
{
    [self performSegueWithIdentifier:@"ProductToBuySeg" sender:self.productDictionary];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BuyPageViewController* buyPageViewController = (BuyPageViewController*)[segue destinationViewController];
    buyPageViewController.productDictionary = (NSDictionary*)sender;
}


-(void)viewLayout
{
    [self.view addSubview:self.productView];
    [self.view addSubview:self.cloudView];
    [self.productView addSubview:self.mainImage];
    [self.productView addSubview:self.buyButton];
    [self.productView addSubview:self.productName];
    [self.productView addSubview:self.price];
    [self.productView addSubview:self.mainDescribe];
    
    if (self.productDictionary[@"image1"]!=NULL)
    {
        [self.productView addSubview:self.image1];
        [self.productView addSubview:self.describe1];
    }
    if (self.productDictionary[@"image2"]!=NULL)
    {
        [self.productView addSubview:self.image2];
        [self.productView addSubview:self.describe2];
    }
    if (self.productDictionary[@"image3"]!=NULL)
    {
        [self.productView addSubview:self.image3];
        [self.productView addSubview:self.describe3];
    }
    if (self.productDictionary[@"image4"]!=NULL)
    {
        [self.productView addSubview:self.image4];
        [self.productView addSubview:self.describe4];
    }
    if (self.productDictionary[@"image5"]!=NULL)
    {
        [self.productView addSubview:self.image5];
        [self.productView addSubview:self.describe5];
    }
    [self.productView addSubview:self.buyButton2];
}


#pragma mark - constraint method

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    NSLog(@"Product View contraint update!");
    
    [self.productView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [self.productView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    [self.productView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.productView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
    
    [self.cloudView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
    [self.cloudView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.cloudView autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.view];
    
    [self.mainImage autoSetDimensionsToSize:CGSizeMake(175, 175)];
    [self.mainImage autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.mainImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.productView withOffset:22];
    
    [self.buyButton autoSetDimensionsToSize:CGSizeMake(175, 40)];
    [self.buyButton autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.buyButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainImage withOffset:15];
    
    [self.productName autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.buyButton withOffset:15];
    
    [self.price autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.price autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.productName withOffset:7.5];
    
    [self.mainDescribe autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.mainDescribe autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.price withOffset:21];
    
    if (self.productDictionary[@"image1"]!=NULL)
    {
        //image1 and describe1
        [self.image1 autoRemoveConstraintsAffectingView];
        [self.image1 autoSetDimensionsToSize:CGSizeMake(280, 280*[self imageScale:self.image1])];
        [self.image1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.image1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mainDescribe withOffset:21];
        [self.describe1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.describe1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.image1 withOffset:21];
    }
    if (self.productDictionary[@"image2"]!=NULL)
    {
        //image2 and describe2
        [self.image2 autoRemoveConstraintsAffectingView];
        [self.image2 autoSetDimensionsToSize:CGSizeMake(280, 280*[self imageScale:self.image2])];
        [self.image2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.image2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.describe1 withOffset:21];
        [self.describe2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.describe2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.image2 withOffset:21];
    }
    if (self.productDictionary[@"image3"]!=NULL)
    {
        //image3 and describe3
        [self.image3 autoRemoveConstraintsAffectingView];
        [self.image3 autoSetDimensionsToSize:CGSizeMake(280, 280*[self imageScale:self.image3])];
        [self.image3 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.image3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.describe2 withOffset:21];
        [self.describe3 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.describe3 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.image3 withOffset:21];
    }
    if (self.productDictionary[@"image4"]!=NULL)
    {
        //image4 and describe4
        [self.image4 autoRemoveConstraintsAffectingView];
        [self.image4 autoSetDimensionsToSize:CGSizeMake(280, 280*[self imageScale:self.image4])];
        [self.image4 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.image4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.describe3 withOffset:21];
        [self.describe4 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.describe4 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.image4 withOffset:21];
    }
    if (self.productDictionary[@"image5"]!=NULL)
    {
        //image5 and describe5
        [self.image5 autoRemoveConstraintsAffectingView];
        [self.image5 autoSetDimensionsToSize:CGSizeMake(280, 280*[self imageScale:self.image5])];
        [self.image5 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.image5 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.describe4 withOffset:21];
        [self.describe5 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
        [self.describe5 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.image5 withOffset:21];
    }
    
    if (self.productDictionary[@"image1"]==NULL)
    {
        [self buyButtom2LayoutWithTopView:self.mainDescribe];
    }
    else if (self.productDictionary[@"image2"]==NULL)
    {
        [self buyButtom2LayoutWithTopView:self.describe1];
    }
    else if (self.productDictionary[@"image3"]==NULL)
    {
        [self buyButtom2LayoutWithTopView:self.describe2];
    }
    else if(self.productDictionary[@"image4"]==NULL)
    {
        [self buyButtom2LayoutWithTopView:self.describe3];
    }
    else if (self.productDictionary[@"image5"]==NULL)
    {
        [self buyButtom2LayoutWithTopView:self.describe4];
    }
    else
    {
        [self buyButtom2LayoutWithTopView:self.describe5];
    }
}

-(void)buyButtom2LayoutWithTopView:(id)view
{
    [self.buyButton2 autoSetDimensionsToSize:CGSizeMake(175, 40)];
    [self.buyButton2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.productView];
    [self.buyButton2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:view withOffset:15];
    [self.buyButton2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.productView withOffset:-60];
}

-(float)imageScale:(UIImageView*)img
{
    return (img.image.size.height/img.image.size.width);
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

-(UIImageView *)cloudView
{
    if (!_cloudView)
    {
        _cloudView = [[UIImageView alloc]initForAutoLayout];
        _cloudView.image = [UIImage imageNamed:@"material_bg_cloud"];
    }

    return _cloudView;
}

-(UIImageView *)mainImage
{
    if (!_mainImage)
    {
        _mainImage = [[UIImageView alloc]initForAutoLayout];
        [_mainImage sd_setImageWithURL:[self.productDictionary[@"mainImage"] url]
                      placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                               options:0
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];
    }
    return _mainImage;
}

-(UIButton *)buyButton
{
    if (!_buyButton)
    {
        _buyButton=[[UIButton alloc]initForAutoLayout];
        [_buyButton setImage:[UIImage imageNamed:@"material_btn_buynow"] forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

-(UILabel *)productName
{
    if (!_productName)
    {
        _productName = [[UILabel alloc]initForAutoLayout];
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.preferredMaxLayoutWidth = 320;
        _productName.text = self.productDictionary[@"name"];
        _productName.font = [UIFont fontWithName:fDFPHeiLight_B5 size:26];
        _productName.textColor = [UIColor colorWithHexString:@"#4E4D4D"];
        [_productName sizeToFit];
    }
    return _productName;
}

-(UILabel *)price
{
    if (!_price)
    {
        _price = [[UILabel alloc]initForAutoLayout];
        _price.textAlignment = NSTextAlignmentCenter;
        _price.preferredMaxLayoutWidth = 320;
        _price.font = [UIFont fontWithName:fApple_LiGothic size:18];
        
        NSMutableAttributedString* priceString = [[NSMutableAttributedString alloc]initWithString:[[NSString alloc]initWithFormat:@"特價優惠：%@",self.productDictionary[@"price"]]];
    
        [priceString addAttribute:NSFontAttributeName
                            value: [UIFont fontWithName:fApple_LiGothic size:18]
                            range:NSMakeRange(0, 5)];
        
        [priceString addAttribute:NSFontAttributeName
                            value: [UIFont fontWithName:fApple_LiGothic size:18]
                            range:NSMakeRange(5, [priceString length]-5)];
        
        [priceString addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:NSMakeRange(5, [priceString length]-5)];
        
        _price.attributedText = priceString;
    }
    return _price;
}

-(UILabel *)mainDescribe
{
    if (!_mainDescribe)
    {
        _mainDescribe = [[UILabel alloc]initForAutoLayout];
        _mainDescribe.numberOfLines = 0;
        _mainDescribe.lineBreakMode = NSLineBreakByWordWrapping;
        _mainDescribe.textAlignment = NSTextAlignmentLeft;
        _mainDescribe.preferredMaxLayoutWidth = 280;
        _mainDescribe.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _mainDescribe.text = self.productDictionary[@"mainDescribe"];
        [_mainDescribe sizeToFit];
    }
    return _mainDescribe;
}

-(UIImageView *)image1
{
    if (!_image1)
    {
        _image1 = [[UIImageView alloc]initForAutoLayout];
        [_image1 sd_setImageWithURL:[self.productDictionary[@"image1"] url]
                   placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                            options:0
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];

        _image1.backgroundColor = [UIColor whiteColor];
        
    }
    return _image1;
}

-(UILabel *)describe1
{
    if (!_describe1)
    {
        _describe1 = [[UILabel alloc]initForAutoLayout];
        _describe1.numberOfLines = 0;
        _describe1.lineBreakMode = NSLineBreakByWordWrapping;
        _describe1.textAlignment = NSTextAlignmentLeft;
        _describe1.preferredMaxLayoutWidth = 280;
        _describe1.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _describe1.text = self.productDictionary[@"describe1"];
        [_describe1 sizeToFit];
    }
    return _describe1;
}

-(UIImageView *)image2
{
    if (!_image2)
    {
        _image2 = [[UIImageView alloc]initForAutoLayout];
        [_image2 sd_setImageWithURL:[self.productDictionary[@"image2"] url]
                   placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                            options:0
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
            {
                [super updateViewConstraints];
            }];

        _image2.backgroundColor = [UIColor whiteColor];
        
    }
    return _image2;
}

-(UILabel *)describe2
{
    if (!_describe2)
    {
        _describe2 = [[UILabel alloc]initForAutoLayout];
        _describe2.numberOfLines = 0;
        _describe2.lineBreakMode = NSLineBreakByWordWrapping;
        _describe2.textAlignment = NSTextAlignmentLeft;
        _describe2.preferredMaxLayoutWidth = 280;
        _describe2.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _describe2.text = self.productDictionary[@"describe2"];
        [_describe2 sizeToFit];
    }
    return _describe2;
}

-(UIImageView *)image3
{
    if (!_image3)
    {
        _image3 = [[UIImageView alloc]initForAutoLayout];
        [_image3 sd_setImageWithURL:[self.productDictionary[@"image3"] url]
                   placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                            options:0
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];
        
        _image3.backgroundColor = [UIColor whiteColor];
        
    }
    return _image3;
}

-(UILabel *)describe3
{
    if (!_describe3)
    {
        _describe3 = [[UILabel alloc]initForAutoLayout];
        _describe3.numberOfLines = 0;
        _describe3.lineBreakMode = NSLineBreakByWordWrapping;
        _describe3.textAlignment = NSTextAlignmentLeft;
        _describe3.preferredMaxLayoutWidth = 280;
        _describe3.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _describe3.text = self.productDictionary[@"describe3"];
        [_describe3 sizeToFit];
    }
    return _describe3;
}

-(UIImageView *)image4
{
    if (!_image4)
    {
        _image4 = [[UIImageView alloc]initForAutoLayout];
        [_image4 sd_setImageWithURL:[self.productDictionary[@"image4"] url]
                   placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                            options:0
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];
        
        _image4.backgroundColor = [UIColor whiteColor];
        
    }
    return _image4;
}

-(UILabel *)describe4
{
    if (!_describe4)
    {
        _describe4 = [[UILabel alloc]initForAutoLayout];
        _describe4.numberOfLines = 0;
        _describe4.lineBreakMode = NSLineBreakByWordWrapping;
        _describe4.textAlignment = NSTextAlignmentLeft;
        _describe4.preferredMaxLayoutWidth = 280;
        _describe4.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _describe4.text = self.productDictionary[@"describe4"];
        [_describe4 sizeToFit];
    }
    return _describe4;
}

-(UIImageView *)image5
{
    if (!_image5)
    {
        _image5 = [[UIImageView alloc]initForAutoLayout];
        [_image5 sd_setImageWithURL:[self.productDictionary[@"image5"] url]
                   placeholderImage:[UIImage imageNamed:@"04_material_bg_loadingback"]
                            options:0
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
             [super updateViewConstraints];
         }];
        
        _image5.backgroundColor = [UIColor whiteColor];
    }
    return _image5;
}

-(UILabel *)describe5
{
    if (!_describe5)
    {
        _describe5 = [[UILabel alloc]initForAutoLayout];
        _describe5.numberOfLines = 0;
        _describe5.lineBreakMode = NSLineBreakByWordWrapping;
        _describe5.textAlignment = NSTextAlignmentLeft;
        _describe5.preferredMaxLayoutWidth = 280;
        _describe5.font = [UIFont fontWithName:fApple_LiGothic size:16];
        _describe5.text = self.productDictionary[@"describe5"];
        [_describe5 sizeToFit];
    }
    return _describe5;
}

-(UIButton *)buyButton2
{
    if (!_buyButton2)
    {
        _buyButton2=[[UIButton alloc]initForAutoLayout];
        [_buyButton2 setImage:[UIImage imageNamed:@"material_btn_buynow"] forState:UIControlStateNormal];
        [_buyButton2 addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton2;
}



@end
