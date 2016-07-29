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

@property (strong, nonatomic) UINavigationController *navi; // 数据源
@property (strong, nonatomic) NSMutableArray *dataArray;    // 数据源
@property (strong, nonatomic) NSMutableArray *frameArray;   // cell高度
@property (strong, nonatomic) UITableView *tableView;       // tableView

@end

@implementation BFEForeignAnswerViewController

#pragma mark ------------------ 获取数据源（模型数据源、模型高度数据源） ------------------

- (NSArray *)dataArray { // 懒加载
    if (!_dataArray) {
        _dataArray = [AnswerVCCellDataModelGroup AnswerVCCellDataModelGroupWithNameOfContent:@"AnswerMessages.plist"];
        _frameArray = [AnswerVCCellDataModelFrame AnswerVCCellDataModelFrameWithArray:_dataArray]; // 对应的 frameArray
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor clearColor];
    [self setUpTableView];
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
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCellDataModelFrame *modelFrame = [_frameArray objectAtIndex:indexPath.row];
    return modelFrame.cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerVCCellIdentifier ];
    // 发现当cell队列没用可重用的时候,会自动去调用 initWithStyle:reuseIdentifier: 方法,cell 似乎不会为空,但还是建议做空处理,至少没有坏处吧,且规范.
    if (!cell) {
        NSLog(@"cell kong kong kong kong kong kong kong");
        cell = [[AnswerVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerVCCellIdentifier];
    }
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.frameModel = [_frameArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerVCCellDataModel *selCell = (AnswerVCCellDataModel *)_dataArray[indexPath.row];
    NSLog(@"%@",selCell);
    selCell.isRead = YES;
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
//    UIViewController *tmp = [[UIViewController alloc] init];
//    tmp.view.frame = CGRectMake(50, 50, 200, 200);
//    tmp.view.backgroundColor = [UIColor redColor];
//    [self.parentViewController.navigationController pushViewController:tmp animated:YES];
    
}

@end
