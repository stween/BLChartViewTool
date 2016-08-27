//
//  BLCurveLineRunChartTool.m
//  CurveLineRunChart
//
//  Created by paykee on 16/8/19.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLCurveLineRunChartTool.h"

@interface BLCurveLineRunChartTool()

@property(nonatomic,weak) BLTrendChart *blTrendChart;

@end

@implementation BLCurveLineRunChartTool

 /**
 * 根据frame生成曲线走势图，带切换按钮
 */

-(BLTrendChart *)getCurveLineRunChartWithFrame:(CGRect )frame andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
    return [self getTrendChartWithFrame:frame andHaveChangeBtn:@"Y" andStartColor:startColor andEndColor:endColor];
}

/**
 * 曲线走势图，带切换按钮
 */
-(BLTrendChart *)getCurveLineRunChartWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
    return [self getTrendChartWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 240) andHaveChangeBtn:@"Y" andStartColor:startColor andEndColor:endColor];
}

/**
 * 根据frame生成曲线走势图，不带切换按钮
 */
-(BLTrendChart *)getNoChangeBtnCurveLineRunChartWithFrame:(CGRect )frame andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
    return [self getTrendChartWithFrame:frame andHaveChangeBtn:@"N" andStartColor:startColor andEndColor:endColor];
}

/**
 * 曲线走势图，不带切换按钮
 */
-(BLTrendChart *)getNoChangeBtnCurveLineRunChartWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
return [self getTrendChartWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 220) andHaveChangeBtn:@"N" andStartColor:startColor andEndColor:endColor];
}



-(BLTrendChart *)getTrendChartWithFrame:(CGRect )frame andHaveChangeBtn:(NSString *)haveChange andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
    BLTrendChart *pyTrendChart = [[BLTrendChart alloc]initWithFrame:frame];
    self.blTrendChart = pyTrendChart;
    self.blTrendChart.startColor = startColor;
    self.blTrendChart.endColor = endColor;
    self.blTrendChart.haveChange = haveChange;
    
    [self addObserver:self forKeyPath:@"curveLineRunChartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    return self.blTrendChart;
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    self.blTrendChart.xDialsArray = [self.curveLineRunChartToolDelegate curverLineXDialsArray];
    self.blTrendChart.valueArray = [self.curveLineRunChartToolDelegate curverLineDataSource];
}

@end
