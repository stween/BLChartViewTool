//
//  WHBKPieChartView.h
//  RoolBK
//
//  Created by paykee on 16/6/30.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IPHONE_4S ([UIScreen mainScreen].bounds.size.height == 480)
#define IPHONE_5S ([UIScreen mainScreen].bounds.size.height == 568)
#define IPHONE_6Plus ([UIScreen mainScreen].scale > 2)
@interface BLPieChartView : UIView

@property(nonatomic,strong) NSArray *dataResource;

@property(nonatomic,strong) NSArray *colorArray;

@end
