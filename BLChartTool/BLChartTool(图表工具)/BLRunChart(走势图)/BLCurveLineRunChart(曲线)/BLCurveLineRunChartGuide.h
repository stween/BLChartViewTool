/*
  使用说明:
 #import "ViewController.h"
 #import "BLCurveLineRunChartTool.h"
 
 @interface ViewController ()<BLCurveLineRunChartToolDelegate>
 
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
    [super viewDidLoad];
    BLCurveLineRunChartTool *curveLineRunChartTool = [[BLCurveLineRunChartTool alloc]init];
    curveLineRunChartTool.curveLineRunChartToolDelegate = self;
    [self.view addSubview:[curveLineRunChartTool getNoChangeBtnCurveLineRunChartWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 220) andStartColor:[UIColor colorWithRed:255.0/255.0 green:135.0/255.0 blue:51.0/255.0 alpha:0.1] andEndColor:[UIColor whiteColor]]];
 }
 
 -(NSArray *)curverLineDataSource{
    return @[@[@"5.69",@"6.09",@"5.24",@"3.89",@"4.12",@"3.75",@"5.42"],@[@"5.69",@"3.80",@"5.67",@"6.37",@"7.32",@"4.56",@"6.87"],@[@"5.69",@"4.50",@"3.98",@"7.20",@"7.9",@"6.75",@"9.98"]];
 }
 
 -(NSArray *)curverLineXDialsArray{
    return @[@[@"11",@"12",@"13",@"14",@"15",@"16",@"17"],@[@"11-19",@"11-20",@"12-21",@"11-19",@"11-17",@"12-24",@"12-25"],@[@"11",@"12",@"13",@"14",@"15",@"16",@"17"]];
 }
 
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }
 
 @end

 
 
 */