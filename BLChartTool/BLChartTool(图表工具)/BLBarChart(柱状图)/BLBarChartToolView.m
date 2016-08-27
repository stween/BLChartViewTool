//
//  BLBarChartToolView.m
//  barChat
//
//  Created by paykee on 16/7/1.
//  Copyright © 2016年 jpy. All rights reserved.
//

#import "BLBarChartToolView.h"
#import "BLBarChartView.h"

@interface BLBarChartToolView()

@property(nonatomic,weak) UIView *headView;

@property(nonatomic,weak) BLBarChartView *barChartView;

@end

@implementation BLBarChartToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)setChartToolViewColorArray:(NSArray *)chartToolViewColorArray{
    _chartToolViewColorArray = chartToolViewColorArray;
}


-(void)setDataResource:(NSArray *)dataResource{
    _dataResource = dataResource;
    if(!self.headView){
        //head
        [self addHeadView];
        
        //chatBar
        [self addBarChartView];
        
        if(![self.haveStatistics isEqualToString:@"N"]){
            //listData
            [self addListDataView];
        }
    }else{
        for (int i = 0 ; i < self.subviews.count; i++) {
            [self.subviews[i] removeFromSuperview];
        }
        
        //head
        [self addHeadView];
        
        //chatBar
        [self addBarChartView];
        
        if(![self.haveStatistics isEqualToString:@"N"]){
            //listData
            [self addListDataView];
        }
    }
}

-(void)addHeadView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height * 0.08)];
    self.headView = headView;
    [self addSubview:self.headView];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (headView.frame.size.height - 12) / 2 , 12, 12)];
    iconImageView.image = [UIImage imageNamed:@"home_icon_deal"];
    [self.headView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 5, (headView.frame.size.height - 22) / 2, 150, 22)];
    titleLabel.text = @"月交易额";
    titleLabel.textColor = [UIColor colorWithRed:148.0/255.0 green:148.0/255.0 blue:148.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self.headView addSubview:titleLabel];
    
}

-(void)addBarChartView{
    float scale = 0.0;
    if([self.haveStatistics isEqualToString:@"N"]){
        scale = 0.91;
    }else{
        scale = 0.65;
    }
    
    BLBarChartView *barChartView = [[BLBarChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame), [UIScreen mainScreen].bounds.size.width, self.frame.size.height * scale)];
    self.barChartView = barChartView;
    self.barChartView.dataResource = self.dataResource;
    NSLog(@"%@",self.chartToolViewColorArray);
    self.barChartView.colorArray = self.chartToolViewColorArray;
    [self addSubview:self.barChartView];
}

-(void)addListDataView{
    UIView *listDataView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.barChartView.frame) + 5, [UIScreen mainScreen].bounds.size.width - 20, self.frame.size.height * 0.27 - 2)];
    listDataView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
    listDataView.layer.borderWidth = 1;
    listDataView.layer.cornerRadius = 4;
    listDataView.layer.masksToBounds = YES;
    [self addSubview:listDataView];
    
    CGFloat blockH = listDataView.frame.size.height / 3;
    CGFloat blockW = listDataView.frame.size.width / 2;
    CGFloat blockX = 0;
    CGFloat blockY = 0;
    int row = 0;
    int col = 0;
    for (int i = 0; i < self.dataResource.count; i++) {
        NSDictionary *valDic = self.dataResource[i];
        col = i % 2;
        row = i / 2;
        blockX = blockW * col;
        blockY = blockH * row;
        UIView *blockView = [[UIView alloc]initWithFrame:CGRectMake(blockX, blockY, blockW, blockH)];
        blockView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
        blockView.layer.borderWidth = 0.5;
        [listDataView addSubview:blockView];
        
        UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, (blockView.frame.size.height - 22) / 2, 30, 22)];
        monthLabel.text = [NSString stringWithFormat:@"%@月",valDic[@"mon"]];
        monthLabel.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        monthLabel.font = [UIFont systemFontOfSize:13];
        monthLabel.textAlignment = NSTextAlignmentRight;
        [blockView addSubview:monthLabel];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(monthLabel.frame) + 5, (blockView.frame.size.height - 22) / 2, blockView.frame.size.width - CGRectGetMaxX(monthLabel.frame) - 15, 22)];
        valueLabel.text = [NSString stringWithFormat:@"¥%@",valDic[@"transAmt"]];
        valueLabel.textColor = self.chartToolViewColorArray[i];
        valueLabel.font = [UIFont systemFontOfSize:13];
        valueLabel.textAlignment = NSTextAlignmentRight;
        [blockView addSubview:valueLabel];
    }
}



@end
