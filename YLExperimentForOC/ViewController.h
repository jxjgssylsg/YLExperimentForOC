//
//  ViewController.h
//  YLExperimentForOC
//
//  Created by syl on 16/4/26.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)testBoundingRectWithSizeMethods;

- (void)testNSDictionary;

- (void)creatQRCode;

- (void)creatSimpleCalendar;

- (void)testNSDate;

- (void)testNSTimeZone;

- (void)testNSLocale;

- (void)testNSDateFormatter;

- (void)testNSDateComponents;

- (void)testNSCalendar;

// 最基本的 UITableView
- (void)creatUITableViewOne;

// 基本功能:增加,删除,排序,点击等
- (void)creatUITableViewTwo;

// 搜索功能 <1> 逻辑相对复杂
- (void)creatUITableViewThree;

// 搜索功能 <2> 利用UISearchController, 原UISearchDisplayController Deprecated 弃用了
- (void)creatUITableViewFour;

// 自定义 TableViewcell,通过xib形式
- (void)creatUITableViewFive;

// 自定义 TableViewcell,通过代码形式
- (void)creatUITableViewSix;

// 自定义 TableViewcell 侧滑多按钮等功能
- (void)creatUITableViewSeven;

// UIScrollView 的基本功能
- (void)creatUIScrollViewOne;

// 通过 UIView 的旋转,放大,移动
- (void)creatUIScrollViewTwo;

// UIScrollView 的循环图片浏览器
- (void)creatUIScrollViewThree;

// --for company
- (void)modifyDay;

- (void)testNSTimerForCompany;

- (void)creatTimeZoneTableView;

// 加减界面
- (void)creatAddSubInterface;

// Tags 选择
- (void)creatTagSelectInterface;
@end








