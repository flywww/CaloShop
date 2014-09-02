//
//  MainViewController.m
//  Caloshop
//
//  Created by 林盈志 on 7/24/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "MainViewController.h"
#import "SidePageViewController.h"
#import "ProductPageViewController.h"

#import <UIImageView+WebCache.h>
#import "RewardModel.h"

#import "WaterProgressView.h"
#import "WaterCircleView.h"

#import "CaloAndStepShowView.h"

#import "PopViewController.h"
#import <MZFormSheetController.h>

@interface MainViewController ()<RewardModelDelegate,WaterViewDelegate,MZFormSheetBackgroundWindowDelegate>
//Side page setting
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
//Reward Model
@property (nonatomic) RewardModel* rewardModel;
@property (nonatomic) WaterProgressView* waterProgressView;
@property (nonatomic) CaloAndStepShowView* caloAndStepsDisplay;

//Main Controller View
@property (nonatomic) UIImageView* backgroundImg;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;
@property (nonatomic) WaterCircleView* waterCircle;

//PopView
@property (nonatomic) PopViewController* popView;
@property (nonatomic) MZFormSheetController* popSheet;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainPage_Gear"] style:UIBarButtonItemStyleBordered
                                                                       target:self action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    self.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
    
//    
//    [self mz_presentFormSheetController:self.popSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
//        
//    }];
    
    [self.view addSubview:self.backgroundImg];
    [self.view addSubview:self.waterCircle];
    [self.view addSubview:self.waterProgressView];
    [self.waterProgressView setProgress:0.73];
    
    [self.view addSubview:self.caloAndStepsDisplay];
    [self.caloAndStepsDisplay showViewWithNewCalo:1333 andOldCalo:60 andNewSteps:80313 andOldSteps:700];
    
    [self.view addSubview:self.titleLabel];
    
    
    // if out of date reload viewController
    if (self.productDictionary == nil)
    {
        [self.rewardModel fetchReward:[HelpTool getLocalDateWithOutTime]];
    }
    else
    {
        if ([HelpTool getLocalDateWithOutTime:self.rewardDictionary[@"rewardDate"]] != [HelpTool getLocalDateWithOutTime])
        {
            [self.rewardModel fetchReward:[HelpTool getLocalDateWithOutTime]];
        }
    }
}

- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    NSLog(@"dynamicsDrawerRevealLeftBarButtonItemTapped:");
    
    SidePageViewController* sidePageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Side"];
    [sidePageViewController.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.backgroundImg autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.backgroundImg autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:-64];
    
    [self.waterProgressView autoSetDimensionsToSize:CGSizeMake(232.5, 232.5)];
    [self.waterProgressView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.waterProgressView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
    
    [self.waterCircle autoSetDimensionsToSize:CGSizeMake(250, 250)];
    [self.waterCircle autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.waterProgressView];
    [self.waterCircle autoAlignAxis:ALAxisVertical toSameAxisOfView:self.waterProgressView];
    
    [self.caloAndStepsDisplay autoSetDimensionsToSize:CGSizeMake(200, 50)];
    [self.caloAndStepsDisplay autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.caloAndStepsDisplay autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.waterProgressView withOffset:34];
    
    [self.titleLabel autoSetDimensionsToSize:CGSizeMake(320, 30)];
    [self.titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.waterProgressView withOffset:-24];
}


-(void)waterViewDidTapAction
{
    [self performSegueWithIdentifier:@"MainToProductSeg" sender:self.productDictionary];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ProductPageViewController* productPageViewController = (ProductPageViewController*)[segue destinationViewController];
    productPageViewController.productDictionary = (NSDictionary*)sender;
}


-(void)didFetchReward:(NSDictionary *)rewardDetail andProductDetail:(NSDictionary *)productDetail
{
    
    self.productDictionary = productDetail;
    self.rewardDictionary = rewardDetail;
    
    
    [self.waterProgressView.productImg
     sd_setImageWithURL:[self.productDictionary[@"pureImage"] url]
     placeholderImage:[UIImage imageNamed:@"EmptyImage"]
     options:0
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         
     }];
    
}

-(void)failToFetchReward:(NSError *)error
{
    
    
}




#pragma mark - property initialize

-(WaterProgressView *)waterProgressView
{
    if (!_waterProgressView)
    {
        _waterProgressView=[[WaterProgressView alloc]initForAutoLayout];
        _waterProgressView.currentWaterColor=[UIColor whiteColor];
        //_waterProgressView.productImg.image = [UIImage imageNamed:@"ProductPureImg"];

        
        _waterProgressView.delegate= self;
    }
    return _waterProgressView;
}

-(WaterCircleView *)waterCircle
{
    if (!_waterCircle)
    {
        _waterCircle = [[WaterCircleView alloc]initForAutoLayout];

    }
    return _waterCircle;
}
-(RewardModel *)rewardModel
{
    if (!_rewardModel)
    {
        _rewardModel=[[RewardModel alloc]init];
        _rewardModel.delegate=self;
    }
    return _rewardModel;
}

-(CaloAndStepShowView *)caloAndStepsDisplay
{
    if (!_caloAndStepsDisplay)
    {
        _caloAndStepsDisplay = [[CaloAndStepShowView alloc]initForAutoLayout];
    }
    return _caloAndStepsDisplay;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel=[[UILabel alloc]initForAutoLayout];
        _titleLabel.font = [UIFont fontWithName:fDFYuanMedium_B5 size:18];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"今日商品優惠75折";
    }
    return _titleLabel;
}

-(PopViewController *)popView
{
    if (!_popView)
    {
        _popView = [[PopViewController alloc]initWithCategory:PopViewCallSucceed andTitle:self.productDictionary[@"name"]];
        //[_popView.middleBtn addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>
    }
    return  _popView;
}

-(MZFormSheetController *)popSheet
{
    if (!_popSheet)
    {
        _popSheet = [[MZFormSheetController alloc]initWithViewController:self.popView];
        _popSheet.transitionStyle = MZFormSheetTransitionStyleBounce;
        _popSheet.cornerRadius = 0;
        _popSheet.presentedFormSheetSize = CGSizeMake(270, 464);
        _popSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location)
        {
            
        };
        
        _popSheet.shouldCenterVertically = YES;
        _popSheet.shouldDismissOnBackgroundViewTap = YES;
        
        _popSheet.didPresentCompletionHandler = ^(UIViewController *presentedFSViewController)
        {
            
        };
        
        [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
        [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    }
    return _popSheet;
}

-(UIImageView *)backgroundImg
{
    if (!_backgroundImg)
    {
        _backgroundImg = [[UIImageView alloc]initForAutoLayout];
        _backgroundImg.image = [UIImage imageNamed:@"MainPage_BC"];
    }
    
    return _backgroundImg;
}




@end
