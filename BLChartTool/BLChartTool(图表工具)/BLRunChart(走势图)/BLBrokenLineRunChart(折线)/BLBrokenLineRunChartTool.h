//
//  BLBrokenLineRunChartTool.h
//  BLBrokenLineRunChart
//
//  Created by paykee on 16/8/27.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLChatLineView.h"
@protocol BLBrokenLineRunChartToolDelegate <NSObject>

-(NSArray *)brokenLineRunChartDataResource;

-(NSArray *)brokenLineRunChartColor;

-(NSArray *)brokenLineRunChartYearArr;

-(int)brokenLineRunChartYNum;

@end

@interface BLBrokenLineRunChartTool : NSObject

@property(nonatomic,weak) id<BLBrokenLineRunChartToolDelegate> brokenLineRunChartToolDelegate;

-(BLChatLineView *)getChatLineViewWithFrame:(CGRect )frame;

@end
