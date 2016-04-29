//
//  calendarViewController.m
//  calendar
//
///  Created by mingdffe on 16/3/23.
//  Copyright © 2016年 mingdffe. All rights reserved.
//

#import "CalendarViewController.h"



@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (id)initWithDate:(NSDate *)Date andAgendaOfMonth:(NSArray *)agendas
{
    if (self = [super init]) {
        dateNeedshow = Date;
        Agendas = agendas; //
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//若想设置中国日历 设置为NSChineseCalendar
    [myCalendar setFirstWeekday:2]; //设置每周的第一天从星期几开始  设置为 1 是周日，2是周一
    [myCalendar setMinimumDaysInFirstWeek:1];//设置每个月或者每年的第一周必须包含的最少天数  设置为1 就是第一周至少要有一天
    [myCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];//设置时区
    currentTag = -1;//初始 -1 ，代表没有
    dayButtons = [[NSMutableArray alloc] init];
    
    [self calendarSetDate:dateNeedshow];//传入当前日期
    
    for (int i = 0; i < 7; i ++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake( ScreenWidth/7 * (i%7), 5, ScreenWidth/7, 15);// (x,y,width,height);
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0)
        {
            label.text = @"Mon";
        }
        else if (i == 1)
        {
            label.text = @"Tue";
        }
        else if (i == 2)
        {
            label.text = @"Wen";
        }
        else if (i == 3)
        {
            label.text = @"Thu";
        }
        else if (i == 4)
        {
            label.text = @"Fri";
        }
        else if (i == 5)
        {
            label.text = @"Sat";
        }
        else if (i == 6)
        {
            label.text = @"Sun";
        }
        [self.view addSubview:label];
    }
    
}

- (void)calendarSetDate:(NSDate *)date
{
    if (!date) {                             //如果date为空
        NSDate *currentDate = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:currentDate];
        date = [currentDate dateByAddingTimeInterval:interval];
        
    }
  
    monthRange = [myCalendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:date];  //获取date所在的月的天数，即monthRange的length
    
    currentDayIndexOfMonth = [myCalendar ordinalityOfUnit:NSCalendarUnitDay
                                                   inUnit:NSCalendarUnitMonth
                                                   forDate:date];//获取date在其所在的月份里的位置
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    if ([myCalendar rangeOfUnit: NSCalendarUnitMonth startDate:&firstDayOfMonth interval:&interval forDate:date]) //firstDayOfMonth月第一天
    {
        //NSLog(@"ok");
    }
   
    firstDayIndexOfWeek = [myCalendar ordinalityOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitWeekOfMonth
                                              forDate:firstDayOfMonth]; //获取date所在月的第一天在其所在周的位置，即第几天。
    
    [self drawBtn];//画按钮
    
}

-(void)drawBtn
{
    BFButton *btn;
    for (NSUInteger i = firstDayIndexOfWeek - 1 ; i < monthRange.length + firstDayIndexOfWeek -1 ; i ++)
    {
         btn = [BFButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(0, 220, ScreenWidth/7, ScreenWidth/7) title:@"1" titleColor:[UIColor blackColor] backgroundColor:nil backgroundImage:@"btn1" agendaArray:nil  andBlock:^{
            
                        if (currentTag != -1)
                        {
                           //还原
                        }
            
                        }];
        
        btn.frame = CGRectMake( ScreenWidth/7 * (i%7), 30 + ScreenWidth/7*(i/7) + i/7, ScreenWidth/7, ScreenWidth/7);
        btn.tag = i + 2 - firstDayIndexOfWeek;
        
        if (0 == (i%7))
        {

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMinY(btn.frame)-1,ScreenWidth,0.5)];
            UIColor *SeparatorColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];//
            label.backgroundColor = SeparatorColor;
            [self.view addSubview:label];
        }
        
        [btn setTitle:[NSString stringWithFormat:@"%ld",i + 2 - firstDayIndexOfWeek ]
             forState:UIControlStateNormal];
        
        [btn  addTarget:self
                   action:@selector(PressDayBtn:)
            forControlEvents:UIControlEventTouchUpInside];
        
        [dayButtons addObject:btn];
        
        [self.view addSubview:btn];
    }
    NSInteger count_days = [Agendas count];//有课程的日子的天数
    for (NSInteger i = 0; i < count_days; i++)
    {
        
        CalendarModeInfo *temp = Agendas[i];//今天的事项整体
        NSInteger temp_value = temp.IndexOfday;//今天的日期
        BFButton *temp_button = dayButtons[temp_value - 1];
        temp_button.agendas = temp.agendas;
        
        temp_button.backgroundColor =  [UIColor colorWithRed:254/255.0 green:229/255.0 blue:137/255.0 alpha:1];;
        
    }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(btn.frame)+1,ScreenWidth,0.7)];
        UIColor *SeparatorColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];//
        label.backgroundColor = SeparatorColor;
        [self.view addSubview:label];
    
}

-(void)PressDayBtn:(BFButton *)btn
{
    if (currentTag != -1 && currentTag != btn.tag)
    {
         BFButton *temp = dayButtons[currentTag - 1];
         temp.titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    currentTag = btn.tag;
    
    //
    NSInteger lenth = dayButtons.count;
    BFButton *lastButton =  dayButtons[lenth-1];
    NSLog(@"%lu",(unsigned long)dayButtons.count);
    UILabel *todayAgenda = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(lastButton.frame)+ 5,ScreenWidth,50)];
    todayAgenda.backgroundColor = [UIColor whiteColor];
    if ([btn.agendas count] > 0 ) {
        todayAgenda.text = [NSString stringWithFormat:@"%@  %@   %@   %@  %@   %@",[btn.agendas[0] imageAdress],[btn.agendas[0] nameOfCourse],[btn.agendas[0] timeOfCourse],[btn.agendas[1] imageAdress],[btn.agendas[1] nameOfCourse],[btn.agendas[1] timeOfCourse]];
    }
   
    [self.view addSubview:todayAgenda];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
