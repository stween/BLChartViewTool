//
//  BLPieChartTool.m
//  PieUse
//
//  Created by paykee on 16/8/19.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLPieChartTool.h"

@interface BLPieChartTool()

@property(nonatomic,strong) BLPieView *pieView;

@end

@implementation BLPieChartTool

/**
 *  自动适配生成饼图，带统计表
 */
-(BLPieView *)getHaveListDescribingAutoAdJustPeiChartView{
    BLPieView *pieView = [[BLPieView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,290)];
    self.pieView = pieView;
    [self addObserver:self forKeyPath:@"pieChartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.pieView;
}

/**
 *  自动适配生成饼图，带统计表
 */
-(BLPieView *)getNoListDescribingAutoAdJustPeiChartView{
    BLPieView *pieView = [[BLPieView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,200)];
    self.pieView = pieView;
    self.pieView.haveStatistics = @"N";
    [self addObserver:self forKeyPath:@"pieChartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.pieView;
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    self.pieView.pieViewColorArray = [self.pieChartToolDelegate chartToolColor];
    self.pieView.listStatisticsArray = [self.pieChartToolDelegate chartToolListDescribingData];
    self.pieView.dataResource = [self.pieChartToolDelegate chartToolDataResouce];
}

@end
