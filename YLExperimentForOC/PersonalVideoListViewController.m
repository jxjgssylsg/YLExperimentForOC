////
////  UICollectionViewDemo1
////
////  Created by syl on 15/11/1.
////  Copyright © 2015年 baidu. All rights reserved.
////
//
//#import "PersonalVideoListViewController.h"
//#import "PersonalVideoListVCCell.h"
//#import "PersonalHomePageCollectionView.h"
//#import "PersonalVideoListVCHeadView.h"
//#import "CoreDefinition.h"
//#import "MJRefresh.h"
//#import "PersonalHomePageService.h"
//#import "DefineHelper+HttpEngine.h"
//#import "PersonalVideoModel.h"
//#import "LogHelper.h"
//#import "UIImageView+WebCache.h"
//#import "UIButton+WebCache.h"
//#import "YYKit.h"
//#import "SecondKnowVideoDetailViewController.h"
//#import "Masonry.h"
//
//static NSString * const CellReuseIdentify = @"CellReuseIdentify";
//static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
//static NSString * const SupplementaryViewFooterIdentify = @"SupplementaryViewFooterIdentify";
//
//#define kPersonalVideoCellWidth     162
//#define kPersonalVideoCellHeight    127
//
//@interface PersonalVideoListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//
//@property (strong, nonatomic) PersonalHomePageCollectionView *collectionView;
//@property (strong, nonatomic) PersonalVideoListVCHeadView *headView;
//@property (nonatomic, copy) NSArray <PersonalVideoModel *> *datas;
//@property (nonatomic, strong) PersonalUserInfo *userInfo;
//
//@property (nonatomic, assign) NSInteger currentPageIndex;
//
//@property (nonatomic, copy) NSString *UserKey;
//
//@end
//
//@implementation PersonalVideoListViewController
//#pragma mark - life cycle
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    [self initSubViews];
//    [self initData];
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self setNavigatorController];
//    
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//    
//    // reset navigationBar
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = nil;
//}
//
//- (instancetype)initWithUserKey:(NSString *)UserKey {
//    if (self = [super init]) {
//        _UserKey = UserKey;
//    }
//    return self;
//}
//#pragma mark title
//
//- (NSString *)viewControllerTitle {
//    return @"个人主页";
//}
//
//- (NSString *)viewControllerPageView {
//    return @"个人主页";
//}
//
//- (void)prepareForUserInterface {
//
//}
//
//#pragma mark - Update the page index
//- (void)updataCurentIndex:(NSInteger)index {
//    _currentPageIndex = index;
//}
//
//
//// get data for colletionView
//- (void)initData {
//    _currentPageIndex = -1;
//    
//    weakly(weakSelf);
//    [[PersonalHomePageService buildService] loadPersonalVideoListWithUserKey:_UserKey PageNum:0 Complete:^(Http_ResponseResult result, BOOL hasMore, NSDictionary *responseData, NSError *error) {
//        Log(@"here to load data")
//        if (isResponseSuccess(result)) {
//            PersonalVideoListModel *modelList = responseData[kHttpResponseValuesKey];
//            if (modelList != nil) {
//                weakSelf.userInfo = modelList.userinfo;
//                if (weakSelf.userInfo) {
//                    // set userInfo
//                    [weakSelf setUserInfo];
//                }
//                
//                NSArray <PersonalVideoModel *> *models = arrayValue(modelList.datas);
//                if (models.count > 0) {
//                    weakSelf.datas = models;
//                    [weakSelf updataCurentIndex:0];
//                    [_collectionView reloadData];
//                    
//                }
//            } else {
//                // no data
//                [weakSelf showingFailedDialogWithMessage:@"没有数据"];
//                
//            }
//        }
//    }];
//
//}
//
//- (void)initSubViews {
//    [self setNavigatorController];
//    [self setupCollectionView];
//    
//}
//
//- (void)setUserInfo {
//    if (_userInfo) {
//        [_headView.avatarBtn setBackgroundImageWithURL:[NSURL URLWithString:_userInfo.portraitUrl] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"Avatar"] options:YYWebImageOptionRefreshImageCache completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//            if (image) {
//                NSData *data = UIImagePNGRepresentation(image);
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserDefaultsUserAvatarKey];
//            }
//        }];
//        
//       // [_headView.avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:_userInfo.portraitUrl] placeholderImage:[UIImage imageNamed:@"Avatar"]];
//        
//        _headView.userName.text = _userInfo.uname;
//        _headView.collectionNumLabel.text = @(_userInfo.onlineSecondNum).stringValue;
//        
//    }
//}
//
//- (void)setupCollectionView {
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumInteritemSpacing = 0; // 同一行 cell 之间的行间距
//    layout.minimumLineSpacing = Px(32); // 行与行的间距
//    // layout.itemSize = CGSizeMake(Px(324), Px(180));
//    layout.headerReferenceSize = CGSizeZero; // header size
//    layout.footerReferenceSize = CGSizeZero; // footer size
//    
//    _collectionView = [[PersonalHomePageCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout]; // collectionView 和 layout 一起初始化
//    _collectionView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//    
//    _collectionView.backgroundColor = [UIColor whiteColor];
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
//    [self.view addSubview:_collectionView];
//    
//    // 注册
//    [_collectionView registerNib:[UINib nibWithNibName:@"PersonalVideoListVCCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CellReuseIdentify];
//    
//    UINib *headerNib = [UINib nibWithNibName:@"PersonalVideoListVCHeadView" bundle:[NSBundle mainBundle]];
//    [_collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify];
//    
//    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryViewFooterIdentify];
//    
//    // refresh and load more
//    weakly(weakSelf);
//    __weak UICollectionView *collectionView = self.collectionView;
//    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf refreshData];
//    }];
//    collectionView.mj_header.automaticallyChangeAlpha = YES;
//    
//    // footer
//    collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
//}
//
//#pragma mark - refresh and load more
//
//- (void)loadMoreData {
//    weakly(weakSelf);
//    [[PersonalHomePageService buildService] loadPersonalVideoListWithUserKey:_UserKey PageNum:(_currentPageIndex + 1)  Complete:^(Http_ResponseResult result, BOOL hasMore, NSDictionary *responseData, NSError *error) {
//        Log(@"here to load data");
//        if (isResponseSuccess(result)) {
//            [weakSelf.collectionView.mj_footer endRefreshing];
//            PersonalVideoListModel *modelList = responseData[kHttpResponseValuesKey];
//            if (modelList != nil) {
//                NSArray <PersonalVideoModel *> *models = arrayValue(modelList.datas);
//                if (models.count > 0) {
//                    if (_currentPageIndex >= 0) {
//                        // 下一页
//                        weakSelf.datas = [self.datas arrayByAddingObjectsFromArray:models];
//                        [weakSelf updataCurentIndex:_currentPageIndex + 1];
//                    } else {
//                        // 第一页
//                        weakSelf.datas = models;
//                    }
//                    
//                    [_collectionView reloadData];
//                } else {
//                    // no more data
//                    [weakSelf.collectionView.mj_footer resetNoMoreData];
//                }
//            }
//        } else {
//            // TODO fail
//            Log(@"loadMoreData ---- fail");
//        }
//    }];
//
//    Log(@"hahah----loadMoreData--------");
//}
//
//- (void)refreshData {
//    // YL Personal HomePage
//    weakly(weakSelf);
//    [[PersonalHomePageService buildService] loadPersonalVideoListWithUserKey:_UserKey PageNum:0 Complete:^(Http_ResponseResult result, BOOL hasMore, NSDictionary *responseData, NSError *error) {
//        Log(@"ssss");
//        [weakSelf.collectionView.mj_header endRefreshing];
//        if (isResponseSuccess(result)) {
//            PersonalVideoListModel *modelList = responseData[kHttpResponseValuesKey];
//            if (modelList != nil) {
//                NSArray <PersonalVideoModel *> *models = arrayValue(modelList.datas);
//                if (models.count > 0) {
//                    weakSelf.datas = models;
//                    [_collectionView reloadData];
//                    [weakSelf updataCurentIndex:0];
//                }
//            } else {
//                // no data
//                [weakSelf showingFailedDialogWithMessage:@"没有数据"];
//            }
//
//        } else {
//            // TODO fail
//            Log(@"refreshData ---- fail");
//        }
//    }];
//
//    Log(@"hahah-----refreshData------");
//}
//
//- (void)setNavigatorController {
//    [self initLeftButton];
//    // back item color
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithRGB:0xffffff]];
//    self.navigationController.navigationBar.translucent = YES;
//    // 自定义背景
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    // 消除阴影
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    
//}
//
//#pragma mark - UICollectionViewDataSource method
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _datas.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    PersonalVideoListVCCell *cell = (PersonalVideoListVCCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentify forIndexPath:indexPath];
//    // cell.backgroundColor = [UIColor lightGrayColor];
//    cell.model = _datas[indexPath.row];
//    return cell;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        // header 头部
//        UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SupplementaryViewHeaderIdentify forIndexPath:indexPath];
//        
//        _headView = (PersonalVideoListVCHeadView *)supplementaryView;
//        _headView.size = CGSizeMake(screenWidth, Px(452));
//        
//        return supplementaryView;
//        
//    }
//    return nil;
//}
//
//// 定义每个 Cell 的大小, YL Personal HomePage
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    float Proportion = screenWidth / 375;
//    CGSize size = CGSizeMake(kPersonalVideoCellWidth * Proportion, kPersonalVideoCellHeight * Proportion);
//    return size;
//}
//    
//#pragma mark - UICollectionViewDelegate method
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self enterToSecondVideoPage:indexPath.row];
//    NSLog(@"%@", indexPath);
//    
//}
//
//- (void)enterToSecondVideoPage:(NSInteger)index {
//    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:[NSBundle mainBundle]];
//    SecondKnowVideoDetailViewController *VideoDetailVC = (SecondKnowVideoDetailViewController *)[homeStoryboard instantiateViewControllerWithIdentifier:@"video"];
//    VideoDetailVC.secondId = _datas[index].secondId;
//    [self.navigationController  pushViewController:VideoDetailVC animated:YES];
//}
//
//#pragma mark - UICollectionViewDelegateFlowLayout method
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if(section == 0) {
//        return CGSizeMake(screenWidth, Px(452));
//    }
//    
//    return CGSizeZero;
//}
//
//// YL Personal HomePage
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//     float Proportion = screenWidth / 375;
//    int insetsValue = (screenWidth - kPersonalVideoCellWidth * Proportion * 2) / 3;
//    return UIEdgeInsetsMake(insetsValue, insetsValue, insetsValue, insetsValue);
//   // return UIEdgeInsetsMake(Px(32), Px(32), Px(32), Px(32)); // 分别为上、左、下、右
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
