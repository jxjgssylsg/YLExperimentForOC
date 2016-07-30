//
//  BFEForeignAnswerViewController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "BFEForeignAnswerViewController.h"
#import "AnswerVCCell.h"
#import "AnswerVCCellDataModel.h"
#import "AnswerVCCellDataModelFrame.h"
#import "AnswerVCCellDataModelGroup.h"

static NSString *AnswerVCCellIdentifier = @"CustomCellIdentifier";

@interface BFEForeignAnswerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UINavigationController *navi;     //
@property (strong, nonatomic) NSMutableArray *dataArray;        //
@property (strong, nonatomic) NSArray *showArray;               // show datas
// @property (strong, nonatomic) NSMutableArray *frameArray;    // cell height
@property (strong, nonatomic) UITableView *tableView;           // tableView
@property (assign, nonatomic) BOOL Done;                        // show Done or Todo tableview

@end

@implementation BFEForeignAnswerViewController

#pragma mark ------------------ 获取数据源（模型数据源、模型高度数据源） ------------------

- (NSArray *)dataArray { // 懒加载
    if (!_dataArray) {
        _dataArray = [AnswerVCCellDataModelGroup AnswerVCCellDataModelGroupWithNameOfContent:@"AnswerMessages.plist"];
       // _frameArray = [AnswerVCCellDataModelFrame AnswerVCCellDataModelFrameWithArray:_dataArray]; // 对应的 frameArray
        
        // 对象排序 $$
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        _dataArray = [[_dataArray sortedArrayUsingComparator:^NSComparisonResult(AnswerVCCellDataModel *a, AnswerVCCellDataModel *b) {
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            NSDate *date1 = [dateFormatter dateFromString:a.sendTime];
            NSDate *date2 = [dateFormatter dateFromString:b.sendTime];
            // return first > second ;
            return [date1 compare:date2]; // 如果是 nsobject
        }] mutableCopy];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor clearColor];
    [self setUpTableView];
    [self setUpSegmentControl];
}

#pragma mark ------------------ 创建segment ------------------
- (void)setUpSegmentControl {
    UISegmentedControl *segMent=[[UISegmentedControl alloc] initWithFrame:CGRectMake(70.0f, 5.0f, 180.0f, 34.0f) ];
    [segMent insertSegmentWithTitle:@"tem1" atIndex:0 animated:YES];
    [segMent insertSegmentWithTitle:@"tem2" atIndex:1 animated:YES];
    segMent.momentary = NO;  //设置在点击后是否恢复原样
    segMent.multipleTouchEnabled=NO;  //可触摸
    segMent.selectedSegmentIndex =0;   //指定索引
    // segmentedControl.tintColor = [UIColor blackColor];
    // segmentedControl.tintColor = [UIColor colorWithRed:224/255 green:225/255 blue:226/255 alpha:1];
    segMent.tintColor =[UIColor blackColor];
    // segmentedControl
    [segMent addTarget:self action:@selector(segMentClick:) forControlEvents:UIControlEventValueChanged];
    // self.navigationItem.titleView = segMent;
     self.parentViewController.navigationItem.titleView = segMent;
}
- (void)segMentClick:(UISegmentedControl *)segmentControl {
    NSLog(@"%ld",segmentControl.selectedSegmentIndex);
    if (0 == segmentControl.selectedSegmentIndex) {
        _Done = NO;
    } else {
        _Done = YES;
    }
    [_tableView reloadData];
}
#pragma mark ------------------ 创建tableView ------------------

- (void)setUpTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[AnswerVCCell class] forCellReuseIdentifier:AnswerVCCellIdentifier];
    
}

#pragma mark ------------------ tableViewDelegate ------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return self.dataArray.count;
   NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"isEvaluate == %@", [NSNumber numberWithBool:_Done]];
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isEvaluate == NO"]; // predicate Bool
    _showArray = [self.dataArray filteredArrayUsingPredicate:newPredicate];
    return _showArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCellDataModel *dataModel = [_showArray objectAtIndex:indexPath.row];
    return dataModel.modelFrame.cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerVCCellIdentifier ];
    // 发现当cell队列没用可重用的时候,会自动去调用 initWithStyle:reuseIdentifier: 方法,cell 似乎不会为空,但还是建议做空处理,至少没有坏处吧,且规范.
    if (!cell) {
        NSLog(@"cell kong kong kong kong kong kong kong");
        cell = [[AnswerVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerVCCellIdentifier];
    }
    cell.model = [_showArray objectAtIndex:indexPath.row];
    cell.frameModel = cell.model.modelFrame;  // [_frameArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCellDataModel *selCell = (AnswerVCCellDataModel *)_showArray[indexPath.row];
    NSLog(@"%@",selCell);
    selCell.isRead = YES;
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    // [_tableView reloadData];
//    UIViewController *tmp = [[UIViewController alloc] init];
//    tmp.view.frame = CGRectMake(50, 50, 200, 200);
//    tmp.view.backgroundColor = [UIColor redColor];
//    [self.parentViewController.navigationController pushViewController:tmp animated:YES];
    
}

@end
