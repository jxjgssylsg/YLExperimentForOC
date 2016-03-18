//
//  TableViewControllerTwo.m
//  YLExperimentForOC
//
//  Created by Mr_db on 16/6/4.
//  Copyright (c) 2016年 yilin. All rights reserved.
//

#import "TableViewControllerTwo.h"

@interface TableViewControllerTwo ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_cities;
}

@end

@implementation TableViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)initData {
    NSArray *GroupOne = @[@"shandong",@"guangxi",@"taibei",@"上海",@"广州",@"天津",@"北京",@"shanghai"];
    NSArray *GroupTwo =  @[@"heibei",@"beijingdaxue",@"jiangxicaijing",@"上海",@"广州",@"天津",@"北京",@"shanghai",@"guangzhou",@"tianjing",@"南昌",@"xinjiang"];
    _cities = @[GroupOne,GroupTwo];

}

#pragma mark - 数据源方法
//多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"计算分组数");
    return _cities.count;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"组:%li 行数:%ld",(long)section,[_cities[section] count]);
    return [_cities[section] count];
}

//每行是什么
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSIndexPath是一个对象，记录了组和行信息
    NSLog(@"生成单元格 (组：%li  行%li) ",(long)indexPath.section,(long)indexPath.row);
    NSString *text = nil;
    text = ((NSArray *)_cities[indexPath.section])[indexPath.row];
    
    //重用cell
    static NSString *cellIdentifier = @"UITableViewCellIdentifierKey1";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];//注意UITableViewCellStyle 有多种,可点进去看看
    }
    cell.textLabel.text = text;
    return cell;
}

#pragma mark 返回每组头标题名称
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return @"第一组";
    } else {
        return @"第二组";
    }
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (0 == section) {
        return @"第一组尾部咯";
    } else {
        return @"第二组尾部咯";
    }

}

#pragma mark - 代理方法
#pragma mark 设置分组头部标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 100;
    }
    return 30;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 100;
    }
    return 30;
}

#pragma mark 设置每行高度（每行高度可以不一样）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( (0 == indexPath.row % 2) && (1 == indexPath.section) ) {
        return 70;
    } else {
        return 30;
    }
        
}

#pragma mark 返回每组标题索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSLog(@"生成组索引");
    NSArray *indexs=@[@"1",@"2"];
    return indexs;
}

// 点击事件,刷新
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了 %ld  %ld",(long)indexPath.section,(long)indexPath.row);
    //第一组整体刷新,第二组局部刷新
    if (0 == indexPath.section) {
        [_tableView reloadData];
    } else {
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
