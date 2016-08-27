//
//  ChatLine.m
//  走势图绘制
//
//  Created by jinpengyao on 15/8/17.
//  Copyright (c) 2015年 JPY. All rights reserved.
//
#import "BLChatLineView.h"
#import "BLPointBtn.h"
//#define rowNum 3
#define distanceToBtm 30

//#define horizontalSpace 23.5
#define verticalSpace 0.065
#define distanceToLeft 8


@interface BLChatLineView()
/**
 *  间隔数值
 */
@property(nonatomic,assign)CGFloat spaceValue;

@property(nonatomic, strong) NSMutableArray *yValueArr;
//冲动画的值
@property(nonatomic,strong) NSMutableArray *rValueArr;

@property(nonatomic, strong) UIColor *selectColor;

@property(nonatomic, assign) CGFloat horizontalSpace;

@property(nonatomic, assign) int level;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic, assign) NSUInteger maxArrCount;

@property(nonatomic, strong) NSMutableArray *animationArr;

@property(nonatomic, strong) NSMutableArray *subArrIndex;

@end

@implementation BLChatLineView

static int arrIndex = 0;

-(NSMutableArray *)yValueArr{
    if(!_yValueArr){
        self.yValueArr = [NSMutableArray array];
        
    }
    return _yValueArr;
}

-(NSMutableArray *)rValueArr{
    if(!_rValueArr) {
        _rValueArr = [NSMutableArray array];
    }
    return _rValueArr;
}

-(NSMutableArray *)animationArr{
    if(!_animationArr){
        _animationArr = [NSMutableArray array];
        for (int i = 0 ; i < self.dataResource.count; i++) {
            NSMutableArray *subArr = [NSMutableArray array];
            [_animationArr addObject:subArr];
        }
    }
    return _animationArr;
}

-(NSMutableArray *)subArrIndex{
    if(!_subArrIndex){
        _subArrIndex = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    }
    return _subArrIndex;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self drawTableBackGroundWithRect:frame];
    }
    return self;
}

-(void)drawTableBackGroundWithRect:(CGRect )rect{
    //适配机型
    [self autoGetScale];
    //1绘制纵轴
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor lightGrayColor]set];
    NSString *unitYStr = self.unitYStr;
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0]};
    
    [unitYStr drawInRect:CGRectMake(distanceToLeft,0,100,22) withAttributes:attribute];
    
    for (int i = 0 ; i < self.dataResource.count ; i++) {
        [(UIColor *)self.lineColorArr[i] set];
        self.selectColor = (UIColor *)self.lineColorArr[i];
        
        float x = ([self autoGetYearX] + 20) * (i + 1) + 50;
        float y = 8;
        BLPointBtn *showPoint = [[BLPointBtn alloc]initWithFrame:CGRectMake(x - 12, y - 6, 12, 12)];
        [showPoint setBackgroundImage:[UIImage imageNamed:@"circlepoint"] forState:UIControlStateNormal];
        showPoint.backgroundColor = self.selectColor;
        showPoint.layer.cornerRadius = 6;
        showPoint.layer.masksToBounds = YES;
        showPoint.userInteractionEnabled = NO;
        [self addSubview:showPoint];
        [self.yearArr[i] drawInRect:CGRectMake(x + 5 ,0,50,22) withAttributes:attribute];
    }
    
    [[UIColor lightGrayColor]set];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    NSDictionary *attribute1 = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph};
    
    for (int i = 0 ; i < self.yValueArr.count ; i++) {
        [self.yValueArr[i] drawInRect:CGRectMake(distanceToLeft,(self.yValueArr.count - i) * self.horizontalSpace,30,22) withAttributes:attribute1];
    }
    
    //1.1绘制虚线
    for (int i = 0 ; i < self.yValueArr.count ; i++) {
        CGContextMoveToPoint(context, distanceToLeft + 35, (self.yValueArr.count - i) * self.horizontalSpace + 8);
        CGContextAddLineToPoint(context, (self.xValueArr.count + 2.1) * (rect.size.width * verticalSpace), (self.yValueArr.count - i) * self.horizontalSpace + 8);
        //这里为其单独设置虚线
        CGFloat lengths[] = {3,1};
        CGContextSetLineWidth(context, 0.07);
        CGContextSetLineDash(context, 0, lengths, 1);
        CGContextStrokePath(context);
    }
    
    //2绘制横轴
    for (int i = 0 ; i < self.xValueArr.count ; i++) {
        [self.xValueArr[i] drawInRect:CGRectMake((i + 2) * (rect.size.width * verticalSpace),(self.yValueArr.count + 1) * self.horizontalSpace ,30 ,22) withAttributes:attribute];
    }
    NSString *unitXStr = @"(月)";
    [unitXStr drawInRect:CGRectMake((self.xValueArr.count + 2.1) * (rect.size.width * verticalSpace),(self.yValueArr.count + 1) * self.horizontalSpace ,30 ,22) withAttributes:attribute];
}

//绘制图形
- (void)drawRect:(CGRect)rect {
    [self drawTableBackGroundWithRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //3绘制点
    for (int i = 0 ; i < self.animationArr.count ; i++) {
        NSArray *subArr = self.animationArr[i];
        [(UIColor *)self.lineColorArr[i] set];
        self.selectColor = (UIColor *)self.lineColorArr[i];
        
        for (int j = 0 ; j < subArr.count ; j++) {
            float y = (self.yValueArr.count -  [subArr[j] intValue] / (self.spaceValue * self.level) ) * self.horizontalSpace + 7;
            float x =  (j + 2) * (rect.size.width * verticalSpace)+ 5 ;
            BLPointBtn *clickBtn = [[BLPointBtn alloc]initWithFrame:CGRectMake(x - 6, y - 6, 12, 12)];
            [clickBtn setBackgroundImage:[UIImage imageNamed:@"circlepoint"] forState:UIControlStateNormal];
            clickBtn.yearStr = self.yearArr[i];
            clickBtn.valueStr = subArr[j];
            clickBtn.monthStr = [NSString stringWithFormat:@"%d",j + 1];
            [clickBtn addTarget:self action:@selector(pointClick:) forControlEvents:UIControlEventTouchUpInside];
            clickBtn.tag = j;
            clickBtn.backgroundColor = self.selectColor;
            clickBtn.layer.cornerRadius = 6;
            clickBtn.layer.masksToBounds = YES;
            [self addSubview:clickBtn];
        }
        
        //4绘制折线
        for (int j = 0 ; j < subArr.count ; j++) {
            float y = (self.yValueArr.count -  [subArr[j] intValue] / (self.spaceValue * self.level) ) * self.horizontalSpace + 7;
            float x =  (j + 2) * (rect.size.width * verticalSpace)+ 5 ;
            if(j == 0){
                CGContextMoveToPoint(context, x, y);
            }else{
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextSetLineWidth(context, 3.0);
        CGContextSetLineDash(context, 0, 0, 0);
        CGContextStrokePath(context);
    }
}

-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
    [self getYDataArrWithValueArr:_dataResource];
    self.maxArrCount = 0;
    for (int i = 0; i < dataResource.count; i++) {
        NSArray *subArr = dataResource[i];
        if(subArr.count > self.maxArrCount){
            self.maxArrCount = subArr.count;
        }
    }
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.07 target:self selector:@selector(annimationLine) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(void)annimationLine{
    for (int i = 0; i < self.dataResource.count; i++) {
        [self getAnnimationValueWithIndex:i andDataArr:self.dataResource[i]];
    }
    arrIndex++;
    if(arrIndex == self.maxArrCount){
        [self.timer invalidate];
        self.timer = nil;
        arrIndex = 0;
    }
}

-(void)getAnnimationValueWithIndex:(int)index andDataArr:(NSArray *)dataArr{
    if([self.subArrIndex[index] intValue] != dataArr.count){
        [self.animationArr[index] addObject:dataArr[[self.subArrIndex[index] intValue]]];
        self.subArrIndex[index] = [NSString stringWithFormat:@"%d",[self.subArrIndex[index] intValue] + 1] ;
    }
    [self setNeedsDisplay];
}

-(void)getYDataArrWithValueArr:(NSArray *)valueArr{
    //找出所有数组中的最大值与最小值
    int maxValue = 0;
    NSString *minStrValue = self.dataResource[0][0];
    int minValue = [minStrValue intValue];
    for (int i = 0 ; i < self.dataResource.count; i++) {
        NSArray *subArr = self.dataResource[i];
        for (int j = 0 ; j < subArr.count ; j++) {
            int compareValue = [subArr[j] intValue];
            if(maxValue < compareValue){
                maxValue = compareValue;
            }
            if(minValue > compareValue){
                minValue = compareValue;
            }
        }
    }
    
    if((maxValue  / [self getUnitWithMaxValue:maxValue]) / (self.rowNum - 1) == 0){
        self.spaceValue = 1;
    }else{
        self.spaceValue = (maxValue  / [self getUnitWithMaxValue:maxValue]) / (self.rowNum - 1);
    }
    
    int spaceInt = self.spaceValue;
    if(spaceInt == 0){
        spaceInt = 1;
    }
    for (int i = 0 ; i < self.rowNum + 1; i++) {
        NSString *value = [NSString stringWithFormat:@"%d",spaceInt * i];
        [self.yValueArr addObject:value];
    }
}


-(void)pointClick:(BLPointBtn *)clickBtn{
    /**
     *年
     */
    UILabel *yearLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
    yearLable.text = [NSString stringWithFormat:@"%@年%@月",clickBtn.yearStr,clickBtn.monthStr];
    [yearLable sizeToFit];
    /**
     *金额
     */
    UILabel *moneyLable = [[UILabel alloc]init];
    moneyLable.text = [NSString stringWithFormat:@"金额:%@元",clickBtn.valueStr];
    [moneyLable sizeToFit];
    
    UIView *showView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - (yearLable.frame.size.width + moneyLable.frame.size.width) / 2 , 20, yearLable.frame.size.width + moneyLable.frame.size.width , 30)];
    showView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    yearLable.frame = CGRectMake(0, 0, yearLable.frame.size.width, 30);
    moneyLable.frame =CGRectMake(CGRectGetMaxX(yearLable.frame), 0, moneyLable.frame.size.width, 30);
    [showView addSubview:yearLable];
    [showView addSubview:moneyLable];
    [self addSubview:showView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        yearLable.alpha = 0;
        moneyLable.alpha = 0;
        showView.alpha = 0;
        [showView removeFromSuperview];
    });
}


-(void)autoGetScale{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenHeight == 480){//4s
        self.horizontalSpace = 13;
    }else if(screenHeight == 568){//5-5s
        self.horizontalSpace = 16.5;
    }else if(screenHeight == 667){//6
        self.horizontalSpace = 20.5;
    }else if(screenHeight == 736){//6p 414
        self.horizontalSpace = 23.5;
    }
}

-(CGFloat)autoGetYearX{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat distanceToLeftX = 0;
    if(screenHeight == 480){//4s
        distanceToLeftX = 33;
    }else if(screenHeight == 568){//5-5s
        distanceToLeftX = 35;
    }else if(screenHeight == 667){//6
        distanceToLeftX = 42;
    }else if(screenHeight == 736){//6p 414
        distanceToLeftX = 60;
    }
    return distanceToLeftX;
}


-(int )getUnitWithMaxValue:(int )maxValue{
    int unitNum = 0;
    int tempValue = 1;
    for(int i = 0 ; true ; i++){
        tempValue *= 10;
        if((maxValue / tempValue) == 0){
            unitNum = i + 1;
            break;
        }
    }
    switch (unitNum) {
        case 1:
        case 2:
        case 3:
        case 4://以百为单位 10,00
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(百)";
            break;
        case 5://以千为单位 10,000
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(千)";
            break;
        case 6://以万为单位 10,0000
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(万)";
            break;
        case 7://以十万为单位 10,00000
            self.level = tempValue / 100;
            self.unitYStr = @"销售额(十万)";
            break;
        case 8://以百万为单位 10,000000
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(百万)";
            break;
        case 9://以千万为单位 10,0000000
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(千万)";
            break;
        case 10://以亿为单位 10,00000000
            self.level = tempValue/ 100;
            self.unitYStr = @"销售额(亿)";
            break;
        default:
            break;
    }
    if(self.level == 0){
        self.level = 1;
        
    }
    return self.level;
}

@end
