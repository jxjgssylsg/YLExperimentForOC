//
//  AdjustClassNumController.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/12.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AdjustClassNumController.h"

@interface AdjustClassNumController () {
    UIButton *_subtractBtn;
    UIButton *_addBtn;
    UIButton *_confirmBtn;
    
    UILabel *_nameLabel;
    UILabel *_numLabel; // num
    UILabel *_contentLabel;
    
    NSInteger _numClassNumber;
    NSDictionary *_contentsDic;
}

@end

@implementation AdjustClassNumController

- (instancetype)initWithFrame:(CGRect)frame contentLabelString:(NSString*)contentLabelString
{
    if (self = [super init]) {
        self.view.frame = frame; // 有意思的地方,运行到这里会先去执行 viewDidLoad 方法,因为 self.view 会调用 get 方法~
        _contentLabel.text = contentLabelString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
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
    _nameLabel.lineBreakMode =  NSLineBreakByCharWrapping;
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

    _numLabel.text  = @"3";
    [_numLabel sizeToFit];
    [self.view addSubview:_numLabel];
    _numClassNumber = 3;
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(99, 178, 0, 0);
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor colorWithRed:157 / 255.0f green:157 / 255.0 blue:157 / 255.0 alpha:1];
    _contentLabel.text = @"你好呀是是";
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
    
    _contentsDic = @{@"0":@"取消该课型", @"1":@"减少两节课", @"2":@"减少一节课", @"3":@"数目不变", @"4":@"增加一节课"};
}
- (void)confirmBtnPressed:(id)sender {
    _numClassNumber--;
    _numLabel.text = [NSString  stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    __weak AdjustClassNumController *weakself = self;
    [self.delegate confirmBtnPressed:weakself]; //
}
- (void)subtractBtnPressed:(id)sender {
    _numClassNumber--;
    _numLabel.text = [NSString  stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    
    _contentLabel.text = _contentsDic[_numLabel.text];
    [_contentLabel sizeToFit];
}

- (void)addBtnPressed:(id)sender {
    _numClassNumber++;
    _numLabel.text = [NSString  stringWithFormat:@"%ld", (long)_numClassNumber];
    [_numLabel sizeToFit];
    
    _contentLabel.text = _contentsDic[_numLabel.text];
    [_contentLabel sizeToFit];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
