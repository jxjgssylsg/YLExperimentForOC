//
//  AnswerVCCellDataModelFrame.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AnswerVCCellDataModelFrame.h"

#define CELLHEIGHT 100

@class AnswerVCCellDataModelFrame;

@implementation AnswerVCCellDataModelFrame

+ (instancetype)AnswerVCCellDataModelFrameWithModel:(AnswerVCCellDataModel *)model {
    return [[AnswerVCCellDataModelFrame alloc] initWithModel:model];
}

+ (NSMutableArray *)AnswerVCCellDataModelFrameWithArray:(NSMutableArray *)arr {
    NSMutableArray *modelFrames = [NSMutableArray array];
    for (AnswerVCCellDataModel *model in arr) {
        AnswerVCCellDataModelFrame *modelframe = [AnswerVCCellDataModelFrame AnswerVCCellDataModelFrameWithModel:model];
        [modelFrames addObject:modelframe];
    }
    return modelFrames;
}

- (instancetype)initWithModel:(AnswerVCCellDataModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}


- (CGFloat)cellHeight {
    if (_cellHeight == 0) { // only calculate once
        // new label
        CGFloat readLabelFrameX = 26;
        CGFloat readLabelFrameY = 15;
        CGFloat readLabelFrameW = 31;
        CGFloat readLabelFrameH = 14;
        self.readLabelFrame = CGRectMake(readLabelFrameX, readLabelFrameY, readLabelFrameW, readLabelFrameH);
        
        // avatarFrame 头像
        CGFloat avatarFrameX = 32;
        CGFloat avatarFrameY = 18;
        CGFloat avatarFrameW = 64;
        CGFloat avatarFrameH = 64;
        self.avatarFrame = CGRectMake(avatarFrameX, avatarFrameY, avatarFrameW, avatarFrameH);
        
        // contentFrame 课程内容
        CGFloat contentFrameX = 116;
        CGFloat contentFrameY = 29;
        CGFloat contentFrameW = 178;
        CGFloat contentFrameH = 40;
        self.contentFrame = CGRectMake(contentFrameX, contentFrameY, contentFrameW, contentFrameH);
 
        
        // gapLineFrame
        CGFloat gapLineFrameX = 304;
        CGFloat gapLineFrameY = 55;
        CGFloat gapLineFrameW = 3;
        CGFloat gapLineFrameH = 11;
        self.gapLineFrame = CGRectMake(gapLineFrameX, gapLineFrameY, gapLineFrameW, gapLineFrameH);
        
        // timeFrame 时间
        CGFloat timeFrameX = 311;
        CGFloat timeFrameY = 53;
        CGFloat timeFrameW = 35;
        CGFloat timeFrameH = 14;
        self.timeFrame = CGRectMake(timeFrameX, timeFrameY, timeFrameW, timeFrameH);

        _cellHeight = CELLHEIGHT;
    }
    return _cellHeight;
}
@end
