//
//  BLChartTool.h
//  BarView
//
//  Created by paykee on 16/8/18.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLBarChartToolView.h"

@protocol BLChartToolDelegate <NSObject>

/**
 *  里面的数据必须是 “@{@"transAmt":@"1000.0",@"mon":@"1"}类型”的数组
 */
-(NSArray *)chartToolDataResouce;

-(NSArray *)chartToolColor;

@end

@interface BLChartTool : NSObject

/**
 *  根据frame生成柱状图，带统计表
 */
-(BLBarChartToolView *)getHaveStatisticsBarChartViewWithFame:(CGRect )frame;

/**
 *  自动适配生成柱状图，带统计表
 */
-(BLBarChartToolView *)getHaveStatisticsAndAutoAdJustBarChart;

/**
 *  根据frame生成柱状图，不带统计表
 */
-(BLBarChartToolView *)getNoStatisticsBarChartViewWithFame:(CGRect )frame;

/**
 *  自动适配生成柱状图，不带统计表
 */
-(BLBarChartToolView *)getNoStatisticsAndAutoAdJustBarChart;

@property(nonatomic,weak) id<BLChartToolDelegate> chartToolDelegate;

@property(nonatomic,strong) NSArray *dataResource;

@end
