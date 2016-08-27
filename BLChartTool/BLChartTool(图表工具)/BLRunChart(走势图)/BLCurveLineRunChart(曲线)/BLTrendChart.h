//
//  PYTrendChart.h
//  pyChat
//
//  Created by paykee on 15/12/6.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLTrendChart : UIView

@property(nonatomic,strong) NSArray *valueArray;

@property(nonatomic,strong) NSArray *xDialsArray;

@property(nonatomic,copy) NSString *haveChange;

@property(nonatomic,strong) UIColor *startColor;

@property(nonatomic,strong) UIColor *endColor;

@end
