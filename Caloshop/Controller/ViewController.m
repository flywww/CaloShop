//
//  ViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/18/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    
    //Navigation Bar
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithHexString:@"#c0e2d7"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                                                      NSFontAttributeName: [UIFont fontWithName:@"Arial" size:24.0f] 
                                                                      }];
    
    self.navigationController.navigationBar.topItem.title=@"CaloShop";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 1)];
    [overlayView setBackgroundColor:[UIColor colorWithHexString:@"#c0e2d7"]];
    [self.navigationController.navigationBar addSubview:overlayView];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
