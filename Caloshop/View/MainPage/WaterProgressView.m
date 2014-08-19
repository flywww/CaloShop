//
//  WaterProgressView.m
//  Caloshop
//
//  Created by 林盈志 on 8/14/14.
//  Copyright (c) 2014 林盈志. All rights reserved.
//

#import "WaterProgressView.h"
#import "UICountingLabel.h"



@interface WaterProgressView ()
{
    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    
    float a;
    float b;
    
    BOOL jia;
    
    float currentLinePointY;
    float oldLinePointY;
    CGRect ViewFrame;
    
    float waterViewDiameter;
    
    float currentProgress;
    float oldProgress;
}

@property (nonatomic) UILabel* progressLebel;
@property (nonatomic) UITapGestureRecognizer* waterViewTap;

@end

@implementation WaterProgressView

- (id)init
{
    self = [super init];
    if (self)
    {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        //Water view Setting
        
        waterViewDiameter = 250;
        
        a = 1.5;
        b = 0;
        jia = NO;
        currentLinePointY = waterViewDiameter;
        oldLinePointY = waterViewDiameter;
        currentProgress = 0;
        oldProgress = 0;

        self.clipsToBounds=YES;
        self.layer.cornerRadius = waterViewDiameter/2;
        self.currentWaterColor = [UIColor colorWithHexString:@"#6bc2af"];

        
        [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
        [self addSubview:self.productImg];
        [self addSubview:self.progressLebel];
        [self addGestureRecognizer:self.waterViewTap];
        
    }
    return self;
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.productImg autoSetDimensionsToSize:CGSizeMake(waterViewDiameter, waterViewDiameter)];
    [self.productImg autoCenterInSuperview];
    
    [self.progressLebel autoSetDimensionsToSize:CGSizeMake(waterViewDiameter, waterViewDiameter)];
    [self.progressLebel autoCenterInSuperview];
    
}

-(UITapGestureRecognizer *)waterViewTap
{
    if (!_waterViewTap)
    {
        _waterViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction)];
    }
    
    return _waterViewTap;
}



-(void)TapAction
{
    if ([self.delegate respondsToSelector:@selector(didTapAction)])
    {
        [self.delegate didTapAction];
    }
    else
    {
        NSLog(@"Tap Action");
    }
}


-(UIImageView *)productImg
{
    if (!_productImg)
    {
        _productImg = [[UIImageView alloc]initForAutoLayout];
    
    }
    
    return _productImg;
}

-(UILabel *)progressLebel
{
    if (!_progressLebel)
    {
        _progressLebel =[[UILabel alloc]initForAutoLayout];
        _progressLebel.textColor = self.currentWaterColor;
        //_progressLebel.text = @"0";
        _progressLebel.font = [UIFont fontWithName:@"Arial" size:80];
        _progressLebel.textAlignment = NSTextAlignmentCenter;
        _progressLebel.layer.shadowColor = [UIColor blackColor].CGColor;
        _progressLebel.layer.shadowRadius =2.0f;
        _progressLebel.layer.shadowOpacity = 0.7;
        _progressLebel.layer.shadowOffset = CGSizeZero;
        _progressLebel.layer.masksToBounds = NO;
        _progressLebel.attributedText  = [self progressStringWithProgress:0.0f];
        
    }
    return _progressLebel;
}


-(NSMutableAttributedString*) progressStringWithProgress:(float)progress
{
    
    NSString* numberString = [[NSString alloc]initWithFormat:@"%ld",(long)(progress*100)];
    NSMutableAttributedString* percentString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %%",numberString]];
    NSUInteger percentDigit = [numberString length];
    
    //NSLog(@"%@",[NSString stringWithFormat:@"%@ %%",numberString]);
    //NSLog(@"%lu",(unsigned long)percentDigit);
        
    [percentString addAttribute: NSFontAttributeName
                          value:  [UIFont fontWithName:@"Arial" size:80]
                          range: NSMakeRange(0,percentDigit)];
    
    [percentString addAttribute: NSFontAttributeName
                          value:  [UIFont fontWithName:@"Arial" size:30]
                          range: NSMakeRange(percentDigit,1)];
    
    [percentString addAttribute: NSFontAttributeName
                          value:  [UIFont fontWithName:@"Arial" size:30]
                          range: NSMakeRange(percentDigit+1,1)];
    
    return percentString;
}


#pragma mark - waterProgress

//Old progress and new progress
-(void)setProgress:(CGFloat)progress
{
    currentProgress = progress;
    currentLinePointY = waterViewDiameter * (1 - progress);
    
}

-(void)animateWave
{
    if (jia)
    {
        a += 0.1;
    }else
    {
        a -= 0.1;
    }
    
    if (a<=2)
    {
        jia = YES;
    }
    
    if (a>=3)
    {
        jia = NO;
    }
    
    if (oldLinePointY>currentLinePointY)
    {
        oldLinePointY -= 2.5;
    }
    
    if (oldProgress<currentProgress)
    {
        oldProgress+=0.01;
        self.progressLebel.attributedText  = [self progressStringWithProgress:oldProgress];
    }
    

    b+=0.12;
    
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //Draw the water view
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [self.currentWaterColor CGColor]);
    
    
    float y= oldLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=320;x++)
    {
        y= a * sin( x/180*M_PI + 4*b/M_PI ) * 5 + oldLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, 320, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, oldLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    //Draw white circle
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 17);
    CGContextAddArc(context, waterViewDiameter/2, waterViewDiameter/2, waterViewDiameter/2, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
    //Draw green circle
    CGContextSetStrokeColorWithColor(context, self.currentWaterColor.CGColor);
    CGContextSetLineWidth(context, 1.5);
    CGContextAddArc(context, waterViewDiameter/2, waterViewDiameter/2, waterViewDiameter/2 - 5, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
