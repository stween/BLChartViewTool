//
//  TestView.h
//  RoolBK
//
//  Created by paykee on 16/6/30.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLPieView : UIView

@property(nonatomic,strong) NSArray *dataResource;

@property(nonatomic,strong) NSArray *pieViewColorArray;

@property(nonatomic,copy) NSString *haveStatistics;

@property(nonatomic,strong) NSArray *listStatisticsArray;

@end
