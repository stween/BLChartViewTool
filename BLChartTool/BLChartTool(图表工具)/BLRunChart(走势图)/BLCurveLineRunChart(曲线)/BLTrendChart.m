//
//  PYTrendChart.m
//  pyChat
//
//  Created by paykee on 15/12/6.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import "BLTrendChart.h"

#define spaceToLeftAndRight 20.0

#define btnWith 90

#define btnHeight 45

#define btnSpace 10

#define boxWidth (rect.size.width - spaceToLeftAndRight) / 8

#define rowNum 8

@interface BLTrendChart()

@property(nonatomic,strong) NSMutableArray *valueArrR;

@property(nonatomic,strong) NSMutableArray *yValueArr;

@property(nonatomic,strong) NSMutableArray *xValueArr;

@property(nonatomic,strong) NSMutableArray *valueArr;

@property(nonatomic,assign) CGFloat scaleValue;

@property(nonatomic,weak) NSTimer *time;

@property(nonatomic,weak) UIButton *selectBtn;

@property(nonatomic,copy) NSString *currentValue;

@property(nonatomic,weak) UIImageView *imageView;

@property(nonatomic,assign) CGFloat preX;

@property(nonatomic,assign) CGFloat preY;

@property(nonatomic,weak) UIButton *dayBtn;

@property(nonatomic,assign) CGFloat boxHeight;

@end

@implementation BLTrendChart

static int arrIndex = 0;

-(NSMutableArray *)yValueArr{
    if(!_yValueArr){
        _yValueArr = [NSMutableArray array];
    }
    return _yValueArr;
}

-(NSMutableArray *)xValueArr{
    if(!_xValueArr){
        _xValueArr = [NSMutableArray array];
    }
    return _xValueArr;
}

-(NSMutableArray *)valueArr{
    if(!_valueArr){
        _valueArr = [NSMutableArray array];
    }
    return _valueArr;
}

-(void)setValueArray:(NSArray *)valueArray{
    _valueArray = valueArray;
    [self dayBtnClick:self.dayBtn];
}

-(void)setXDialsArray:(NSArray *)xDialsArray{
    _xDialsArray = xDialsArray;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.boxHeight = (frame.size.height - 67 - btnHeight ) / 8;
    }
    return self;
}

-(void)setHaveChange:(NSString *)haveChange{
    _haveChange = haveChange;
    if([_haveChange isEqualToString:@"Y"]){
        [self addMenuBtnWithFrame:self.frame];
    }else{
        self.boxHeight = (self.frame.size.height - 22 - btnHeight ) / 8;
    }
}

-(void)addMenuBtnWithFrame:(CGRect )frame{
    [self addFunBtnWithRect:CGRectMake((frame.size.width - 3 * btnWith - 2 * btnSpace)/2, frame.size.height - 16 - btnHeight, btnWith, btnHeight) andTitle:@"七日" andFunType:@"D"];
    
    [self addFunBtnWithRect:CGRectMake((frame.size.width - 3 * btnWith - 2 * btnSpace)/2 + btnWith, frame.size.height - 16 - btnHeight, btnWith, btnHeight) andTitle:@"一个月" andFunType:@"M"];
    
    [self addFunBtnWithRect:CGRectMake((frame.size.width - 3 * btnWith - 2 * btnSpace)/2 + 2 * btnWith, frame.size.height - 16 - btnHeight, btnWith, btnHeight) andTitle:@"两个月" andFunType:@"SM"];
}

-(void)addFunBtnWithRect:(CGRect)frame andTitle:(NSString *)titleStr andFunType:(NSString *)funType{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"home-btn_hig"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"home_btu_nor"] forState:UIControlStateNormal];
    if([funType isEqualToString:@"D"]){
        [btn addTarget:self action:@selector(dayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.dayBtn = btn;
    }else if([funType isEqualToString:@"M"]){
        [btn addTarget:self action:@selector(monthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn addTarget:self action:@selector(twoMonthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:btn];
}

-(void)drawRect:(CGRect)rect{
   
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    NSString *titleStr = @"每日年华收益率(%)";
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [titleStr drawInRect:CGRectMake(spaceToLeftAndRight, 22,160,22) withAttributes:dict];
    //绘制横坐标
    
    CGContextRef ctrfH = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:0.1]set];
    for (int i = 1 ; i < rowNum; i++) {
        CGContextMoveToPoint(ctrfH, spaceToLeftAndRight, 45 + i * self.boxHeight);
        CGContextAddLineToPoint(ctrfH, rect.size.width - (1 + 0.5) * spaceToLeftAndRight, 45 + i * self.boxHeight);
        
    }
    CGContextStrokePath(ctrfH);
    //绘制Y坐标轴的值
     NSDictionary *valueYDic = @{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]};
    for (int i = 1 ; i < rowNum; i++) {
        if(i >= 1 && i <= rowNum){
            [self.yValueArr[self.yValueArr.count - i] drawInRect:CGRectMake(spaceToLeftAndRight,  45 + (i -1)  * self.boxHeight + 0.2 * self.boxHeight, boxWidth, self.boxHeight) withAttributes:valueYDic];
        }
    }
    //绘制纵坐标
    CGContextRef ctrfV = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:0.1]set];
    for(int i = 1 ; i < 8 ; i++){
        CGContextMoveToPoint(ctrfV, spaceToLeftAndRight + i * boxWidth , 45 + 7 * self.boxHeight);
        CGContextAddLineToPoint(ctrfV, spaceToLeftAndRight + i * boxWidth , 45);
    }
     CGContextStrokePath(ctrfV);
    //绘制X坐标轴的值
     NSDictionary *valueXDic = @{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:13]};
    for (int i = 1 ; i < 8 ; i++){
        [self.xValueArr[i - 1] drawInRect:CGRectMake(spaceToLeftAndRight + i * boxWidth - boxWidth / 3, 45 + 7 * self.boxHeight, boxWidth, self.boxHeight) withAttributes:valueXDic];
    }
    
    //绘制点
    CGContextRef ctrfP = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetShouldAntialias(ctrfP, YES);
    CGContextSetAllowsAntialiasing(ctrfP, YES); //抗锯齿，用不用再说。
    CGContextSetFlatness(ctrfP, 0.1f);
    CGContextSetLineCap(ctrfP, kCGLineCapSquare);
    CGContextSetLineJoin(ctrfP, kCGLineJoinRound);
    CGPathMoveToPoint(path, NULL, spaceToLeftAndRight + boxWidth,  45 + 7 * self.boxHeight);
    
    for(int i = 0 ; i < self.valueArr.count ; i++){
        CGFloat y = (45 + 7 * self.boxHeight) - ([self.valueArr[i] doubleValue] / self.scaleValue - 1.0) * self.boxHeight;
        CGFloat x = spaceToLeftAndRight + (i + 1) * boxWidth;
        if([self.valueArr[i] isEqualToString:self.currentValue]){
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x , y - 30, 0, 30)];
            self.imageView = imageView;
            self.imageView.image = [UIImage imageNamed:@"home_btn_1"];
            [self addSubview:self.imageView];
            [UIView animateWithDuration:0.2 animations:^{
                self.imageView.frame = CGRectMake(x - 20, y - 30, 40, 30);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.imageView.frame = CGRectMake(x - 15, y - 30, 30, 30);
                } completion:^(BOOL finished) {
                    self.imageView.frame = CGRectMake(x - 20, y - 30, 40, 30);
                    UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
                    valueLabel.text = [NSString stringWithFormat:@"%@%%",self.currentValue];
                    valueLabel.font = [UIFont systemFontOfSize:12];
                    valueLabel.textColor = [UIColor whiteColor];
                    valueLabel.textAlignment = NSTextAlignmentCenter;
                    [self.imageView addSubview:valueLabel];
                }];
            }];
        }
        
        if(i == 0){
            CGPathAddLineToPoint(path, NULL, x, y);
        }else{
            CGFloat radius = sqrt((self.preX - x)*(self.preX - x) + (self.preY -y)*(self.preY -y)) / 2;
            CGPathAddArcToPoint(path, NULL, self.preX, self.preY, x, y, radius);
        }
        if(i == self.valueArr.count - 1){
            CGPathAddLineToPoint(path, NULL, x, y);
            CGFloat lastY = 45 + 7 * self.boxHeight;
            CGFloat lastX = spaceToLeftAndRight + (i + 1) * boxWidth;
            CGPathAddLineToPoint(path, NULL, lastX, lastY);
        }
        self.preY = y;
        self.preX = x;
    }
    CGContextStrokePath(ctrfP);
    
    [self drawLinearGradient:ctrfP path:path startColor:self.startColor.CGColor endColor:self.endColor.CGColor];
}

-(void)setValueArrR:(NSMutableArray *)valueArrR{
    _valueArrR = valueArrR;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(animateWithPYChat) userInfo:nil repeats:YES];
    self.time = time;
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSDefaultRunLoopMode];
}


-(void)animateWithPYChat{
    [self.valueArr addObject:self.valueArrR[arrIndex]];
    arrIndex++;
    [self setNeedsDisplay];
    if(arrIndex == self.valueArrR.count){
        [self.time invalidate];
        self.time = nil;
        arrIndex = 0;
    }
}

//绘制渐变
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark ---delegate

-(void)dayBtnClick:(UIButton *)dayBtn{
    self.selectBtn.selected = NO;
    self.selectBtn = dayBtn;
    self.selectBtn.selected = YES;
    [self.time invalidate];
    self.time = nil;
    arrIndex = 0;
    [self removePYChatAllData];
    
    self.valueArrR = [NSMutableArray arrayWithArray:self.valueArray[0]];
    self.currentValue = [self.valueArrR lastObject];
    self.xValueArr = [NSMutableArray arrayWithArray:self.xDialsArray[0]];
    [self getYValueArrWithValueArrR:self.valueArrR];
}

-(void)monthBtnClick:(UIButton *)monthBtn{
    self.selectBtn.selected = NO;
    self.selectBtn = monthBtn;
    self.selectBtn.selected = YES;
    [self.time invalidate];
    self.time = nil;
    arrIndex = 0;
    [self removePYChatAllData];
    
    self.valueArrR = [NSMutableArray arrayWithArray:self.valueArray[1]];
    self.currentValue = [self.valueArrR lastObject];
    self.xValueArr = [NSMutableArray arrayWithArray:self.xDialsArray[1]];
    [self getYValueArrWithValueArrR:self.valueArrR];
}

-(void)twoMonthBtnClick:(UIButton *)twoMonthBtn{
    self.selectBtn.selected = NO;
    self.selectBtn = twoMonthBtn;
    self.selectBtn.selected = YES;
    [self.time invalidate];
    self.time = nil;
    arrIndex = 0;
    [self removePYChatAllData];
    
    self.valueArrR = [NSMutableArray arrayWithArray:self.valueArray[2]];
    self.currentValue = [self.valueArrR lastObject];
    self.xValueArr = [NSMutableArray arrayWithArray:self.xDialsArray[2]];
    [self getYValueArrWithValueArrR:self.valueArrR];
    
}

-(void)getYValueArrWithValueArrR:(NSArray *)valueArr{
    CGFloat maxValue = [self getMaxValueInValueArr:valueArr];
    //等分
    CGFloat scaleValue = (maxValue + (maxValue / (rowNum - 1))) / (rowNum - 1);
    self.scaleValue = scaleValue;
    NSMutableArray *yArr = [NSMutableArray array];
    for (int i = 0 ; i < rowNum ; i++) {
        NSString *valueStr = [NSString stringWithFormat:@"%0.2f",scaleValue * i];
        [yArr addObject:valueStr];
    }
    self.yValueArr = yArr;
}

-(CGFloat)getMaxValueInValueArr:(NSArray *)valueArr{
    CGFloat maxValue = [valueArr[0] floatValue];
    for (int i = 1 ; i < valueArr.count; i++) {
        if(maxValue < [valueArr[i] floatValue]){
            maxValue = [valueArr[i] floatValue];
        }
    }
    return maxValue;
}

-(void)removePYChatAllData{
    [self.valueArrR removeAllObjects];
    [self.valueArr removeAllObjects];
    [self.yValueArr removeAllObjects];
    [self.xValueArr removeAllObjects];
}

@end
