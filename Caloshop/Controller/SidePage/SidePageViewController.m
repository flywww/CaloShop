//
//  SidePageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "SidePageViewController.h"
#import "SidePageTableView.h"
#import "SidePageTableViewCell.h"

#import "MainViewController.h"
#import "ProfilePageViewController.h"
#import "ContactUsPageViewController.h"

#import <MessageUI/MessageUI.h>


@interface SidePageViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic) SidePageTableView* menuTableView;
@property (nonatomic) UIImageView* avatarImg;
@property (nonatomic) UILabel* avatarLabel;

@end

@implementation SidePageViewController

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
    
    [self.view addSubview:self.avatarImg];
    [self.view addSubview:self.avatarLabel];
    [self.view addSubview:self.menuTableView];
    
    NSString* fbURL = @"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1";
    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:fbURL,[PFUser currentUser][@"fbID"]]];
    [self.avatarImg sd_setImageWithURL:pictureURL placeholderImage:[UIImage imageNamed:@"EmptyImage"]];
    
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.avatarImg autoSetDimensionsToSize:CGSizeMake(160, 160)];
    [self.avatarImg autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:75];
    [self.avatarImg autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view withOffset:40];
    
    [self.avatarLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarImg withOffset:15];
    [self.avatarLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.avatarImg];
    
    
    
    [self.menuTableView autoSetDimensionsToSize:CGSizeMake(235, 400)];
    
//    NSDictionary* viewDictionary = @{@"menuTableView": self.menuTableView.viewForBaselineLayout};
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[menuTableView(235)]"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:viewDictionary]];
//     
//     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[menuTableView(400)]"
//                                                                       options:0
//                                                                       metrics:nil
//                                                                         views:viewDictionary]];
    
    [self.menuTableView autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.view];
    [self.menuTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarLabel withOffset:15];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(SidePageTableViewCell *)tableView:(SidePageTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID =@"menuCell";
    SidePageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[SidePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text=@"卡路主頁";
            break;
        case 1:
            cell.textLabel.text=@"個人資料";
            break;
        case 2:
            cell.textLabel.text=@"關於我們";
            break;
    }
    return cell;
}

-(void)tableView:(SidePageTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            
            MainViewController* MainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
            [self.dynamicsDrawerViewController setPaneViewController:MainViewController animated:YES completion:nil];
            break;
        }
            break;
        case 1:
        {
            
            ProfilePageViewController* ProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNav"];
            [self.dynamicsDrawerViewController setPaneViewController:ProfileViewController animated:YES completion:nil];
            break;
        }
            
        case 2:
        {
//            ContactUsPageViewController* ContactUsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsNav"];
//            [self.dynamicsDrawerViewController setPaneViewController:ContactUsViewController animated:YES completion:nil];
            //
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                
                mailer.mailComposeDelegate = self;
                
                [mailer setSubject:@"A Message from MobileTuts+"];
                
                NSArray *toRecipients = [NSArray arrayWithObjects:@"fisrtMail@example.com", @"secondMail@example.com", nil];
                [mailer setToRecipients:toRecipients];
                
//                UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
//                NSData *imageData = UIImagePNGRepresentation(myImage);
//                [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
                
                NSString *emailBody = @"Have you seen the MobileTuts+ web site?";
                [mailer setMessageBody:emailBody isHTML:NO];
                
                [self presentViewController:mailer animated:YES completion:nil];
                
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Your device doesn't support the composer sheet"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
 
            break;
        }
            break;
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(SidePageTableView *)menuTableView
{
    if (!_menuTableView)
    {
        _menuTableView = [[SidePageTableView alloc]initForAutoLayout];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor clearColor];
       
    }
    return _menuTableView;
}

-(UIImageView *)avatarImg
{
    if (!_avatarImg)
    {
        _avatarImg = [[UIImageView alloc]initForAutoLayout];
        _avatarImg.clipsToBounds = YES;
        _avatarImg.backgroundColor = [UIColor clearColor];
        _avatarImg.layer.cornerRadius = 160/2;
        _avatarImg.backgroundColor = [UIColor redColor];
    }
    return _avatarImg;
}

-(UILabel *)avatarLabel
{
    if (!_avatarLabel)
    {
        _avatarLabel = [[UILabel alloc]initForAutoLayout];
        _avatarLabel.text = @"林盈志";
        _avatarLabel.backgroundColor=[UIColor clearColor];
        _avatarLabel.textColor = [UIColor colorWithHexString:@"#595757"];
        _avatarLabel.font = [UIFont fontWithName:@"Apple LiGothic" size:22];
        _avatarLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _avatarLabel;
}

//- (IBAction)test:(id)sender
//{
//    LoginViewController* loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
//    [self.dynamicsDrawerViewController setPaneViewController:loginViewController animated:YES completion:nil];
//    
//}
@end
