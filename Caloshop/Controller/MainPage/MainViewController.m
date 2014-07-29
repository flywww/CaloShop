//
//  MainViewController.m
//  Caloshop
//
//  Created by 林盈志 on 7/24/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "MainViewController.h"
#import <UIImageView+WebCache.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avataImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *update_time;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //set profile to side view
    //download reward from parse
    //send reward data to next page
    
    //資料庫格式設計好
    //建立資料庫
    //下載當日商品
    //顯示到View
    //上傳訂單
    
    [self profileDataShow];
}

-(void)profileDataShow
{
    Profile* profile =[Profile MR_findFirst];
    [self.avataImage setImageWithURL:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",profile.fbID]
                    placeholderImage:[UIImage imageNamed:@"EmptyImage"]
                             options:SDWebImageRefreshCached];
    self.name.text=profile.fbname;
    self.birthday.text=profile.birthday;
    self.gender.text=profile.gender;
    self.update_time.text=profile.updated_time;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
