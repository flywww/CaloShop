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

#import "BioCalculateModel.h"

#import <UICountingLabel.h>

@interface MainViewController ()<RewardModelDelegate,WaterViewDelegate,BioCalculateModelDelegate>

//Reward Model
@property (nonatomic) RewardModel* rewardModel;
@property (nonatomic) WaterProgressView* waterProgressView;
@property (nonatomic) CaloAndStepShowView* caloAndStepsDisplay;

//Main Controller View
@property (nonatomic) UIImageView* backgroundImg;
@property (nonatomic) UILabel* titleLabel;
@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;
@property (nonatomic) WaterCircleView* waterCircle;
@property (nonatomic) UICountingLabel* percentage;

//PopView
@property (nonatomic) PopViewController* popView;
@property (nonatomic) BioCalculateModel* bioCalculationModel;


@property (nonatomic) UILabel* testLabel;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainPage_Gear"] style:UIBarButtonItemStyleBordered
                                                                       target:self action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    self.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
    
    [self.popView pop];
    
    [self.view addSubview:self.backgroundImg];
    [self.view addSubview:self.waterCircle];
    [self.view addSubview:self.waterProgressView];
    [self.view addSubview:self.percentage];
    [self.view addSubview:self.caloAndStepsDisplay];
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.testLabel];
    
    
    [self rewardAndProductFetch];
    
    [self.bioCalculationModel startStepMonitering];
}

-(void)todaysStepsUpdate:(NSInteger)steps
{

    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit
                                    | NSMonthCalendarUnit
                                    | NSDayCalendarUnit
                                               fromDate:now];
    
    NSDate *beginOfDay = [calendar dateFromComponents:components];
    


    static int oldSteps = 0;
    static int oldCals = 0;
    static float oldPercentage = 0;
    int userWeight = (int)[[[[NSUserDefaults alloc]init] stringForKey:UD_Weight] integerValue];
    int userGoal = (int)[[[[NSUserDefaults alloc]init] stringForKey:UD_Goal] integerValue];
    float cals = 0;
    float percentage = 0;
    
    //cals = steps * 0.67/60(mins/step) * 5.5/60 (cals/mins) * userWieght
    cals = (int)steps * userWeight * 5.5 * 0.67 / 3600;
    percentage = cals/userGoal;
    if (percentage>1)
    {
        percentage =1;
    }
    [self.percentage countFrom:oldPercentage*100 to:percentage*100];
    [self.waterProgressView setProgress:percentage];
    [self.caloAndStepsDisplay showViewWithNewCalo:cals andOldCalo:oldCals andNewSteps:(int)steps andOldSteps:oldSteps];
    
    oldPercentage = percentage;
    oldSteps = (int)steps;
    oldCals = cals;
    
    self.testLabel.text = [NSString stringWithFormat:@"%@,\n%@,\n%ld,\n\n%@\n%@ \n%f",[HelpTool getLocalDateWithOutTime],[HelpTool getLocalDate],(long)steps,beginOfDay,now,percentage];
    
}

-(UILabel *)testLabel
{
    if(!_testLabel)
    {
        _testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 320)];
        _testLabel.numberOfLines = 0;
    }
    return _testLabel;
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
    
    [self.percentage autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.waterCircle];
    [self.percentage autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.waterCircle withOffset:-40];
    
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

#pragma mark - reward fetch

-(void)rewardAndProductFetch
{
    
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
-(void)didFetchReward:(NSDictionary *)rewardDetail andProductDetail:(NSDictionary *)productDetail
{
    
    self.productDictionary = productDetail;
    self.rewardDictionary = rewardDetail;
    
    
    [self.waterProgressView.productImg
     sd_setImageWithURL:[self.productDictionary[@"pureImage"] url]
     placeholderImage:[UIImage imageNamed:@"03_MainPage_LoadingBackB"]
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
        _waterProgressView.productImg.image = [UIImage imageNamed:@"03_MainPage_LoadingBackB"];
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

-(UICountingLabel *)percentage
{
    if (!_percentage)
    {
        _percentage = [[UICountingLabel alloc]initForAutoLayout];
        _percentage.font = [UIFont fontWithName:fMyriadPro_It size:30];
        _percentage.textAlignment=NSTextAlignmentLeft;
        _percentage.textColor = [UIColor whiteColor];
        _percentage.text = @"0%";
        _percentage.format=@"%d%%";
        _percentage.method=UILabelCountingMethodEaseInOut;
    }
    return _percentage;
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

-(UIImageView *)backgroundImg
{
    if (!_backgroundImg)
    {
        _backgroundImg = [[UIImageView alloc]initForAutoLayout];
        _backgroundImg.image = [UIImage imageNamed:@"MainPage_BC"];
    }
    
    return _backgroundImg;
}
-(BioCalculateModel *)bioCalculationModel
{
    if (!_bioCalculationModel)
    {
        _bioCalculationModel = [[BioCalculateModel alloc]init];
        _bioCalculationModel.delegate = self;
    }
    return _bioCalculationModel;
}



@end
