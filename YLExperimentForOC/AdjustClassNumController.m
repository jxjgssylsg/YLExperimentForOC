//
//  AdjustClassNumController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/12.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AdjustClassNumController.h"

#define TransformToChineseNum(a) \
_contentsDic[[NSString stringWithFormat:@"%ld",a]]

#define ViewCenter self.view.center

@interface AdjustClassNumController () {
    UIButton *_subtractBtn;
    UIButton *_addBtn;
    UIButton *_confirmBtn;
    
    UILabel *_nameLabel;
    UILabel *_numLabel; // num
    UILabel *_contentLabel;
    
    NSInteger _initialNum; // 初始课程数
    NSInteger _maxClassNum;
    NSInteger _numClassNumber;
    NSDictionary *_contentsDic;
}

@end

@implementation AdjustClassNumController

- (instancetype)initWithMaxClassNum:(NSInteger)maxNum currentClassNum:(NSInteger)currentNum {
    if (self = [super init]) {
       // _numClass.text = [NSString  stringWithFormat:@"%ld",currentNum];
        _initialNum = _numClassNumber = currentNum;
        _maxClassNum = maxNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.preferredContentSize = CGSizeMake(230, 254);
}

- (void)initUI {
    _subtractBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _subtractBtn.frame = CGRectMake(47, 124, 30, 30);
    _subtractBtn.backgroundColor = [UIColor clearColor];
    _subtractBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [_subtractBtn setTitle:@"-" forState:UIControlStateNormal];
    [_subtractBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_subtractBtn addTarget:self action:@selector(subtractBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subtractBtn];
    // _subtractBtn.tag = ;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addBtn.frame = CGRectMake(190, 124, 30, 30);
    _addBtn.backgroundColor = [UIColor clearColor];
    _addBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(83, 30, 101, 52);
    _nameLabel.text  = @"Examination \n 课型数目";
    _nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _nameLabel.numberOfLines = 0;
    
    NSRange allRange = [_nameLabel.text rangeOfString:_nameLabel.text];
    NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
    tempParagraph.lineSpacing = 10;
    tempParagraph.alignment = NSTextAlignmentCenter;
    // tempParagraph.firstLineHeadIndent = 20.f;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_nameLabel.text];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:tempParagraph} range:allRange];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    _nameLabel.frame = CGRectMake(83, 30, rect.size.width, rect.size.height);
    _nameLabel.attributedText = attrStr;
    [_nameLabel sizeToFit];
    [self.view addSubview:_nameLabel];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.frame = CGRectMake(115, 106, 50, 60);
    _numLabel.font = [UIFont systemFontOfSize:60];
    _numLabel.textColor = [UIColor colorWithRed:240 / 255.0f green:184 / 255.0 blue:1 / 255.0 alpha:1];

    _numLabel.text  = [NSString stringWithFormat:@"%ld",_initialNum];
    [_numLabel sizeToFit];
    [self.view addSubview:_numLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(99, 178, 0, 0);
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor colorWithRed:157 / 255.0f green:157 / 255.0 blue:157 / 255.0 alpha:1];
    _contentLabel.text = @"课程数不变";
    [_contentLabel sizeToFit];
    [self.view addSubview:_contentLabel];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _confirmBtn.frame = CGRectMake(32, 239, 214, 40);
    _confirmBtn.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:204 / 255.0 blue:36 / 255.0 alpha:1];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_confirmBtn];
    
    
    _contentsDic = @{@"1":@"一", @"2":@"二", @"3":@"三", @"4":@"四", @"5":@"五", @"6":@"六", @"7":@"七"};
}
- (void)confirmBtnPressed:(id)sender {
    __weak AdjustClassNumController *weakself = self;
    [self.delegate confirmBtnPressed:weakself]; //
}
- (void)subtractBtnPressed:(id)sender {
    if (_numClassNumber <= 0) {
        _contentLabel.text =  [NSString stringWithFormat:@"取消该课程"];;
        _subtractBtn.userInteractionEnabled = NO;
        _subtractBtn.alpha = 0.4;
        return;
    }
    _numClassNumber--;
    if (_numClassNumber > _initialNum) {
        _contentLabel.text = [NSString stringWithFormat:@"增加%@节课",TransformToChineseNum((_numClassNumber - _initialNum))];
    } else {
        _contentLabel.text = [NSString stringWithFormat:@"减少%@节课",TransformToChineseNum((_initialNum - _numClassNumber))];
    }
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];

    if (_numClassNumber == _initialNum) {
        _contentLabel.text =  [NSString stringWithFormat:@"课程数不变"];;
    }
    
    if (_numClassNumber <= 0) {
        _contentLabel.text =  [NSString stringWithFormat:@"取消该课程"];;
        _subtractBtn.userInteractionEnabled = NO;
        _subtractBtn.alpha = 0.4;
    }
    _addBtn.userInteractionEnabled = YES;
    _addBtn.alpha = 1.0;
}

- (void)addBtnPressed:(id)sender {
    if (_numClassNumber >= _maxClassNum) {
        _addBtn.userInteractionEnabled = NO;
        _addBtn.alpha = 0.4;
        return;
    }
    _numClassNumber++;
    if (_numClassNumber > _initialNum) { // 增加
        _contentLabel.text = [NSString stringWithFormat:@"增加%@节课",TransformToChineseNum((_numClassNumber - _initialNum))];
    } else {
        _contentLabel.text = [NSString stringWithFormat:@"减少%@节课",TransformToChineseNum((_initialNum - _numClassNumber))];
    }
    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    
    if (_numClassNumber == _initialNum) {
        _contentLabel.text =  [NSString stringWithFormat:@"课程数不变"];;
    }
    if (_numClassNumber >= _maxClassNum) {
        _addBtn.userInteractionEnabled = NO;
        _addBtn.alpha = 0.4;
    }
    
    _subtractBtn.userInteractionEnabled = YES;
    _subtractBtn.alpha = 1.0;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
  动画效果, 淡出淡入
#pragma mark -- Animation
// 显示动画
- (void)show{
    _backgroundView.alpha = 0;
    self.alpha = 0;
    self.transform = CGAffineTransformMakeTranslation(0, 5);
    [UIView animateWithDuration:0.15 animations:^{
        _backgroundView.alpha = 0.4;
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
// 隐藏动画
- (void)hide{
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeTranslation(0, 5);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        [self removeFromSuperview];
    }];
}

*/
@end
