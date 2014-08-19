//
//  MainViewController.m
//  Caloshop
//
//  Created by 林盈志 on 7/24/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "MainViewController.h"
#import <UIImageView+WebCache.h>
#import "RewardModel.h"
#import "WaterProgressView.h"
#import "ProductPageViewController.h"
#import "CaloAndStepShowView.h"

@interface MainViewController ()<RewardModelDelegate,WaterViewDelegate>
//Side page setting
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
//Reward Model
@property (nonatomic) RewardModel* rewardModel;
@property (nonatomic) WaterProgressView* waterProgressView;
@property (nonatomic) CaloAndStepShowView* caloAndStepsDisplay;

@property (nonatomic) UILabel* titleLabel;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#c0e2d7"];


    
    //[self.rewardModel fetchReward:[HelpTool getLocalDateWithOutTime]];
    //[self profileDataShow];
    [self.view addSubview:self.waterProgressView];
    [self.waterProgressView setProgress:0.73];
    
    [self.view addSubview:self.caloAndStepsDisplay];
    [self.caloAndStepsDisplay showViewWithNewCalo:1333 andOldCalo:60 andNewSteps:80313 andOldSteps:700];
    
    [self.view addSubview:self.titleLabel];

}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.waterProgressView autoSetDimensionsToSize:CGSizeMake(250, 250)];
    [self.waterProgressView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.waterProgressView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:100];
    
    [self.caloAndStepsDisplay autoSetDimensionsToSize:CGSizeMake(200, 50)];
    [self.caloAndStepsDisplay autoAlignAxis:ALAxisVertical toSameAxisOfView:self.waterProgressView];
    [self.caloAndStepsDisplay autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.waterProgressView withOffset:17];

    [self.titleLabel autoSetDimensionsToSize:CGSizeMake(320, 30)];
    [self.titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.waterProgressView];
    [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.waterProgressView withOffset:-15];
}

-(WaterProgressView *)waterProgressView
{
    if (!_waterProgressView)
    {
        _waterProgressView=[[WaterProgressView alloc]initForAutoLayout];
        _waterProgressView.currentWaterColor=[UIColor colorWithHexString:@"#6bc2af"];
        _waterProgressView.productImg.image = [UIImage imageNamed:@"ProductPureImg"];
        _waterProgressView.delegate= self;
    }
    return _waterProgressView;
}

-(void)didTapAction
{
    [self performSegueWithIdentifier:@"MainToProductSeg" sender:nil];
}





-(void)didFetchReward:(NSDictionary *)rewardDetail andProductDetail:(NSDictionary *)productDetail
{
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!%@ anddddd %@",rewardDetail,productDetail);
    NSLog(@"uuuuuuuuuuuuurl%@",[productDetail[@"pureImage"] url]);
}

-(void)failToFetchReward:(NSError *)error
{
    
    
}

-(void)profileDataShow
{
    Profile* profile =[Profile MR_findFirst];
    NSLog(@"show the profile data  %@",profile);
    NSLog(@"TTTTTTTTTTTTTTT%@",[Reward MR_findAll]);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _titleLabel.font = [UIFont fontWithName:@"Apple LiGothic" size:22];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"今日商品優惠75折";
    }
    return _titleLabel;
}

@end
