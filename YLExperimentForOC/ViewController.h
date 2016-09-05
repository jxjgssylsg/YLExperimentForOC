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

// NSTimer
- (void)testNSTimer;

// MasonryOne   ❤️ 
- (void)testMasonryOne;

// MasonryTwo   ❤️ ❤️
- (void)testMasonryTwo;

// MasonryThree ❤️ ❤️
- (void)testMasonryThree;

// MasonryFour  ❤️ ❤️
- (void)testMasonryFour;

// MasonryFive  ❤️ ❤️ ❤️, textField 跟随着键盘移动~
- (void)testMasonryFive;

// MasonrySix  ❤️ ❤️ ❤️ ❤️, 各种类型例子
- (void)testMasonrySix;

// 基本的 CollectionView
- (void)creatUICollectionViewOne;

// 日历.课程表 自定义布局 CollectionView
- (void)creatUICollectionViewTwo;

// 基础 CollectionView, footer and header, 点击放大,缩小
- (void)creatUICollectionViewThree;

// 自定义布局 CollectionView 不错!
- (void)creatUICollectionViewFour;

// 自定义布局 CollectionView CircleLayout, Decoration View
- (void)creatUICollectionVieFive;


// ------------------------------ FCOM ------------------------------- //

- (void)modifyDay;

- (void)testNSTimerForCompany;

- (void)creatTimeZoneTableView;

// 加减界面
- (void)creatAddSubInterface;

// Tags 选择 collectionView
- (void)creatTagSelectInterface;

// Answer interface UI UItableview 自定义 cell
- (void)creatTeacherAnswerInterface;

// Font NSMutableParagraphStyle
- (void)creatAnswerInfoInterface;

// scrollView use as uiview to addPullRefreshAction
- (void)creatUIScrollViewOneFCOM;

@end








