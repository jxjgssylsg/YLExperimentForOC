//
//  BFEAnswerInfoInterface.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/8/1.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEAnswerInfoInterface : UIView

@property (copy, nonatomic) NSString *imagePath;
@property (copy, nonatomic) NSString *content;              // content
@property (weak, nonatomic) UIImageView *headerImageView;   // Avatar imageView
@property (weak, nonatomic) UILabel *contentLabel;

- (instancetype)initWithFrame:(CGRect)frame;

@end
