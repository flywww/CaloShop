//
//  AppDelegate.m
//  Caloshop
//
//  Created by 林盈志 on 7/24/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "AppDelegate.h"

#import "SidePageViewController.h"
#import "MainViewController.h"
#import "ProfilePageViewController.h"

#import "MSDynamicsDrawerViewController.h"
#import "MSDynamicsDrawerStyler.h"



@interface AppDelegate ()<MSDynamicsDrawerViewControllerDelegate>

@property (nonatomic, strong) UIImageView *windowBackground;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //UserDefault
    [self userDefaultSetting];
    
    //Parse Setting
    [Parse setApplicationId:@"dJyY9ZuZ40E6dFYymTcsKOp0j4XCfJgalEXH8xmG" clientKey:@"NrN2KErDUPBhcK7p3CAdoRhhrq7IM0TB730L0Hza"];
    [PFFacebookUtils initializeFacebook];
    
    //is user login with facebook? if true then go to main, or go to login page.
    NSLog(@"Face book log in? %d",[PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]);
    
    //MagicalRecord Setting
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    //SideView Setting
    self.dynamicsDrawerViewController = (MSDynamicsDrawerViewController*) self.window.rootViewController;
    self.dynamicsDrawerViewController.view.backgroundColor = [UIColor colorWithHexString:@"#c0e2d7"];
    self.dynamicsDrawerViewController.delegate = self;
    
    //Add style
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    
    SidePageViewController* SidePageViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"Side"];
    MainViewController* MainViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
    ProfilePageViewController* ProfilePageViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ProfileNav"];
    
    SidePageViewController.dynamicsDrawerViewController = self.dynamicsDrawerViewController;
    
    [self.dynamicsDrawerViewController setDrawerViewController:SidePageViewController forDirection:MSDynamicsDrawerDirectionLeft];
    [self.dynamicsDrawerViewController setRevealWidth:240.0f forDirection:MSDynamicsDrawerDirectionLeft];
    
    //If user already Login go to MainViewController, otherwise goto LoginViewController
    if ([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        [self.dynamicsDrawerViewController setPaneViewController:MainViewController animated:self.dynamicsDrawerViewController.paneViewController!=nil completion:nil];
    }
    else
    {
        [self.dynamicsDrawerViewController setPaneViewController:ProfilePageViewController animated:self.dynamicsDrawerViewController.paneViewController!=nil completion:nil];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController=self.dynamicsDrawerViewController;
    [self.window makeKeyAndVisible];
    //[self.window addSubview:self.windowBackground];
    [self.window sendSubviewToBack:self.windowBackground];
    
    return YES;
}

-(void)userDefaultSetting
{
    NSUserDefaults* userDefault = [[NSUserDefaults alloc]init];

    if (![userDefault valueForKey:UD_Birthday])
    {
        [userDefault setObject:[HelpTool getLocalDate] forKey:UD_Birthday];
    }
    if (![userDefault stringForKey:UD_Gender])
    {
        [userDefault setObject:UD_Gender_init forKey:UD_Gender];
    }
    if (![userDefault stringForKey:UD_Height])
    {
        [userDefault setObject:UD_Height_init forKey:UD_Height];
    }
    if (![userDefault stringForKey:UD_Weight])
    {
        [userDefault setObject:UD_Weight_init forKey:UD_Weight];
    }
    [userDefault synchronize];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}



- (UIImageView *)windowBackground
{
    if (!_windowBackground) {
        //_windowBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Window Background"]];
        
    }
    return _windowBackground;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
