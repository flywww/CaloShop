//
//  SidePageTableView.m
//  Caloshop
//
//  Created by 林盈志 on 8/19/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "SidePageTableView.h"

@implementation SidePageTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.separatorInset = UIEdgeInsetsZero;
        self.separatorColor = [UIColor clearColor];
        self.scrollEnabled = NO;
        self.rowHeight = 70;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
