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

NSString* titleText = @"請輸入您的資料";
NSString* describeText = @"初次使用CaloShop卡路里販賣店\n我們需要您的資料讓計算更精準\n請放心我們不會將此資訊用於其它用途";

@interface ProfilePageViewController ()<FBLoginModelDelegate,EAIntroDelegate,TutorialViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
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

//Tutorial property
@property (nonatomic) FBLoginModel* fbLoginModel;
@property (nonatomic) MBProgressHUD* fbLoginHUD;
@property (nonatomic) EAIntroView* tutorialView;
//Profile property
@property (nonatomic) NSString* gender;
@property (nonatomic) NSDate* birthday;
@property (nonatomic) NSString* weight;
@property (nonatomic) NSString* height;
@property (nonatomic) NSString* goal;

@property (nonatomic) UISegmentedControl* sexSelector;
@property (nonatomic) UIDatePicker* birthdaySelector;
@property (nonatomic) UIPickerView* weightSelector;
@property (nonatomic) UIPickerView* heightSelector;

@property (nonatomic) UIToolbar *toolBar;

@property (nonatomic) UITextField* birthdayField;
@property (nonatomic) UITextField* weightField;
@property (nonatomic) UITextField* heightField;

@property (nonatomic) UILabel* profileTitle;
@property (nonatomic) UILabel* profileDescribe;
//Picker data
@property (nonatomic) NSMutableArray* weightIntArray;
@property (nonatomic) NSMutableArray* weightDecimalArray;
@property (nonatomic) NSMutableArray* weightUnitArray;
@property (nonatomic) NSMutableArray* heightIntArray;
@property (nonatomic) NSMutableArray* heightDecimalArray;
@property (nonatomic) NSMutableArray* heightUnitArray;

//Other
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic) NSUserDefaults* userDefault;

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
    
    [self PickerDataInit];
    
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone
                                                                       target:self action:@selector(completeTapAction)];
    NSDictionary* attr = @{NSFontAttributeName:[UIFont fontWithName:fApple_LiGothic size:20]};
    [self.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    
    [self profileInit];
    
    [self.view addSubview:self.profileTitle];
    [self.view addSubview:self.profileDescribe];
    [self.view addSubview:self.sexSelector];
    
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

-(void)PickerDataInit
{
    //Weight Data
    self.weightIntArray = [[NSMutableArray alloc]init];
    for (int i = 10; i<=300; i++)
    {
        [self.weightIntArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.weightDecimalArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<=9; i++)
    {
        [self.weightDecimalArray addObject:[NSString stringWithFormat:@".%d",i]];
    }
    self.weightUnitArray = [[NSMutableArray alloc]initWithObjects:@"公斤", nil];
    
    //height Data
    self.heightIntArray = [[NSMutableArray alloc]init];
    for (int i = 80; i<=240; i++)
    {
        [self.heightIntArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.heightDecimalArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<=9; i++)
    {
        [self.heightDecimalArray addObject:[NSString stringWithFormat:@".%d",i]];
    }
    self.heightUnitArray = [[NSMutableArray alloc]initWithObjects:@"公分", nil];
}

-(void)profileInit
{
    self.gender = [self.userDefault stringForKey:UD_Gender];
    self.birthday = [self.userDefault valueForKey:UD_Birthday];
    self.weight = [self.userDefault stringForKey:UD_Weight];
    self.height = [self.userDefault stringForKey:UD_Height];
    
}

#pragma mark - button action
//Setting Complete
-(void)completeTapAction
{
    NSLog(@"setting done");
    MainViewController* MainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNav"];
    [self.dynamicsDrawerViewController setPaneViewController:MainViewController animated:YES completion:nil];
    
    self.goal = @"180";
    
    [PFUser currentUser][@"birthdayReal"] = self.birthday;
    [PFUser currentUser][@"genderReal"] = self.gender;
    [PFUser currentUser][@"weight"] = self.weight;
    [PFUser currentUser][@"height"] = self.height;
    [[PFUser currentUser] saveEventually];
    
    [self.userDefault setObject:self.birthday forKey:UD_Birthday];
    [self.userDefault setObject:self.gender forKey:UD_Gender];
    [self.userDefault setObject:self.weight forKey:UD_Weight];
    [self.userDefault setObject:self.height forKey:UD_Height];
    [self.userDefault setObject:self.goal forKey:UD_Goal];
    [self.userDefault synchronize];
}

-(void)pickerDone:(id)selector
{
    [self.weightField resignFirstResponder];
    self.weightSelector.hidden = YES;
    
    [self.heightField resignFirstResponder];
    self.heightSelector.hidden =YES;
    
    [self.birthdayField resignFirstResponder];
    self.birthdaySelector.hidden = YES;
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
        if ((long)[paramSender selectedSegmentIndex] == 1)
        {
            self.gender =@"male";
        }
        else if ((long)[paramSender selectedSegmentIndex] == 2)
        {
            self.gender =@"female";
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

#pragma mark - tutorial
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
        _tutorialView.pageControlY = 230.0f;
        _tutorialView.skipButton = nil;
        _tutorialView.swipeToExit = NO;
        _tutorialView.backgroundColor = [UIColor whiteColor];
        _tutorialView.bgImage = [UIImage imageNamed:@"01_TutorialPage_backonly"];
        _tutorialView.delegate = self;
    }
    return _tutorialView;
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

-(NSString *)gender
{
    if (!_gender)
    {
        _gender = [[NSString alloc]init];
    }
    return _gender;
}

-(NSDate *)birthday
{
    if (!_birthday)
    {
        _birthday = [[NSDate  alloc]init];
    }
    return _birthday;
}

-(NSString *)weight
{
    if (!_weight)
    {
        _weight = [[NSString alloc]init];
    }
    return _weight;
}

-(NSString *)height
{
    if (!_height)
    {
        _height = [[NSString alloc]init];
    }
    return _height;
}

-(NSString *)goal
{
    if (!_goal)
    {
        _goal = [[NSString alloc]init];
    }
    return _goal;
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
        
        if ([[self.userDefault stringForKey:UD_Gender] isEqualToString:@"male"])
        {
            _sexSelector.selectedSegmentIndex = 1;
        }
        else if ([[self.userDefault stringForKey:UD_Gender] isEqualToString:@"female"])
        {
            _sexSelector.selectedSegmentIndex = 2;
        }
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
        _birthdayField.text = [HelpTool transDateToStringWithDate:[self.userDefault valueForKey:UD_Birthday] andFormate:@"yyyy年MM月dd日"];
        _birthdayField.borderStyle = UITextBorderStyleLine;
        _birthdayField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _birthdayField.layer.borderWidth=1.0;
        _birthdayField.delegate = self;
        _birthdayField.inputView = self.birthdaySelector;
        _birthdayField.inputAccessoryView = self.toolBar;
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
        _weightField.text = [NSString stringWithFormat:@"%@ 公斤",[self.userDefault stringForKey:UD_Weight]];
        _weightField.borderStyle = UITextBorderStyleLine;
        _weightField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _weightField.layer.borderWidth=1.0;
        _weightField.delegate =self;
        _weightField.inputView = self.weightSelector;
        _weightField.inputAccessoryView = self.toolBar;
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
        _heightField.text = [NSString stringWithFormat:@"%@ 公分",[self.userDefault stringForKey:UD_Height]];
        _heightField.borderStyle = UITextBorderStyleLine;
        _heightField.layer.borderColor = [UIColor colorWithHexString:@"#727171"].CGColor;
        _heightField.layer.borderWidth=1.0;
        _heightField.delegate=self;
        _heightField.inputView = self.heightSelector;
        _heightField.inputAccessoryView = self.toolBar;
    }
    return _heightField;
}

-(UIDatePicker *)birthdaySelector
{
    if (!_birthdaySelector)
    {
        NSDate* minDate = [[NSDate alloc]initWithTimeIntervalSinceNow:80*365*24*60*60];
        NSDate* maxDate =[[NSDate alloc]initWithTimeIntervalSinceNow:8*365*24*60*60];
        _birthdaySelector = [[UIDatePicker alloc]init];
        _birthdaySelector.datePickerMode = UIDatePickerModeDate;
        _birthdaySelector.minimumDate = minDate;
        _birthdaySelector.maximumDate = maxDate;
        
        [_birthdaySelector addTarget:self action:@selector(birthdaySelectorValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _birthdaySelector;
}

- (void)birthdaySelectorValueChanged:(UIDatePicker *)sender
{
    self.birthday =  [sender date]; // 獲取被選中的時間
    NSDateFormatter *selectDateFormatter = [[ NSDateFormatter alloc ] init ];
    selectDateFormatter.dateFormat = @"yyyy年MM月dd日"; // 設置時間和日期的格式
    NSString *date = [selectDateFormatter stringFromDate :[sender date]]; // 把date 類型轉為設置好格式的string 類型
    self.birthdayField.text = date;
}

-(UIPickerView *)heightSelector
{
    if (!_heightSelector)
    {
        _heightSelector = [[UIPickerView alloc]init];
        _heightSelector.delegate = self;
        _heightSelector.dataSource = self;
        _heightSelector.showsSelectionIndicator = YES;
        _heightSelector.hidden = YES;
    }
    return _heightSelector;
}

-(UIPickerView *)weightSelector
{
    if (!_weightSelector)
    {
        _weightSelector = [[UIPickerView alloc]init];
        _weightSelector.delegate = self;
        _weightSelector.dataSource = self;
        _weightSelector.showsSelectionIndicator = YES;
        _weightSelector.hidden = YES;
    }
    return _weightSelector;
}

-(UIToolbar *)toolBar
{
    if (!_toolBar)
    {
        _toolBar = [[UIToolbar alloc]initWithFrame:
                    CGRectMake(0, self.view.frame.size.height-
                               _weightSelector.frame.size.height-50, 320, 50)];
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"                                                  "
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                       target:self action:@selector(pickerDone:)];
        
        [_toolBar setBarStyle:UIBarStyleBlack];
        NSArray *toolbarItems = [NSArray arrayWithObjects:button,doneButton, nil];
        [_toolBar setItems:toolbarItems animated:YES];
    }
    return _toolBar;
}

-(NSUserDefaults *)userDefault
{
    if (!_userDefault)
    {
        _userDefault = [[NSUserDefaults alloc]init];
    }
    return _userDefault;
}

#pragma mark - Text field delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.birthdayField])
    {
        self.birthdaySelector.hidden = NO;
    }
    else if ([textField isEqual:self.weightField])
    {
        self.weightSelector.hidden = NO;
    }
    else if([textField isEqual:self.heightField])
    {
        self.heightSelector.hidden = NO;
    }
}
#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([pickerView isEqual:self.birthdaySelector])
    {
        return 1;
    }
    else if ([pickerView isEqual:self.weightSelector])
    {
        return 3;
    }
    else if([pickerView isEqual:self.heightSelector])
    {
        return 3;
    }
    else
    {
        return 0;
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.weightSelector])
    {
        switch (component)
        {
            case 0:
                return [self.weightIntArray count];
                break;
            case 1:
                return [self.weightDecimalArray count];
                break;
            case 2:
                return [self.weightUnitArray count];
            default:
                return 0;
                break;
        }
    }
    else if([pickerView isEqual:self.heightSelector])
    {
        switch (component)
        {
            case 0:
                return [self.heightIntArray count];
                break;
            case 1:
                return [self.heightDecimalArray count];
                break;
            case 2:
                return [self.heightUnitArray count];
            default:
                return 0;
                break;
        }
    }
    else
    {
        return 0;
    }

}

#pragma mark- Picker View Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.weightSelector])
    {
        static long rowInt = 0;
        static long rowDec = 0;
        static long rowUnit = 0;
        switch (component)
        {
            case 0:
                rowInt = row;
                break;
            case 1:
                rowDec = row;
                break;
            case 2:
                rowUnit = row;
                break;
            default:
                break;
        }
        self.weightField.text = [NSString stringWithFormat:@"%@%@%@",[self.weightIntArray objectAtIndex:rowInt],[self.weightDecimalArray objectAtIndex:rowDec],[self.weightUnitArray objectAtIndex:rowUnit]];
        self.weight = [NSString stringWithFormat:@"%@%@",[self.weightIntArray objectAtIndex:rowInt],[self.weightDecimalArray objectAtIndex:rowDec]];
    }
    else if([pickerView isEqual:self.heightSelector])
    {
        static long rowInt = 0;
        static long rowDec = 0;
        static long rowUnit = 0;
        switch (component)
        {
            case 0:
                rowInt = row;
                break;
            case 1:
                rowDec = row;
                break;
            case 2:
                rowUnit = row;
                break;
            default:
                break;
        }
        self.heightField.text = [NSString stringWithFormat:@"%@%@%@",[self.heightIntArray objectAtIndex:rowInt],[self.heightDecimalArray objectAtIndex:rowDec],[self.heightUnitArray objectAtIndex:rowUnit]];
        self.height = [NSString stringWithFormat:@"%@%@",[self.heightIntArray objectAtIndex:rowInt],[self.heightDecimalArray objectAtIndex:rowDec]];
    }
    else
    {
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:self.weightSelector])
    {
        switch (component)
        {
            case 0:
                return [self.weightIntArray objectAtIndex:row];
                break;
            case 1:
                return [self.weightDecimalArray objectAtIndex:row];
                break;
            case 2:
                return [self.weightUnitArray objectAtIndex:row];
            default:
                return 0;
                break;
        }
    }
    else if([pickerView isEqual:self.heightSelector])
    {
        switch (component)
        {
            case 0:
                return [self.heightIntArray objectAtIndex:row];
                break;
            case 1:
                return [self.heightDecimalArray objectAtIndex:row];
                break;
            case 2:
                return [self.heightUnitArray objectAtIndex:row];
            default:
                return 0;
                break;
        }
    }
    else
    {
        return nil;
    }
}



@end
