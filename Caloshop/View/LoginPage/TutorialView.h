//
//  TutorialView.h
//  Caloshop
//
//  Created by 林盈志 on 9/1/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TutorialViewDelegate<NSObject>

-(void)buttomClickAction;

@end

@interface TutorialView : UIView

@property (nonatomic, weak) id<TutorialViewDelegate> delegate;

- (id)initWithPage:(NSString*)page;

@end
