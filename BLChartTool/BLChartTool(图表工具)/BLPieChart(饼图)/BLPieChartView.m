//
//  WHBKPieChartView.m
//  RoolBK
//
//  Created by paykee on 16/6/30.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLPieChartView.h"

@implementation BLPieChartView

-(void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;
}

-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
      [self setNeedsDisplay];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.frame.size.width / 1.93;
        self.layer.masksToBounds = YES;
        
        CGFloat h = IPHONE_4S || IPHONE_5S ? 40:43;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.25 , h , self.frame.size.width * 0.5, self.frame.size.height * 0.3)];
        titleLabel.text = @"核心客户分析图";
        titleLabel.numberOfLines = 2;
        titleLabel.font = IPHONE_4S || IPHONE_5S ? [UIFont boldSystemFontOfSize:15] : [UIFont boldSystemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHue:0.04 saturation:0.68 brightness:0.97 alpha:1.00];
        [self addSubview:titleLabel];
        
        UILabel *subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.25, CGRectGetMaxY(titleLabel.frame), self.frame.size.width * 0.5, 22)];
        subTitleLabel.text = @"消费年龄层";
        subTitleLabel.font = [UIFont systemFontOfSize:12];
        subTitleLabel.textColor = [UIColor lightGrayColor];
        subTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:subTitleLabel];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    int sum = 0;
    for (int  i = 0 ; i < self.dataResource.count; i++) {
        CGFloat startRadius = 0;
        CGFloat endRadius = 0;
        startRadius = (sum / 100.0) *  M_PI * 2;
        if(i == 3){
            endRadius = 2 * M_PI;
        }else{
            endRadius = ([self.dataResource[i] floatValue] / 100) *  M_PI * 2 + startRadius;
        }
        
        CGContextMoveToPoint(ctr, rect.size.width / 2, rect.size.height / 2);
        CGContextAddArc(ctr, rect.size.width / 2, rect.size.height / 2, self.frame.size.width / 2, startRadius, endRadius, 0);
        UIColor *color = self.colorArray[i];
        [color set];
        CGContextFillPath(ctr);
        sum += [self.dataResource[i] floatValue];
    }

    CGContextMoveToPoint(ctr, rect.size.width / 2, rect.size.height / 2);
    CGContextAddArc(ctr, rect.size.width / 2, rect.size.height / 2, self.frame.size.width / 3.0, 0, 2 * M_PI, 0);
    [[UIColor whiteColor]set];
    CGContextFillPath(ctr);
}


@end