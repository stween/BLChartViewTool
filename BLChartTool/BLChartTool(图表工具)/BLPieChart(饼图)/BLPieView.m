//
//  TestView.m
//  RoolBK
//
//  Created by paykee on 16/6/30.
//  Copyright © 2016年 jpy. All rights reserved.
//

#define pieXChartView  self.frame.size.width / 3.2 - sqrt((self.backgroundLayer.cornerRadius * 1.1 *  self.backgroundLayer.cornerRadius * 1.1) / 2)
#define pieYChartView  self.frame.size.width / 3.2 - sqrt((self.backgroundLayer.cornerRadius * 1.1 * self.backgroundLayer.cornerRadius * 1.1) / 2)


#import "BLPieView.h"
#import "BLPieChartView.h"

@interface BLPieView()

@property(nonatomic,strong) CALayer *backgroundLayer;

@property(nonatomic,weak) BLPieChartView *pieChartView;

@property(nonatomic,strong)NSMutableArray* labelArray;

@end

@implementation BLPieView

-(void)setPieViewColorArray:(NSArray *)pieViewColorArray{
    _pieViewColorArray = pieViewColorArray;
}

-(void)setListStatisticsArray:(NSArray *)listStatisticsArray{
    _listStatisticsArray = listStatisticsArray;
}

-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
    if (!_pieChartView) {
        //饼图
        [self addPieChartView];
        //饼图值
        [self addSubViews];
        
        if(![self.haveStatistics isEqualToString:@"N"]){
            //饼图表格提示
            [self addPieValuePView];
        }
    }
    self.pieChartView.dataResource = self.dataResource;
    for (int i = 0; i <self.dataResource.count; i++) {
        UILabel* valueLabel = self.labelArray[i];
        valueLabel.text = [NSString stringWithFormat:@"%@%%",self.dataResource[i]];
    }
}

-(CALayer *)backgroundLayer{
    if(!_backgroundLayer){
        _backgroundLayer = [[CALayer alloc] init];
        _backgroundLayer.cornerRadius = self.frame.size.width / 4;
        _backgroundLayer.frame = CGRectMake(0, 0, _backgroundLayer.cornerRadius * 2 , _backgroundLayer.cornerRadius * 2);
        _backgroundLayer.borderWidth = 1;
        _backgroundLayer.position = CGPointMake(self.frame.size.width / 3.2, self.frame.size.width / 3.2 - 15);
        _backgroundLayer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:0.8].CGColor;
        _backgroundLayer.backgroundColor = [UIColor colorWithHue:0.00 saturation:0.00 brightness:0.96 alpha:1.00].CGColor;
    }
    return _backgroundLayer;
}

-(NSMutableArray*)labelArray{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)addPieChartView{
    //添加背景图层
    [self.layer addSublayer:self.backgroundLayer];
    //开始图层动画
    [self startAnimationWithStaticLayer];
    
    BLPieChartView *pieChartView = [[BLPieChartView alloc]initWithFrame:CGRectMake(pieXChartView - 2, pieYChartView - 17, self.backgroundLayer.cornerRadius * 1.6 , self.backgroundLayer.cornerRadius * 1.6)];
    self.pieChartView = pieChartView;
    self.pieChartView.colorArray = self.pieViewColorArray;
    self.pieChartView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.pieChartView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimationWithStaticLayer) name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)startAnimationWithStaticLayer{
    CAAnimationGroup *animaTionGroup = [CAAnimationGroup animation];
    animaTionGroup.delegate = self;
    animaTionGroup.duration = 1;
    animaTionGroup.removedOnCompletion = YES;
    animaTionGroup.autoreverses = YES;
    animaTionGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.90;
    scaleAnimation.toValue = @0.96;
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.4,@0.8,@0.4];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    opencityAnimation.autoreverses = YES;
    opencityAnimation.repeatCount = MAXFLOAT;
    
    NSArray *animations = @[scaleAnimation];
    animaTionGroup.animations = animations;
    [self.backgroundLayer addAnimation:animaTionGroup forKey:@"groupAnnimation"];
}


-(void)addSubViews{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(pieXChartView + self.backgroundLayer.cornerRadius * 2.1 + 20, pieXChartView, self.frame.size.width - pieXChartView + self.backgroundLayer.cornerRadius * 1.8 , 22)];
    titleLabel.text = @"百分比分布";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:titleLabel];
    
    CGFloat blockY = 0;
    for (int i = 0 ; i < self.dataResource.count; i++) {
        blockY = CGRectGetMaxY(titleLabel.frame) + i * 20 + 10;
        UIView *blockView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x , blockY, 10, 10)];
        blockView.backgroundColor = self.pieViewColorArray[i];
        [self addSubview:blockView];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blockView.frame) + 10, blockY - 5, 80, 20)];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:valueLabel];
        [self.labelArray addObject:valueLabel];
    }
}

-(void)addPieValuePView{
    CGFloat h = IPHONE_6Plus ? 40 :25;

    CGFloat listViewH = 32 * (((self.dataResource.count - 1) / 2) + 1);
    UIView *listView = [[UIView alloc]initWithFrame:CGRectMake(17, CGRectGetMaxY(self.pieChartView.frame) + h, [UIScreen mainScreen].bounds.size.width - 35 , listViewH)];
    listView.layer.cornerRadius = 3;
    listView.layer.masksToBounds = YES;
    listView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
    listView.layer.borderWidth = 0.5;
    [self addSubview:listView];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat promptBlockViewH = listView.frame.size.height / (((self.dataResource.count - 1) / 2) + 1);
    CGFloat promptBlockViewW = listView.frame.size.width / 2;
    for (int i = 0 ; i < self.dataResource.count ; i++) {
        x = (i % 2) * promptBlockViewW;
        y = (i / 2) * promptBlockViewH;
        
        UIView *promptBlockView = [[UIView alloc]initWithFrame:CGRectMake(x, y, promptBlockViewW, promptBlockViewH)];
        promptBlockView.layer.borderWidth = 0.3;
        promptBlockView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
        [listView addSubview:promptBlockView];
        
        NSMutableDictionary *dic = self.listStatisticsArray[i];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, promptBlockViewH * 0.15, 70, promptBlockViewH * 0.7)];

        titleLabel.text = dic[@"title"];
        titleLabel.font = IPHONE_5S || IPHONE_4S ? [UIFont systemFontOfSize:11] : [UIFont systemFontOfSize:13];
        titleLabel.textColor = self.pieViewColorArray[i];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [promptBlockView addSubview:titleLabel];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) - 5, promptBlockViewH * 0.15, promptBlockView.frame.size.width - 70, promptBlockViewH * 0.7)];

        valueLabel.text = dic[@"value"];
        valueLabel.font = IPHONE_5S || IPHONE_4S ? [UIFont systemFontOfSize:11] : [UIFont systemFontOfSize:13];
        valueLabel.textColor = [UIColor lightGrayColor];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        [promptBlockView addSubview:valueLabel];
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
