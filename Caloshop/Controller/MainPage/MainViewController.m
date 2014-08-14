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
#import "UploadOrderModel.h"

@interface MainViewController ()<RewardModelDelegate, UploadOrderModelDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avataImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *update_time;


@property (weak, nonatomic) IBOutlet UIImageView *pureImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *prodcutName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UITextView *mainDescribe;


- (IBAction)uploadOrder:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *orderName;
@property (weak, nonatomic) IBOutlet UITextField *orderPhone;
@property (weak, nonatomic) IBOutlet UITextField *orderAddress;



@property (nonatomic) RewardModel* rewardModel;
@property (nonatomic) UploadOrderModel* uploadOrderModel;


@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;


@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //set profile to side view
    //download reward from parse
    //send reward data to next page
    
    //上傳訂單
    
    [self.rewardModel fetchReward:[HelpTool getLocalDateWithOutTime]];
    [self profileDataShow];

}


- (IBAction)uploadOrder:(id)sender
{
    
    
}


-(void)didFetchReward:(NSDictionary *)rewardDetail andProductDetail:(NSDictionary *)productDetail
{
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!%@ anddddd %@",rewardDetail,productDetail);
    NSLog(@"uuuuuuuuuuuuurl%@",[productDetail[@"pureImage"] url]);
}

-(void)profileDataShow
{
    Profile* profile =[Profile MR_findFirst];
    NSLog(@"show the profile data  %@",profile);
    NSLog(@"TTTTTTTTTTTTTTT%@",[Reward MR_findAll]);
    
    self.avataImage.image = [UIImage imageWithData:profile.avatar];
    self.name.text        = profile.fbname;
    self.birthday.text    = profile.birthday;
    self.gender.text      = profile.gender;
    self.update_time.text = profile.updated_time;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UploadOrderModel *)uploadOrderModel
{
    if (!_uploadOrderModel)
    {
        _uploadOrderModel=[[UploadOrderModel alloc]init];
        _uploadOrderModel.delegate=self;
    }
    return _uploadOrderModel;
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

@end
