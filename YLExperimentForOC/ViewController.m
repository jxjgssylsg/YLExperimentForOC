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
    //[self testNSDate];
    [self testNSTimeZone];
}

- (void)testNSTimeZone
{
    
    //
    //NSTimeZone可以得看看
    
    /*
     NSDate *currentDate = [NSDate date];
     NSLog(@"%@",currentDate);
     
     NSTimeZone *zone = [NSTimeZone systemTimeZone];
     NSInteger interval = [zone secondsFromGMTForDate:currentDate];
     
     NSDate *localDate = [currentDate dateByAddingTimeInterval:interval];
     
     NSLog(@"正确的当前时间 %@",localDate);
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
     
     
     [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0900"]]; // 只能够修改该程序的defaultTimeZone，不能修改系统的，更不能修改其他程序的。
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     
     NSDate *now = [NSDate date];
     NSLog(@"now:%@", [dateFormatter stringFromDate:now]);
     
     // 也可直接修改NSDateFormatter的timeZone变量
     dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
     NSLog(@"now:%@", [dateFormatter stringFromDate:now]);
     
     
     NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
     NSLog(@"%@",[timeZone description]);
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
    NSString *strDate = [dateFormatter stringFromDate:dateOne];//转的时候会根据-时区-变化,加了8小时
    NSLog(@"转换后 = %@", strDate);
    
    //设置了locale和timeZone似乎也没什么改变......? 同样加了8小时
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    NSLog(@"%@",dateFormatter.timeZone);
    NSLog(@"%@",dateFormatter.locale);
    strDate =[dateFormatter stringFromDate:dateOne];//转的时候会根据-时区-变化,加了8小时
    NSLog(@"转换后 = %@", strDate);
    
//---------------------------- NSString -----> NSDate ------------------------------------//
    
    //NSString -----> NSDate
    NSDateFormatter *dateFormatterTwo = [[NSDateFormatter alloc] init];
    [dateFormatterTwo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatterTwo dateFromString:@"2016-04-29 17:46:03"]; //转的时候会根据-时区-变化,减掉了8小时
    NSLog(@"%@",date);//输出2016-04-29 09:46:03 +0000 对比 2016-04-29 17:46:03
    
    //设置了locale和timeZone似乎也没什么改变......? 减掉了8小时
    dateFormatterTwo.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatterTwo.timeZone = [NSTimeZone localTimeZone];
    date = [dateFormatterTwo dateFromString:@"2016-05-29 17:46:03 "];//转的时候会根据-时区-变化,减掉了8小时
    NSLog(@"%@",date);//输出2016-05-29 09:46:03 +0000 对比 2016-05-29 17:46:03
    
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
