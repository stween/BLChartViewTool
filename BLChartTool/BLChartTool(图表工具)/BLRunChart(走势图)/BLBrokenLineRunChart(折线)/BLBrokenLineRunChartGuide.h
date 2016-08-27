/*
 使用说明

 #import "ViewController.h"
 #import "BLBrokenLineRunChartTool.h"
 
 @interface ViewController ()<BLBrokenLineRunChartToolDelegate>
 
 @end
 
 @implementation ViewController

 - (void)viewDidLoad {
    [super viewDidLoad];
    BLBrokenLineRunChartTool *brokenLineRunChartTool = [[BLBrokenLineRunChartTool alloc]init];
    brokenLineRunChartTool.brokenLineRunChartToolDelegate = self;
    [self.view addSubview:[brokenLineRunChartTool getChatLineViewWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 300)]];

 }
 
 -(NSArray *)brokenLineRunChartDataResource{
    NSArray *valueArr1 = @[@"1000",@"15000",@"90000",@"70000",@"30000",@"40000",@"20000",@"50000",@"20000",@"60000",@"120000",@"80000"];
    NSArray *valueArr2 = @[@"90000",@"70000",@"50000",@"60000",@"20000",@"50000",@"10000",@"80000",@"70000",@"20000",@"110000",@"130000"];
    //    NSArray *valueArr3 = @[@"20000",@"30000",@"60000",@"70000",@"40000",@"60000",@"80000",@"50000",@"90000",@"60000",@"100000",@"120000"];
    return @[valueArr1,valueArr2];
 }
 
 -(NSArray *)brokenLineRunChartColor{
    return @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]];
 }
 
 -(NSArray *)brokenLineRunChartYearArr{
    return @[@"2014",@"2015"];
 }
 
-(int)brokenLineRunChartYNum{
    return 5;
 }
 
 
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 @end

 
 */