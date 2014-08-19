//
//  LoginViewController.m
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "LoginViewController.h"
#import "FBLoginModel.h"
#import "MainViewController.h"

#import "EAIntroView.h"

#import "RewardModel.h"

@interface LoginViewController ()<FBLoginModelDelegate,RewardModelDelegate,EAIntroDelegate>
- (IBAction)loginButton:(id)sender;

@property (nonatomic) FBLoginModel* fbLoginModel;
@property (nonatomic) MBProgressHUD* fbLoginHUD;


@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MSDynamicsDrawerViewController *dynamicsDrawerViewController = (MSDynamicsDrawerViewController *)self.navigationController.parentViewController;
    [dynamicsDrawerViewController setPaneDragRevealEnabled:NO forDirection:MSDynamicsDrawerDirectionLeft];

    //[rewardModel saveNewRewardWithData:@{@"rewardDate":[NSDate date]}];
    //[rewardModel saveNewRewardWithData:@{@"rewardDate":[[NSDate alloc]initWithTimeIntervalSinceNow:-24*60*60]}];
    //[rewardModel saveNewRewardWithData:@{@"rewardDate":[[NSDate alloc]initWithTimeIntervalSinceNow:-48*60*60]}];
    
    //NSLog(@"Reward Entity %@ ,Entities count: %lu",[Reward MR_findAll],[Reward MR_countOfEntities]);
    
    // basic
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"lalalalalalalalal";
    // custom
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.titleFont = [UIFont fontWithName:@"Georgia-BoldItalic" size:20];
    page2.titlePositionY = 220;
    page2.desc = @"heheheheheheheheh";
    page2.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
    page2.descPositionY = 200;
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    page2.titleIconPositionY = 100;
    // custom view from nib
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:[[UIView alloc]init]];
//    page3.bgImage = [UIImage imageNamed:@"bg2"];
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
    
}

-(void)didSavedRewardData
{
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginButton:(id)sender
{
    [self.fbLoginModel FBLogin];
    [self.fbLoginHUD show:YES];

}

#pragma mark- property initialization
-(FBLoginModel *)fbLoginModel
{
    if (!_fbLoginModel)
    {
        _fbLoginModel=[[FBLoginModel alloc]init];
        _fbLoginModel.delegate=self;
    }
    return _fbLoginModel;
}

-(void)didLoginFB
{
    NSLog(@"did Login with facebook");
    
    //Fetch data
    
}

-(void)failToLoginFB:(NSError *)error
{
    NSLog(@"errorerrorerror%@",error);
    [self alertViewWithError:[NSString stringWithFormat:@"Fail to login to fb: %@",error]];
    [self.fbLoginHUD hide:YES];
}

-(void)didFetchProfile:(id)FBprofile
{
    [self.fbLoginHUD hide:YES];
    //NSLog(@"did Fetch profile : %@",FBprofile);
    
    //send data to main view controller and go to the main viewController
    [self performSegueWithIdentifier:@"toMainSeque" sender:nil];
}

-(void)failToFetchProfile:(NSError *)error
{
    NSLog(@"Fail to fetch profile");
    [self alertViewWithError:[NSString stringWithFormat:@"Fail to fetch profile: %@",error]];
}

-(MBProgressHUD *)fbLoginHUD
{
    if (!_fbLoginHUD)
    {
        _fbLoginHUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _fbLoginHUD.mode=MBProgressHUDModeIndeterminate;
        _fbLoginHUD.labelText=@"登入中";
    }
    return _fbLoginHUD;
}

-(void)alertViewWithError:(NSString*)error
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Opps!!" andMessage:error];
    
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {}];
    [alertView show];
}


@end
