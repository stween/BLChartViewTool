//
//  BLChartTool.m
//  BarView
//
//  Created by paykee on 16/8/18.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLChartTool.h"
#define SCREENSIZE [UIScreen mainScreen].bounds.size
@interface BLChartTool()

@property(nonatomic,weak) BLBarChartToolView *barChatView;

@end

@implementation BLChartTool

/**
 *  根据frame生成柱状图，带统计
 */
-(BLBarChartToolView *)getHaveStatisticsBarChartViewWithFame:(CGRect )frame{
    BLBarChartToolView *barChatView = [[BLBarChartToolView alloc]initWithFrame:frame];
    self.barChatView = barChatView;
    [self addObserver:self forKeyPath:@"chartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.barChatView;
}

/**
 *  自动适配生成柱状图，带统计
 */
-(BLBarChartToolView *)getHaveStatisticsAndAutoAdJustBarChart{
    NSMutableDictionary *dicValue = [self getBarChartAdjustWithScreenH];
    BLBarChartToolView *barChatView = [[BLBarChartToolView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * [[dicValue valueForKey:@"scale"] floatValue])];
    self.barChatView = barChatView;
    [self addObserver:self forKeyPath:@"chartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.barChatView;
}


/**
 *  根据frame生成柱状图，不带统计表
 */
-(BLBarChartToolView *)getNoStatisticsBarChartViewWithFame:(CGRect )frame{
    BLBarChartToolView *barChatView = [[BLBarChartToolView alloc]initWithFrame:frame];
    self.barChatView = barChatView;
    self.barChatView.haveStatistics = @"N";
    [self addObserver:self forKeyPath:@"chartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.barChatView;
}

/**
 *  自动适配生成柱状图，不带统计表
 */
-(BLBarChartToolView *)getNoStatisticsAndAutoAdJustBarChart{
    NSMutableDictionary *dicValue = [self getBarChartAdjustWithScreenH];
    BLBarChartToolView *barChatView = [[BLBarChartToolView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * [[dicValue valueForKey:@"scale"] floatValue])];
    self.barChatView = barChatView;
    self.barChatView.haveStatistics = @"N";
    [self addObserver:self forKeyPath:@"chartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self.barChatView;
}


-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    self.barChatView.chartToolViewColorArray = [self.chartToolDelegate chartToolColor];
    self.barChatView.dataResource = [self.chartToolDelegate chartToolDataResouce];
}

-(NSMutableDictionary *)getBarChartAdjustWithScreenH{
    NSMutableDictionary *barChartDic = [NSMutableDictionary dictionary];
    int ht = (int)SCREENSIZE.height;
    switch (ht){
        case 480://4s
            [barChartDic setValue:@"140" forKey:@"spacing"];
            [barChartDic setValue:@"0.46" forKey:@"scale"];
            break;
        case 568://5_5s
            [barChartDic setValue:@"155" forKey:@"spacing"];
            [barChartDic setValue:@"0.52" forKey:@"scale"];
            break;
        case 667://6_6s
            [barChartDic setValue:@"171" forKey:@"spacing"];
            [barChartDic setValue:@"0.52" forKey:@"scale"];
            break;
        case 736://6p_6p2
            [barChartDic setValue:@"171" forKey:@"spacing"];
            [barChartDic setValue:@"0.52" forKey:@"scale"];
            break;
        default:
            break;
    }
    return barChartDic;
}

@end
