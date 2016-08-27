//
//  BLBarChartToolView.h
//  barChat
//
//  Created by paykee on 16/7/1.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLBarChartToolViewDelegate<NSObject>


@end

@interface BLBarChartToolView : UIView

@property(nonatomic,strong) NSArray *dataResource;

@property(nonatomic,strong) NSArray *chartToolViewColorArray;

@property(nonatomic,copy) NSString *haveStatistics;

@end
