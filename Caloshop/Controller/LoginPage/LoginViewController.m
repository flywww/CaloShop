//
//  LoginViewController.m
//  Caloshop
//
//  Created by 林盈志 on 7/25/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "LoginViewController.h"
#import "FBLoginModel.h"

@interface LoginViewController ()<FBLoginModelDelegate>
- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

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
    // Do any additional setup after loading the view.
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
}

-(void)didFetchProfile:(id)FBprofile
{
    NSLog(@"did Fetch profile : %@",FBprofile);
    [self.fbLoginHUD hide:YES];
    //send data to main view controller and go to the main viewController
}

-(void)failToFetchProfile:(NSError *)error
{
    NSLog(@"Fail to fetch profile");
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



@end
