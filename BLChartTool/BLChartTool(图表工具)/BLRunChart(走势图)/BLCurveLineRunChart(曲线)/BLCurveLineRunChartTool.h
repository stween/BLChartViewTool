//
//  BLCurveLineRunChartTool.h
//  CurveLineRunChart
//
//  Created by paykee on 16/8/19.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLTrendChart.h"

@protocol BLCurveLineRunChartToolDelegate <NSObject>

-(NSArray *)curverLineDataSource;

-(NSArray *)curverLineXDialsArray;

@end

@interface BLCurveLineRunChartTool : NSObject

/**
 * 根据frame生成曲线走势图，带切换按钮
 *  @parameters startColor 蒙板颜色起始
 *  @parameters endColor   蒙板颜色末尾
 */
-(BLTrendChart *)getCurveLineRunChartWithFrame:(CGRect )frame andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;

/**
 * 曲线走势图，带切换按钮
 *  @parameters startColor 蒙板颜色起始
 *  @parameters endColor   蒙板颜色末尾
 */
-(BLTrendChart *)getCurveLineRunChartWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;

/**
 * 根据frame生成曲线走势图，不带切换按钮
 *  @parameters startColor 蒙板颜色起始
 *  @parameters endColor   蒙板颜色末尾
 */
-(BLTrendChart *)getNoChangeBtnCurveLineRunChartWithFrame:(CGRect )frame andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;

/**
 * 曲线走势图，不带切换按钮
 *  @parameters startColor 蒙板颜色起始
 *  @parameters endColor   蒙板颜色末尾
 */
-(BLTrendChart *)getNoChangeBtnCurveLineRunChartWithStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;


@property(nonatomic,weak) id<BLCurveLineRunChartToolDelegate> curveLineRunChartToolDelegate;

@end
