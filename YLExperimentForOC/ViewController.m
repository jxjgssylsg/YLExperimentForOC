//
//  ViewController.m
//  YLExperimentForOC
//
//  Created by syl on 16/4/26.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "ViewController.h"
#import "QREncoding.h"
#import "CalendarViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self creatQRCode];
   // [self creatSimpleCalendar];
   // [self testNSDate];
    [self testNSTimeZone];
}

- (void)testNSTimeZone
{
//------------------------------ 取得各个时区时间  ---------------------------------//
    
   //取得已知时区名称
    NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
    NSDate *date = [NSDate date];
    //几百个时区,建议断点调试着看
    for(NSString *name in timeZoneNames) {
        NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:name];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //格式
        [formatter setDateFormat:@"YYYY-MM-d HH:mm:ss"];
        //设置时区
        [formatter setTimeZone:timezone];
        //NSDate ----> NSString
        NSString *correctDate = [formatter stringFromDate:date];
        NSLog(@"地点：%@   当地时间：%@",[timezone name], correctDate);
        NSLog(
              @"\nlocalTimeZone = [%@]\nDisplay = [%@]\nGMT = [%d] hours",
              timezone,
              [timezone name],
              (int)[timezone secondsFromGMT] / 60 /60
              );
    }
    
//-------------------方法timeZoneForSecondsFromGMT自定义时区---------------------------//
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    NSString *systemTimeZoneStr =  [df stringFromDate:date];
    df.timeZone = [NSTimeZone defaultTimeZone];//默认时区
    NSString *defaultTimeZoneStr = [df stringFromDate:date];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];//直接指定时区
    NSString *plus8TZStr = [df stringFromDate:date];
    df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0*3600];//这就是GMT+0时区
    NSString *gmtTZStr = [df stringFromDate: date];
    NSLog(@"\n SysTime:%@\n DefaultTime:%@\n +8:%@\n GMT_time:%@",systemTimeZoneStr,defaultTimeZoneStr,plus8TZStr,gmtTZStr);
    
//-------------------- 修改默认时区会影响时间 -----------------------------------------//
    
    // 只能够修改该程序的defaultTimeZone，不能修改系统的，更不能修改其他程序的。
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSLog(@"now:%@", [dateFormatter stringFromDate:now]);
    
    // 也可直接修改NSDateFormatter的timeZone变量
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSLog(@"now:%@", [dateFormatter stringFromDate:now]);

//-------------------- 通过secondsFromGMTForDate方法获得localtime ---------------------//
    
     NSDate *currentDate = [NSDate date];
     NSLog(@"currentDate: %@",currentDate);
     NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:currentDate];
     NSDate *localDate = [currentDate dateByAddingTimeInterval:interval];
     NSLog(@"正确的当前时间localDate: %@",localDate);
    
//-------------------------------- 设置并获取时区的缩写 ---------------------------------//
    
    NSMutableDictionary *abbs = [[NSMutableDictionary alloc] init];
    [abbs setValuesForKeysWithDictionary:[NSTimeZone abbreviationDictionary]];//获得所有缩写
    [abbs setValue:@"Asia/Shanghai" forKey:@"CCD"];//增加一个
    [NSTimeZone setAbbreviationDictionary:abbs];//设置NStimezone的缩写
    NSLog(@"abbs:%@", [NSTimeZone abbreviationDictionary]);

    /*
     NSDate *startDateOfYear;
     NSDate *startDateOfMonth;
     NSDate *startDateOfWeek;
     NSDate *startDateOfDay;
     NSTimeInterval TIOfYear;
     NSTimeInterval TIOfMonth;
     NSTimeInterval TIOfWeek;
     NSTimeInterval TIOfDay;
     [[NSCalendar currentCalendar] rangeOfUnit:NSYearCalendarUnit startDate:&startDateOfYear interval:&TIOfYear forDate:[NSDate date]];
     [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDateOfMonth interval:&TIOfMonth forDate:[NSDate date]];
     [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit startDate:&startDateOfWeek interval:&TIOfWeek forDate:[NSDate date]];
     [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit startDate:&startDateOfDay interval:&TIOfDay forDate:[NSDate date]];
     NSLog(@"firstDateOfYear:%@, FirstDateOfMonth:%@, FirstDateOfWeek:%@, FirstDateOfDay:%@", startDateOfYear, startDateOfMonth, startDateOfWeek, startDateOfDay);
     NSLog(@"\nTIOfYear:%f\nTIOfMonth:%f\nTIOfWeek:%f\nTIOfDay:%f\n", TIOfYear, TIOfMonth, TIOfWeek, TIOfDay);
     
     */
    

    
}
- (void)testNSDate
{
//-------------------------------- NSDate ----> NSString ---------------------------------//
    
    //NSDate ----> NSString
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"年月日,时分秒  yyyy - MM - dd HH:mm:ss"]; //似乎只要有对应的就行
    NSLog(@"%@",dateFormatter.timeZone);
    NSLog(@"%@",dateFormatter.locale);
    NSDate *dateOne = [NSDate date];
    NSLog(@"转换前 = %@", dateOne);
    NSString *strDate = [dateFormatter stringFromDate:dateOne];
    //转的时候会根据-时区-变化,加了8小时,参考NSTimeZone
    NSLog(@"转换后 = %@", strDate);
    
//---------------------------- NSString -----> NSDate ------------------------------------//
    
    //NSString -----> NSDate
    NSDateFormatter *dateFormatterTwo = [[NSDateFormatter alloc] init];
    [dateFormatterTwo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatterTwo dateFromString:@"2016-04-29 17:46:03"];
    //转的时候会根据-时区-变化,减掉了8小时,,参考NSTimeZone
    NSLog(@"%@",date);//输出2016-04-29 09:46:03 +0000 对比 2016-04-29 17:46:03
    
//--------------------------------------------------------------------------------------------//
    
    //日期创建方式
    NSDate *dateTwo = [NSDate date];
    NSString *str = [dateTwo description];
    NSLog(@"%@",str);
    NSDate *dateThree = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*7]; //负数代表过去
    NSLog(@"%@",dateThree);
    //日期是否相同
    BOOL isEqual = [dateTwo isEqual:dateThree];
    NSLog(@"%d",isEqual);
    
    // 从某时间开始经过某秒后的日期时间
    NSDate *dateFour = [dateThree  initWithTimeInterval:60*60*24*7 sinceDate:dateThree];
    NSDate *dateFive = [NSDate dateWithTimeInterval:60*60*24*7 sinceDate:dateThree];
    NSLog(@"%@",dateFour);
    NSLog(@"%@",dateFive);
    
    //某两个时间相隔多久
    NSInteger gap = [dateThree timeIntervalSinceDate:dateFive];
    NSLog(@"%ld",gap);
    
    //取得正确的时间,既UTC世界统一时间 + 8小时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:dateTwo];
    NSDate *localDate = [dateTwo  dateByAddingTimeInterval: interval];
    NSLog(@"正确当前时间 localDate = %@",localDate);
    
    //时间比较
    BOOL later = [dateOne laterDate:localDate];
    NSLog(@"%d",later);
    BOOL early = ([localDate compare:dateOne] == NSOrderedAscending);
    NSLog(@"%d",early);

}

- (void)creatQRCode
{
    CGFloat imageSize = ceilf(self.view.bounds.size.width * 0.6f);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf(self.view.bounds.size.width * 0.5f - imageSize * 0.5f), floorf(self.view.bounds.size.height * 0.5f - imageSize * 0.5f), imageSize, imageSize)];
    //生成二维码图片
    imageView.image = [QREncoding createQRcodeForString:@"http://www.baidu.com" withSize:imageView.bounds.size.width withRed:255 green:0 blue:0];
    //添加中心图片
    UIImageView *centerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhifubao.png"]];
    centerImage.frame= CGRectMake(0, 0, 38.f, 38.f);
    centerImage.center = CGPointMake(CGRectGetWidth(imageView.frame)/2.f, CGRectGetHeight(imageView.frame)/2.f);
    [imageView addSubview:centerImage];
    [self.view addSubview:imageView];

}
- (void)creatSimpleCalendar
{
    CalendarViewController *temp = [[CalendarViewController alloc] init];
    [temp.view setFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self addChildViewController:temp];
    [self.view addSubview:temp.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
