//
//  ChatLine.h
//  走势图绘制
//
//  Created by jinpengyao on 15/8/17.
//  Copyright (c) 2015年 JPY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLChatLineView : UIView

/**
 *  所有的值
 */
@property(nonatomic, strong) NSArray *dataResource;

/**
 *  x轴
 */
@property(nonatomic, strong) NSArray *xValueArr;

/**
 *  年数数组
 */
@property(nonatomic, strong) NSArray *yearArr;


/**
 *  销售额度
 */
@property(nonatomic, copy) NSString *unitYStr;

@property(nonatomic, strong) NSArray *lineColorArr;

@property(nonatomic,assign) int rowNum;

@end
