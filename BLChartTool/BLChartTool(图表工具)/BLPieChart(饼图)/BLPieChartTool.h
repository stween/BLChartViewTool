//
//  BLPieChartTool.h
//  PieUse
//
//  Created by paykee on 16/8/19.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLPieView.h"

@protocol BLPieChartToolDelegate <NSObject>

-(NSArray *)chartToolDataResouce;

-(NSArray *)chartToolColor;

@optional
/**
 *  数据类型为:@{@"title":@"青春活力派",@"value":@"25岁及以下"} 的字典数据类型
 */
-(NSArray *)chartToolListDescribingData;

@end

@interface BLPieChartTool : NSObject
/*
     WHBKPieView *pieView = [[WHBKPieView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,290)];
 */

@property(nonatomic,weak) id<BLPieChartToolDelegate> pieChartToolDelegate;

/**
 *  自动适配生成饼图，带统计表<不建议修改其大小，有需求的话请在该源码上进行修改>
 */
-(BLPieView *)getHaveListDescribingAutoAdJustPeiChartView;

/**
 *  自动适配生成饼图，带统计表
 */
-(BLPieView *)getNoListDescribingAutoAdJustPeiChartView;

@end
