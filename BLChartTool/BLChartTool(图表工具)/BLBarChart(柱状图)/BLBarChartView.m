//
//  BarChartView.m
//  barChat
//
//  Created by paykee on 16/7/1.
//  Copyright © 2016年 jpy. All rights reserved.
//

#define BarChartBoxH self.frame.size.height / 7
#define BarChartBoxW (self.frame.size.width - BarChartRightSpacing - BarChartLeftSpacing) / 6
#define BarChartLeftSpacing  40
#define BarChartRightSpacing 25
#define barChartColumnW 12
#define SCREENSIZE [UIScreen mainScreen].bounds.size

#import "BLBarChartView.h"

@interface BLBarChartView()
//y轴刻度
@property(nonatomic,strong) NSMutableArray *yArr;

@property(nonatomic,copy) NSString *yUnit;

@property(nonatomic, assign) int level;

@property(nonatomic, copy) NSString *type;

@property(nonatomic, weak) NSTimer *time;

@property(nonatomic, strong) NSMutableArray *valueArr;

@end

@implementation BLBarChartView

static int arrIndex = 0;

-(NSMutableArray *)yArr{
    if(!_yArr){
        _yArr = [NSMutableArray array];
    }
    return _yArr;
}

-(NSMutableArray *)valueArr{
    if(!_valueArr){
        _valueArr = [NSMutableArray array];
    }
    return _valueArr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
}

-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
    self.yUnit = @"(元)";
    [self getYDataArrWithDataResource:_dataResource];
    
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(animateWithBarChat) userInfo:nil repeats:YES];
    self.time = time;
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSDefaultRunLoopMode];
}

-(void)animateWithBarChat{
    arrIndex++;
    NSMutableArray *valueStrArr = [NSMutableArray array];
    for (int i = 0 ; i < _dataResource.count; i++) {
        [self.valueArr removeAllObjects];
        NSDictionary *dataDic = _dataResource[i];
        CGFloat num = [dataDic[@"transAmt"] floatValue] * arrIndex / _dataResource.count;
        NSString *valueStr = [NSString stringWithFormat:@"%.2f",num];
        [valueStrArr addObject:valueStr];
    }
    [self.valueArr addObjectsFromArray:valueStrArr];
    [self setNeedsDisplay];
    
    if(arrIndex == _dataResource.count){
        [self.time invalidate];
        self.time = nil;
        arrIndex = 0;
    }
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctr = UIGraphicsGetCurrentContext();

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]};
    
    [self.yUnit drawInRect:CGRectMake(2,  BarChartBoxH - [self getAdjustWithScreenH], BarChartLeftSpacing - 4, 22) withAttributes:attribute];
    
    for (int i = 0 ; i < 6 ; i++) {
        [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        CGContextSetLineWidth(ctr, 0.5);
        CGContextMoveToPoint(ctr, BarChartLeftSpacing, BarChartBoxH * (i + 1));
        CGContextAddLineToPoint(ctr, self.frame.size.width - BarChartRightSpacing, BarChartBoxH * (i + 1));
        CGContextStrokePath(ctr);
        [self.yArr[5 - i] drawInRect:CGRectMake(8, BarChartBoxH * (i + 1) - 7, BarChartLeftSpacing - 10, 22) withAttributes:attribute];
    }
    
    for (int i = 0; i < 7 ; i++) {
        CGContextSetLineWidth(ctr, 0.5);
        [[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]set];
        CGContextMoveToPoint(ctr, BarChartLeftSpacing + i * BarChartBoxW, BarChartBoxH * 6);
        CGContextAddLineToPoint(ctr, BarChartLeftSpacing + i * BarChartBoxW, BarChartBoxH * 6 + 3);
        CGContextStrokePath(ctr);
    }
    
    for (int i = 0 ; i < self.valueArr.count ; i++) {
        NSDictionary *dataDic = self.dataResource[i];
        NSString *monthStr = [NSString stringWithFormat:@"%@月",dataDic[@"mon"]];
        NSString *moneyStr = self.valueArr[i];
        NSLog(@"%@",moneyStr);
        CGFloat num = [moneyStr floatValue] / self.level;
        CGFloat scale = 0.0;
        if([self.type isEqualToString:@"f"]){
            scale = num / 50;
            
        }else{
            scale =  num / 100;;
            
        }
        [self drawMyRectWithCornerX:BarChartLeftSpacing + BarChartBoxW * (i + 0.5) - barChartColumnW * 0.5 andY:BarChartBoxH * 6 andRadius:barChartColumnW / 2 andWidth:barChartColumnW andHeight:- 5 * scale * BarChartBoxH andCtr:ctr andColor:self.colorArray[i]];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.alignment = NSTextAlignmentCenter;
        NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraph,NSForegroundColorAttributeName:[UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]};
        
        [monthStr drawInRect:CGRectMake(BarChartLeftSpacing + BarChartBoxW * i, BarChartBoxH * 6 + 5 , BarChartBoxW, 22) withAttributes:attribute];
    }
    
}

- (void)drawMyRectWithCornerX:(CGFloat)x andY:(CGFloat)y andRadius:(CGFloat)radius andWidth:(CGFloat)width andHeight:(CGFloat)height andCtr:(CGContextRef)ctr andColor:(UIColor *)color{
    [color set];
    CGContextMoveToPoint(ctr, x, y);
    if(radius > fabs(height)){
        CGContextAddArc(ctr, x + width / 2, y, fabs(height), M_PI * 2, M_PI, 1);
    }else{
        CGContextAddLineToPoint(ctr, x, y - fabs(height) + radius);
        CGContextAddArc(ctr, x + width / 2, y - fabs(height) + radius, radius, - M_PI , 0, 0);
        CGContextAddLineToPoint(ctr, x + width,  y - fabs(height) + radius);
        CGContextAddLineToPoint(ctr, x + width, y);
        CGContextAddLineToPoint(ctr, x, y);
    }
    CGContextFillPath(ctr);
}


-(void)getYDataArrWithDataResource:(NSArray *)dataResource{
    CGFloat maxValue = [self maxValueWithDataResource:dataResource];
    
    [self getUnitWithMaxValue:maxValue];
}

-(CGFloat)maxValueWithDataResource:(NSArray *)dataResource{
    NSDictionary *dic = self.dataResource[0];
    CGFloat maxValue = [dic[@"transAmt"] floatValue];
    
    for(int i = 1 ; i < dataResource.count ; i++){
        NSDictionary *dic = self.dataResource[i];
        CGFloat compareValue = [dic[@"transAmt"] floatValue];
        if(maxValue < compareValue){
            maxValue = compareValue;
        }
    }
    
    return maxValue;
    
}

-(void)getUnitWithMaxValue:(int )maxValue{
    int unitNum = 0;
    int tempValue = 1;
    for(int i = 0 ; true ; i++){
        tempValue *= 10;
        if((maxValue / tempValue) == 0){
            unitNum = i + 1;
            break;
        }
    }
    
    if((maxValue / (int)pow(10, unitNum - 1)) < 5){
        self.type = @"f";
        switch (unitNum) {
            case 1://个 上限十
            case 2://十
                //以元位单位 上限五十
                self.level = 1;
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                self.yUnit = @"(元)";
                break;
            case 3: //百   上限五百
                self.level = 10;
                self.yUnit = @"(十)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 4://以百为单位 10,00  上限五千
                self.level = 100;
                self.yUnit = @"(百)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 5://以千为单位 10,000  上限五万
                self.level = 1000;
                self.yUnit = @"(千)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 6://以万为单位 10,0000 上限五十万
                self.level = 10000;
                self.yUnit = @"(万)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 7://以十万为单位 10,00000  上限制五百万
                self.level = 100000;
                self.yUnit = @"(十万)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 8://以百万为单位 10,000000 上限制五千万
                self.level = 1000000;
                self.yUnit = @"(百万)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            case 9://以百万为单位 10,000000 上限制五亿
                self.level = 1000000;
                self.yUnit = @"(千万)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            default:
                break;
        }
    }else{
        self.type = @"l";
        switch (unitNum) {
            case 1://个 上限十
            case 2://十
                //以元位单位 上限百
                self.level = 1;
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                self.yUnit = @"(元)";
                break;
            case 3: //百   上限千
                self.level = 10;
                self.yUnit = @"(十)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 4://以百为单位 10,00  上限万
                self.level =  100;
                self.yUnit = @"(百)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 5://以千为单位 10,000  上限十万
                self.level = 1000;
                self.yUnit = @"(千)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 6://以万为单位 10,0000 上限百万
                self.level = 10000;
                self.yUnit = @"(万)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 7://以十万为单位 10,00000  上限制千万
                self.level = 100000;
                self.yUnit = @"(十万)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 8://以百万为单位 10,000000 上限制亿
                self.level = 1000000;
                self.yUnit = @"(百万)";
                [self.yArr addObjectsFromArray:@[@"0",@"20",@"40",@"60",@"80",@"100"]];
                break;
            case 9://以百万为单位 10,000000 上限制十亿
                self.level = 1000000;
                self.yUnit = @"(千万)";
                [self.yArr addObjectsFromArray:@[@"0",@"10",@"20",@"30",@"40",@"50"]];
                break;
            default:
                break;
        }
    }
}


-(CGFloat)getAdjustWithScreenH{
    int ht = (int)SCREENSIZE.height;
    CGFloat spacingF = 0;
    switch (ht){
        case 480://4s
            spacingF = 20;
            break;
        case 568://5_5s
            spacingF = 30;
            break;
        case 667://6_6s
            spacingF = 30;
            break;
        case 736://6p_6sp
            spacingF = 33;
            break;
        default:
            break;
    }
    return spacingF;
}

@end
