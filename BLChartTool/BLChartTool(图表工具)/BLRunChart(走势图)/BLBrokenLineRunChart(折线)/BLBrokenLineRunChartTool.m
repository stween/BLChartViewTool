//
//  BLBrokenLineRunChartTool.m
//  BLBrokenLineRunChart
//
//  Created by paykee on 16/8/27.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLBrokenLineRunChartTool.h"

@interface BLBrokenLineRunChartTool()

@property(nonatomic,weak) BLChatLineView *chatLineView;

@end

@implementation BLBrokenLineRunChartTool

-(BLChatLineView *)getChatLineViewWithFrame:(CGRect )frame{
    BLChatLineView *chatLineView = [[BLChatLineView alloc]initWithFrame:frame];
    self.chatLineView = chatLineView;
    [self addObserver:self forKeyPath:@"brokenLineRunChartToolDelegate" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    return self.chatLineView;
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    self.chatLineView.rowNum = [self.brokenLineRunChartToolDelegate brokenLineRunChartYNum];
    self.chatLineView.dataResource = [self.brokenLineRunChartToolDelegate brokenLineRunChartDataResource];
    self.chatLineView.yearArr = [self.brokenLineRunChartToolDelegate brokenLineRunChartYearArr];
    self.chatLineView.lineColorArr = [self.brokenLineRunChartToolDelegate brokenLineRunChartColor];
    self.chatLineView.xValueArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
}



@end
