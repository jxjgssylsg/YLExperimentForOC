//
//  calendarViewController.h
//  calendar
//
//  Created by mingdffe on 16/3/23.
//  Copyright © 2016年 mingdffe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFButton.h"
#import "CalendarModeInfo.h"

@interface CalendarViewController : UIViewController
{
    NSCalendar     *myCalendar;               //日历
    NSRange        monthRange;                //一个月有多少天
    NSInteger      currentDayIndexOfMonth; //现在在月里面是几号
    NSInteger      firstDayIndexOfWeek;    //第一天在第一周的什么位置
    NSInteger      currentTag;            //当前的背激活的日期的tag
    NSMutableArray *dayButtons;           //日子的button
    NSArray        *Agendas;                //当月的buttons的日程,包含了model集合
    NSDate         *dateNeedshow;           //需要展示的时间
}
- (id)initWithDate:(NSDate *)Date andAgendaOfMonth:(NSArray *)agendas;

@end
