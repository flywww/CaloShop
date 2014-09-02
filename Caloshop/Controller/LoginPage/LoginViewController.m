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

#import "TutorialView.h"

#import "EAIntroView.h"

#import "RewardModel.h"

@interface LoginViewController ()<FBLoginModelDelegate,RewardModelDelegate,EAIntroDelegate,TutorialViewDelegate>
{
    EAIntroPage* tutorialPage1;
    EAIntroPage* tutorialPage2;
    EAIntroPage* tutorialPage3;
    EAIntroPage* tutorialPage4;
    
    TutorialView* tutorialPage1View;
    TutorialView* tutorialPage2View;
    TutorialView* tutorialPage3View;
    TutorialView* tutorialPage4View;
}


@property (nonatomic) FBLoginModel* fbLoginModel;
@property (nonatomic) MBProgressHUD* fbLoginHUD;
@property (nonatomic) EAIntroView* tutorialView;

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
    
//    MSDynamicsDrawerViewController *dynamicsDrawerViewController = (MSDynamicsDrawerViewController *)self.navigationController.parentViewController;
//    [dynamicsDrawerViewController setPaneDragRevealEnabled:NO forDirection:MSDynamicsDrawerDirectionLeft];
//
//
//    [self.tutorialView showInView:self.navigationController.view animateDuration:0.3];
    
}



-(EAIntroView *)tutorialView
{
    if (!_tutorialView)
    {
        tutorialPage1View = [[TutorialView alloc]initWithPage:@"page1"];
        tutorialPage1View.delegate = self;
        tutorialPage1 = [EAIntroPage pageWithCustomView:tutorialPage1View];

        tutorialPage2View = [[TutorialView alloc]initWithPage:@"page2"];
        tutorialPage2View.delegate = self;
        tutorialPage2 = [EAIntroPage pageWithCustomView:tutorialPage2View];
        
        tutorialPage3View = [[TutorialView alloc]initWithPage:@"page3"];
        tutorialPage3 = [EAIntroPage pageWithCustomView:tutorialPage3View];
        tutorialPage3View.delegate = self;
        
        tutorialPage4View = [[TutorialView alloc]initWithPage:@"page4"];
        tutorialPage4 = [EAIntroPage pageWithCustomView:tutorialPage4View];
        tutorialPage4View.delegate = self;
        
        _tutorialView =  [[EAIntroView alloc] initWithFrame:self.view.bounds
                                                   andPages:@[tutorialPage1,
                                                              tutorialPage2,
                                                              tutorialPage3,
                                                              tutorialPage4]];
        _tutorialView.pageControlY = 210.0f;
        _tutorialView.skipButton = nil;
        _tutorialView.swipeToExit = NO;
        _tutorialView.backgroundColor = [UIColor whiteColor];
        _tutorialView.bgImage = [UIImage imageNamed:@"01_TutorialPage_backonly"];
        _tutorialView.delegate = self;
        
    }
    return _tutorialView;
}

-(void)buttomClickAction
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
    
    [self.tutorialView hideWithFadeOutDuration:1.0f];
    
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
        _fbLoginHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
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
