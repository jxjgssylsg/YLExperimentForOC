
#import "KCMainViewController.h"
#import "KCContact.h"
#import "KCContactGroup.h"

@interface KCMainViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_contacts;//联系人模型
    NSIndexPath *_selectedIndexPath;//当前选中的组和行
}

@end

@implementation KCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    [self initData];
    
    // 创建一个分组样式的 UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // 设置数据源，注意必须实现对应的 UITableViewDataSource 协议
    _tableView.dataSource=self;
    // 设置代理
    _tableView.delegate=self;
    
    [self.view addSubview:_tableView];
}

#pragma mark 加载数据
-(void)initData {
    _contacts=[[NSMutableArray alloc]init];
    
    KCContact *contact1=[KCContact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    KCContactGroup *group1=[KCContactGroup initWithName:@"Location Time Zone" andDetail:@" " andContacts:[NSMutableArray arrayWithObjects:contact1, nil]];
    [_contacts addObject:group1];
    
    KCContact *contact3=[KCContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    KCContact *contact4=[KCContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    KCContact *contact5=[KCContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    KCContact *contact6=[KCContact initWithFirstName:@" " andLastName:@" " andPhoneNumber:@" "];
    KCContact *contact7=[KCContact initWithFirstName:@" " andLastName:@" " andPhoneNumber:@" "];
    KCContact *contact8=[KCContact initWithFirstName:@" " andLastName:@" " andPhoneNumber:@" "];
    KCContact *contact9=[KCContact initWithFirstName:@" " andLastName:@" " andPhoneNumber:@" "];
    KCContactGroup *group2=[KCContactGroup initWithName:@"Choose Your Time Zone" andDetail:@"  " andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, contact6,contact7,contact8,contact9,nil]];
    [_contacts addObject:group2];
    
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return _contacts.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    KCContactGroup *group1 = _contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个对象，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    KCContactGroup *group = _contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
    //首先根据标识去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //如果缓存池没有到则重新创建并放到缓存池中
    if(!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text=[contact getName];
    cell.detailTextLabel.text = @"ha";//contact.phoneNumber;
    NSLog(@"cell:%@",cell);
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%li）名称",(long)section);
    KCContactGroup *group=_contacts[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSLog(@"生成尾部（组%li）详情",(long)section);
    KCContactGroup *group=_contacts[section];
    return group.detail;
}

//#pragma mark 返回每组标题索引
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSLog(@"生成组索引");
//    NSMutableArray *indexs=[[NSMutableArray alloc]init];
//    for(KCContactGroup *group in _contacts){
//        [indexs addObject:group.name];
//    }
//    return indexs;
//}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section==0) {
        return 50;
    }
    return 30;
}

#pragma mark 设置每行高度（每行高度可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark 设置尾部说明内容高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

#pragma mark 点击行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath=indexPath;
   // KCContactGroup *group=_contacts[indexPath.section];
   // KCContact *contact=group.contacts[indexPath.row];
    NSLog(@"你点击了 %ld  %ld",(long)indexPath.section,(long)indexPath.row);
}

#pragma mark 重写状态样式方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end