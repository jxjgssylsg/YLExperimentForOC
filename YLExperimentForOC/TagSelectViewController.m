//
//  TagSelectViewController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "TagSelectViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "CollectionViewCell.h"
#import "CollectionHeaderView.h"

#define kCollectionViewCellsHorizonMargin 12          // cell 之间的间隔
#define kCollectionViewCellHeight 30                  // cell 的高

#define kCollectionViewToLeftMargin 16                // 左
#define kCollectionViewToTopMargin 12                 // 上
#define kCollectionViewToRightMargin 16               // 右
#define kCollectionViewToBottomtMargin  10            // 下

#define kCellTextExtrarMargin 19                      // text 额外加的宽度

typedef void (^IsLimitWidth)(BOOL yesORNo,float *data);


static NSString * const kCellIdentifier = @"CellIdentifier"; // Cell 标识
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier"; // HeadView 标识

@interface TagSelectViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TagSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [@[@"不够有趣", @"不够温柔", @"讲解不清楚", @"说中文太多",@"热点", @"不够漂亮啊, 下次来个萌妹子", @"反正就是不喜欢这个老师1", @"反正就是不喜欢这个老师2", @"反正就是不喜欢这个老师3"] mutableCopy];
    self.selectedTags = [[NSMutableArray alloc] init];
    [self addCollectionView];
    
}

- (void)addCollectionView {
    CGRect collectionViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
    UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    
    [self.collectionView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.collectionView.scrollsToTop = NO;
    // self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
    
    CGSize contentSize =  _collectionView.collectionViewLayout.collectionViewContentSize; // 内容的大小
    _collectionView.backgroundColor = [UIColor redColor];
    self.preferredContentSize = contentSize; // controller 内容大小
    self.view.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
    self.view.clipsToBounds = YES; // 边界减掉
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    // return [self.dataSource count];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 24);
    cell.titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    NSString *text = self.dataSource[indexPath.row];
    cell.titleLabel.text = text;
    if (![self.selectedTags containsObject:text]) {
        cell.selectedImage.hidden = YES;
    } else {
        cell.selectedImage.hidden = NO;
    }
    // cell.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cell.selectedImage setFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    CGFloat top = 5; // 顶端盖高度
    CGFloat bottom = 17 ; // 底端盖高度
    CGFloat left = 5; // 左端盖宽度
    CGFloat right = 17; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    cell.selectedImage.image = [cell.selectedImage.image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return cell;
}
// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    CollectionViewCell *selectItem = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    selectItem.selectedImage.hidden = !selectItem.selectedImage.hidden;
    if ([self.selectedTags containsObject:selectItem.titleLabel.text]) {
        [self.selectedTags removeObject:selectItem.titleLabel.text];
    } else {
        [self.selectedTags addObject:selectItem.titleLabel.text];
    }
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        CollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier forIndexPath:indexPath];
        headerView.titleLabel.text = @"关于老师";
        
       // headerView.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height - 20);
       // headerView.backgroundColor = [UIColor lightGrayColor];
       // headerView.clipsToBounds = YES;
        
        return (UICollectionReusableView *)headerView;
    }
    return nil;
}


- (float)getCollectionCellWidthText:(NSString *)text {
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:13]}];
    
    cellWidth = ceilf(size.width) + kCellTextExtrarMargin;
    cellWidth = [self checkCellLimitWidth:cellWidth isLimitWidth:nil]; // 尝试把 block 实现
  
    return cellWidth;
}

- (float)checkCellLimitWidth:(float)cellWidth isLimitWidth:(IsLimitWidth)isLimitWidth {
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth ? isLimitWidth(YES, &cellWidth) : nil; // isLimitWidth block
        return cellWidth;
    }
    isLimitWidth ? isLimitWidth(NO, &cellWidth):nil;
    return cellWidth;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    float cellWidth = [self getCollectionCellWidthText:text];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kCollectionViewCellsHorizonMargin; // cell之间的间隔
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 四周边距
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
    // return UIEdgeInsetsMake(0, 0, 0, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
