/*
 使用说明：
 
 @interface ViewController ()<BLChartToolDelegate>
 
 @property(nonatomic,weak) BLBarChartToolView *barChatView;
 
 @end
 
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 BLChartTool *chartTool = [[BLChartTool alloc]init];
 chartTool.chartToolDelegate = self;
 //CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200)
 [self.view addSubview:[chartTool getHaveStatisticsAndAutoAdJustBarChart]];
 }
 
 -(NSArray *)chartToolDataResouce{
 return @[@{@"transAmt":@"1000.0",@"mon":@"1"},@{@"transAmt":@"2000.0",@"mon":@"2"},@{@"transAmt":@"3000.0",@"mon":@"3"},@{@"transAmt":@"4000.0",@"mon":@"4"},@{@"transAmt":@"3500.0",@"mon":@"5"},@{@"transAmt":@"4000.0",@"mon":@"6"}];
 }
 
 -(NSArray *)chartToolColor{
 return @[[UIColor redColor],[UIColor yellowColor],[UIColor purpleColor],[UIColor greenColor],[UIColor blueColor],[UIColor blackColor],[UIColor orangeColor]];
 }
 */