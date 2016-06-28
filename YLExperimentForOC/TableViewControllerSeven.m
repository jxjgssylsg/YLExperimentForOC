//
//  TableViewControllerSeven.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/6/27.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "TableViewControllerSeven.h"
#import "CellSeven.h"

@interface TableViewControllerSeven () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
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
    //注. 当启用了下面两句的时候, editingStyleForRowAtIndexPath 方法就不会调用了! 要注意!
    // _tableView.allowsSelectionDuringEditing = YES; // 允许选择
    //  _tableView.allowsMultipleSelectionDuringEditing = YES; // 允许多行选择
}
- (void)initData {
    _cities = @[@"shandong",@"guangxi",@"taibei",@"上海",@"广州",@"天津",@"北京",@"shanghai",@"guangzhou",@"tianjing",@"南昌",@"xinjiang"];
}
// 旋转屏幕的时候关闭侧滑
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    // Need to do this to keep the view in a consistent state (layoutSubviews in the cell expects itself to be "closed")
    [[NSNotificationCenter defaultCenter] postNotificationName:CellSevenEnclosingTableViewDidBeginScrollingNotification object:_tableView];
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
//    注. 自己的代理需要别人设置噢
//    [self.delegate tableViewController:self didChangeEditing:editing];
    [super setEditing:editing animated:animated];
    NSLog(@" TableViewControllerSeven setEditing began ");
    [_tableView setEditing:!_tableView.isEditing animated:true]; // 设置 tableview 编辑模式,会先处理 cell 的编辑模式
    NSLog(@" TableViewControllerSeven setEditing Done ");
    
}
// 设置编辑时候的左边的样式 editingStyle
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"UITableViewCellEditingStyle editingStyleForRowAtIndexPath");
    static int i = 0;
    if (i++ < 3) {
        return UITableViewCellEditingStyleInsert;
    } else if (i++ < 5) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete; // 这种是多选
    }
}

#pragma UIScrollViewDelegate Methods

// 当 scrollview 有滑动的时候,取消侧滑
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:CellSevenEnclosingTableViewDidBeginScrollingNotification object:scrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
