//
//  AnswerVCCell.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnswerVCCellDataModel;
@class AnswerVCCellDataModelFrame;
@class AnswerVCCellDataModelGroup;

@interface AnswerVCCell : UITableViewCell

@property (strong, nonatomic) AnswerVCCellDataModel *model; // 数据
@property (strong, nonatomic) AnswerVCCellDataModelFrame *frameModel; // 数据frame

@end
