//
//  AnswerVCCell.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AnswerVCCell.h"
#import "AnswerVCCellDataModel.h"
#import "AnswerVCCellDataModelFrame.h"

@interface PersistentBackgroundLabel : UILabel {

}

- (void)setPersistentBackgroundColor:(UIColor*)color;

@end

@implementation PersistentBackgroundLabel

- (void)setPersistentBackgroundColor:(UIColor*)color {
    super.backgroundColor = color;
}

- (void)setBackgroundColor:(UIColor *)color {
    // do nothing - background color never changes
}

@end

@interface AnswerVCCell ()

@property (weak, nonatomic) PersistentBackgroundLabel *readLabel;             // if unread, new label
@property (weak, nonatomic) UIImageView *avatarImageView;   // Avatar imageView
@property (weak, nonatomic) UILabel *contentLabel;          // content label
@property (weak, nonatomic) UIView *gapLineLabel;           // line label
@property (weak, nonatomic) UILabel *timeLabel;             // time label

@end

@implementation AnswerVCCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"syl_____ %s",__func__);
        
        // avatar
        UIImageView *avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:avatarImageView]; // 这里理解为强引用
        _avatarImageView = avatarImageView; // 这里是 weak
        _avatarImageView.layer.cornerRadius = 32.0;
        _avatarImageView.clipsToBounds = YES;
        avatarImageView.backgroundColor = [UIColor redColor]; // 可以从颜色看出重用机制
        
        // content
        UILabel *contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:contentLabel];
        _contentLabel = contentLabel;
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail; // 看源码
        _contentLabel.numberOfLines = 0;
        // _contentLabel.backgroundColor = [UIColor darkGrayColor];
        
        // gap line
        UIView *gapLineLabel = [[UIView alloc] init];
        [self.contentView addSubview:gapLineLabel];
        _gapLineLabel = gapLineLabel;
        // _gapLineLabel.backgroundColor = [UIColor darkGrayColor];
        
        // timeLabel
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // if unread, new label
        PersistentBackgroundLabel *readLabel = [[PersistentBackgroundLabel alloc] init];
        [self.contentView addSubview:readLabel];
        _readLabel = readLabel;
        //_readLabel.backgroundColor = [UIColor redColor];
        [_readLabel setPersistentBackgroundColor:[UIColor redColor]];
        _readLabel.textColor = [UIColor whiteColor];
        _readLabel.layer.cornerRadius = 3.0;
        _readLabel.clipsToBounds = YES;
        _readLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

// 注意调用 layoutSubviews 的各种时机,既什么情况下会调用 layoutSubviews 方法
- (void)layoutSubviews {
    [super layoutSubviews];
    _readLabel.frame = _frameModel.readLabelFrame;
    _avatarImageView.frame = _frameModel.avatarFrame;
    _contentLabel.frame = _frameModel.contentFrame;
    _gapLineLabel.frame = _frameModel.gapLineFrame;
    _timeLabel.frame = _frameModel.timeFrame;
}

- (void)setModel:(AnswerVCCellDataModel *)model {
    _model = model;
    if (_model.isRead) {
        _readLabel.hidden = YES;
    }
    _readLabel.text = @" NEW";
    _avatarImageView.image = [UIImage imageNamed:_model.avatarPicture];
    _contentLabel.text = _model.content;

//    _nameLabel.text = _model.name;
//    if (_model.vip) {
//        _vipImageView.hidden = NO;
//    } else {
//        _vipImageView.hidden = YES;
//    }
//    _text_label.text = _model.text;
//    _iconImageView.image = [UIImage imageNamed:_model.icon];
    
}

@end
