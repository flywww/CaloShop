//
//  PopViewController.h
//  Caloshop
//
//  Created by 林盈志 on 8/19/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopViewController : UIViewController

-(id)initWithCategory:(NSString*)category andTitle:(NSString*)title;

@property (nonatomic) UIButton* leftBtn;
@property (nonatomic) UIButton* rightBtn;
@property (nonatomic) UIButton* middleBtn;
-(void)pop;

@end
