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
    
    UILabel  *_nameLabel;
    UILabel  *_numLabel; // num
    UILabel  *_contentLabel;
    
    NSInteger _numClassNumber;
}

@end

@implementation AdjustClassNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

    
}

- (void)initUI {
    _subtractBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _subtractBtn.frame = CGRectMake(47, 124, 30, 30);
    _subtractBtn.backgroundColor = [UIColor lightGrayColor];
    [_subtractBtn setTitle:@" - " forState:UIControlStateNormal];
    [_subtractBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_subtractBtn addTarget:self action:@selector(subtractBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subtractBtn];
    // _subtractBtn.tag = ;
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addBtn.frame = CGRectMake(190, 124, 30, 30);
    _addBtn.backgroundColor = [UIColor grayColor];
    [_addBtn setTitle:@" + " forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(83, 30, 101, 52);
    _nameLabel.text  = @"Examination /n 课型数目";
    [_nameLabel sizeToFit];
    [self.view addSubview:_nameLabel];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.frame = CGRectMake(121, 106, 50, 60);
    _contentLabel.text  = @"1";
    [_contentLabel sizeToFit];
    [self.view addSubview:_contentLabel];
    _numClassNumber = 1;
}

- (void)subtractBtnPressed:(id)sender {
    _numClassNumber--;
    _contentLabel.text = [NSString  stringWithFormat:@"%ld", (long)_numClassNumber];
    [_contentLabel sizeToFit];
}

- (void)addBtnPressed:(id)sender {
    _numClassNumber++;
    _contentLabel.text = [NSString  stringWithFormat:@"%ld", (long)_numClassNumber];
    [_contentLabel sizeToFit];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
