////
////  CollectionViewCell.m
////  UICollectionViewDemo1
////
////  Created by user on 15/11/2.
////  Copyright © 2015年 BG. All rights reserved.
////
//
//#import "PersonalVideoListVCCell.h"
//#import "PersonalVideoModel.h"
//#import "NSString+Extend.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//
//@implementation PersonalVideoListVCCell
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setModel:(PersonalVideoModel *)model {
//    _model = model;
//    _titleLabel.text = _model.secondTitle;
//    _playNumLabel.text = [NSString stringForCuttingNumber:_model.playNum withAppending:@"播放"];
//    _timeOfVideoLabel.text = [NSString stringFromSeconds:_model.playTime];
//    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.coverPicUrl] placeholderImage:nil];
//    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
//    _backgroundImageView.clipsToBounds = YES;
//}
//
//
//@end
