//
//  ProfilePageViewController.m
//  Caloshop
//
//  Created by 林盈志 on 8/13/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "ProfilePageViewController.h"
#import "MainViewController.h"

//Tutorial and FB login
#import "EAIntroView.h"
#import "TutorialView.h"
#import "FBLoginModel.h"

NSString* birthday = @"1985年09月10日";
NSString* height = @"174公分";
NSString* weight = @"63公斤";

NSString* titleText = @"請輸入您的資料";
NSString* describeText = @"初次使用CaloShop卡路里販賣店\n我們需要您的資料讓計算更精準\n請放心我們不會將此資訊用於其它用途";

@interface ProfilePageViewController ()<FBLoginModelDelegate,EAIntroDelegate,TutorialViewDelegate>
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

//Side page setting
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
//Tutorial property
@property (nonatomic) FBLoginModel* fbLoginModel;
@property (nonatomic) MBProgressHUD* fbLoginHUD;
@property (nonatomic) EAIntroView* tutorialView;
//Profile property
@property (nonatomic) UISegmentedControl* sexSelector;
@property (nonatomic) UIDatePicker* birthdaySelector;
@property (nonatomic) UIPickerView* weightSelector;
@property (nonatomic) UIPickerView* heightSelector;

@property (nonatomic) UITextField* birthdayField;
@property (nonatomic) UITextField* weightField;
@property (nonatomic) UITextField* heightField;

@property (nonatomic) UILabel* profileTitle;
@property (nonatomic) UILabel* profileDescribe;
//Other
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@end

@implementation ProfilePageViewController

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
    
    
    
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone
                                                                       target:self action:@selector(completeTapAction)];
    NSDictionary* attr = @{NSFontAttributeName:[UIFont fontWithName:fApple_LiGothic size:20]};
    [self.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    
    [self.view addSubview:self.profileTitle];
    [self.view addSubview:self.profileDescribe];
    [self.view addSubview:self.sexSelector];
//    [self.view addSubview:self.birthdaySelector];
//    [self.view addSubview:self.heightSelector];
//    [self.view addSubview:self.weightSelector];
    
    [self.view addSubview:self.birthdayField];
    [self.view addSubview:self.weightField];
    [self.view addSubview:self.heightField];
    
    
    //First login show tutorail
    if (![PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        [self.tutorialView showInView:self.navigationController.view animateDuration:0.3];
    }
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.profileTitle autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.profileTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:50];
    
    [self.profileDescribe autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.profileDescribe autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.profileTitle withOffset:18];
    
    [self.sexSelector autoSetDimensionsToSize:CGSizeMake(240, 80)];
    [self.sexSelector autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.sexSelector autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.profileDescribe withOffset:28];
    
    [self.birthdayField autoSetDimensionsToSize:CGSizeMake(240, 60)];
    [self.birthdayField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.birthdayField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sexSelector withOffset:20];

    [self.weightField autoSetDimensionsToSize:CGSizeMake(240, 60)];
    [self.weightField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.weightField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.birthdayField withOffset:-1];
    
    [self.heightField autoSetDimensionsToSize:CGSizeMake(240, 60)];
    [self.heightField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.heightField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.weightField withOffset:-1];
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

//Setting Complete
-(void)completeTapAction
{
    NSLog(@"setting done");
    MainViewController* MainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
    [self.dynamicsDrawerViewController setPaneViewController:MainViewController animated:YES completion:nil];
    
}
-(void)buttomClickAction
{
    [self.fbLoginModel FBLogin];
    [self.fbLoginHUD show:YES];
}


-(void)didFetchProfile:(id)FBprofile
{
    [self.fbLoginHUD hide:YES];
    [self.tutorialView hideWithFadeOutDuration:1.0f];
}

//Sex selected!!
-(void)whichSex:(UISegmentedControl *)paramSender
{
    if ([paramSender isEqual:self.sexSelector])
    {
        NSLog(@"sex = %ld", (long)[paramSender selectedSegmentIndex]);
        if ((long)[paramSender selectedSegmentIndex] == 1)
        {
            
        }
        else if ((long)[paramSender selectedSegmentIndex] == 2)
        {
            
        }
    }
}



#pragma mark - error handler
-(void)failToFetchProfile:(NSError *)error
{
    
    
}

-(void)failToLoginFB:(NSError *)error
{
    
    
}

#pragma mark - property initialization
-(FBLoginModel *)fbLoginModel
{
    if (!_fbLoginModel)
    {
        _fbLoginModel=[[FBLoginModel alloc]init];
        _fbLoginModel.delegate=self;
    }
    return _fbLoginModel;
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


-(UILabel*)profileTitle
{
    if (!_profileTitle)
    {
        _profileTitle = [[UILabel alloc]initForAutoLayout];
        _profileTitle.textAlignment = NSTextAlignmentCenter;
        _profileTitle.font = [UIFont fontWithName:fApple_LiGothic size:18];
        _profileTitle.textColor = [UIColor colorWithHexString:@"#3E3A39"];
        _profileTitle.text = titleText;
    }
    return _profileTitle;
}

-(UILabel *)profileDescribe
{
    if (!_profileDescribe)
    {
        _profileDescribe = [[UILabel alloc]initForAutoLayout];
        _profileDescribe.textAlignment = NSTextAlignmentCenter;
        _profileDescribe.lineBreakMode = NSLineBreakByWordWrapping;
        _profileDescribe.numberOfLines = 0;
        _profileDescribe.font = [UIFont fontWithName:fApple_LiGothic size:18];
        _profileDescribe.textColor = [UIColor colorWithHexString:@"#727171"];
        _profileDescribe.alpha = 0.5;
        _profileDescribe.text = describeText;
        
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        paragrahStyle.lineSpacing = 4;
        paragrahStyle.alignment = NSTextAlignmentCenter;
        NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragrahStyle};
        _profileDescribe.attributedText = [[NSAttributedString alloc] initWithString:describeText
                                                                   attributes:attributtes];
    }
    return _profileDescribe;
}

-(UISegmentedControl *)sexSelector
{
    if(!_sexSelector)
    {
        NSArray *mySegments = [[NSArray alloc] initWithObjects: @"",@"男",@"女",@"",nil];
        _sexSelector = [[UISegmentedControl alloc]initWithItems:mySegments];
        _sexSelector.layer.cornerRadius = 0.0f;
        _sexSelector.selectedSegmentIndex = 1;
        _sexSelector.tintColor = [UIColor colorWithHexString:@"#727171"];
        
        NSDictionary *deselectedAttrs = @{NSFontAttributeName : [UIFont fontWithName:fApple_LiGothic size:20]};
        NSDictionary *selectedAttrs = @{NSFontAttributeName : [UIFont fontWithName:fApple_LiGothic size:20],
                                        NSForegroundColorAttributeName : [UIColor whiteColor]};
        [_sexSelector setTitleTextAttributes:deselectedAttrs forState:UIControlStateNormal];
        [_sexSelector setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        [_sexSelector addTarget:self
                         action:@selector(whichSex:)
               forControlEvents:UIControlEventValueChanged];
        [_sexSelector setWidth:0 forSegmentAtIndex:0];
        [_sexSelector setWidth:118.5 forSegmentAtIndex:1];
        [_sexSelector setWidth:118.5 forSegmentAtIndex:2];
        [_sexSelector setWidth:0 forSegmentAtIndex:3];
        
        _sexSelector.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _sexSelector;
}

-(UITextField *)birthdayField
{
    if (!_birthdayField)
    {
        _birthdayField = [[UITextField alloc]initForAutoLayout];
        _birthdayField.textAlignment = NSTextAlignmentCenter;
        _birthdayField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _birthdayField.textColor = [UIColor colorWithHexString:@"#727171"];
        _birthdayField.text = birthday;
        _birthdayField.borderStyle = UITextBorderStyleLine;
        _birthdayField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _birthdayField.layer.borderWidth=1.0;
        
//        NSMutableAttributedString* String = [[NSMutableAttributedString alloc]initWithString:@"1985年09月10日"];
//        
//        NSDictionary *attrs = @{NSFontAttributeName : [UIFont fontWithName:fApple_LiGothic size:20],
//                    NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#898989"]};
//        
//        [String addAttributes:attrs range:NSMakeRange(0, 4)];
//        [String addAttributes:attrs range:NSMakeRange(5, 2)];
//        [String addAttributes:attrs range:NSMakeRange(8, 2)];
//        
//        attrs = @{NSFontAttributeName : [UIFont fontWithName:fApple_LiGothic size:20],
//                  NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#727171"]};
//    
//        [String addAttributes:attrs range:NSMakeRange(4, 1)];
//        [String addAttributes:attrs range:NSMakeRange(7, 1)];
//        [String addAttributes:attrs range:NSMakeRange(10,1)];
//        _birthdayField.attributedText = String;
    }
    return _birthdayField;
}

-(UITextField *)weightField
{
    if (!_weightField)
    {
        _weightField = [[UITextField alloc]initForAutoLayout];
        _weightField.textAlignment = NSTextAlignmentCenter;
        _weightField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _weightField.textColor = [UIColor colorWithHexString:@"#727171"];
        _weightField.text = weight;
        _weightField.borderStyle = UITextBorderStyleLine;
        _weightField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _weightField.layer.borderWidth=1.0;
    }
    return _weightField;
}

-(UITextField *)heightField
{
    if (!_heightField)
    {
        _heightField = [[UITextField alloc]initForAutoLayout];
        _heightField.textAlignment = NSTextAlignmentCenter;
        _heightField.font = [UIFont fontWithName:fApple_LiGothic size:20];
        _heightField.textColor = [UIColor colorWithHexString:@"#727171"];
        _heightField.text = height;
        _heightField.borderStyle = UITextBorderStyleLine;
        _heightField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _heightField.layer.borderWidth=1.0;
    }
    return _heightField;
}

-(UIDatePicker *)birthdaySelector
{
    if (!_birthdaySelector)
    {
        _birthdaySelector = [[UIDatePicker alloc]initForAutoLayout];
    }
    return _birthdaySelector;
}
-(UIPickerView *)heightSelector
{
    if (!_heightSelector)
    {
        _heightSelector = [[UIPickerView alloc]initForAutoLayout];
    }
    
    return _heightSelector;
}

-(UIPickerView *)weightSelector
{
    if (!_weightSelector)
    {
        _weightSelector = [[UIPickerView alloc]initForAutoLayout];
    }
    return _weightSelector;
}


@end
