//
//  TableViewControllerSeven.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/6/27.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "TableViewControllerSeven.h"
#import "CellSeven.h"

@interface TableViewControllerSeven () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_cities;
}
@end

@implementation TableViewControllerSeven

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _tableView.allowsSelectionDuringEditing = YES;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
}
- (void)initData {
    _cities = @[@"shandong",@"guangxi",@"taibei",@"上海",@"广州",@"天津",@"北京",@"shanghai",@"guangzhou",@"tianjing",@"南昌",@"xinjiang"];
}

#pragma mark - 数据源方法
// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
 
// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cities.count;
}

// 每行是什么
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = nil;
    text = _cities[indexPath.row];
    
    // 重用cell
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    CellSeven *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[CellSeven alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.scrollViewLabel.text = text;
    cell.textLabel.hidden = YES;
    return cell;
}
// cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    NSLog(@"tableview's delegate is %@",self.delegate);
//    [super setEditing:editing animated:animated];
//    // 注. 自己的代理需要别人设置噢
//    [self.delegate tableViewController:self didChangeEditing:editing];
     [super setEditing:editing animated:animated];
     NSLog(@" TableViewControllerSeven setEditing began ");
    [_tableView setEditing:!_tableView.isEditing animated:true]; // 设置 tableview 编辑模式,会先处理 cell 的编辑模式
     NSLog(@" TableViewControllerSeven setEditing Done ");
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"UITableViewCellEditingStyle editingStyleForRowAtIndexPath");
    static int i = 0;
    if (i++) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
