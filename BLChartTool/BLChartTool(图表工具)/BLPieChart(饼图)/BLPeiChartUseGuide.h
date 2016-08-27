//
//  BLPeiChartUseGuide.h
//  PieUse
//
//  Created by paykee on 16/8/19.
//  Copyright © 2016年 jpy. All rights reserved.
//
/*
 使用说明
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
 BLPieChartTool *pieChartTool = [[BLPieChartTool alloc]init];
 pieChartTool.pieChartToolDelegate = self;
 [self.view addSubview:[pieChartTool getHaveListDescribingAutoAdJustPeiChartView]];
 
 }
 
 -(NSArray *)chartToolDataResouce{
 return @[@"20",@"20",@"20",@"20",@"20"];
 }
 
 -(NSArray *)chartToolColor{
 return @[[UIColor redColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor greenColor],[UIColor blueColor],[UIColor blackColor],[UIColor orangeColor]];
 }
 
 如果调用getNoListDescribingAutoAdJustPeiChartView方法,则不用实现下面这个代理方法
-(NSArray *)chartToolListDescribingData{
    return @[@{@"title":@"青春活力派",@"value":@"25岁及以下"},@{@"title":@"文艺青年派",@"value":@"26-35岁"},@{@"title":@"成熟稳重派",@"value":@"36-45岁"},@{@"title":@"低调情怀派",@"value":@"46-58岁"},@{@"title":@"老年活力派",@"value":@"59岁及以下"}];
}


 */