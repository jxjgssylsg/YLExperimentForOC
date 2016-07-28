//
//  AnswerVCCellDataModelFrame.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnswerVCCellDataModel.h"

@interface AnswerVCCellDataModelFrame : NSObject

@property (assign, nonatomic) CGRect readLabelFrame;        // if unread, new label Frame
@property (assign, nonatomic) CGRect avatarFrame;           // Avatar Frame
@property (assign, nonatomic) CGRect contentFrame;          // content frame
@property (assign, nonatomic) CGRect gapLineFrame;          // line frame
@property (assign, nonatomic) CGRect timeFrame;             // time frame
@property (strong, nonatomic) AnswerVCCellDataModel *model; // 
@property (assign, nonatomic) CGFloat cellHeight;           // height of cell

@end
