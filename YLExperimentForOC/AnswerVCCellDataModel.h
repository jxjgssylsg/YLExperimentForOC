//
//  AnswerVCCellDataModel.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnswerVCCellDataModelFrame;

@interface AnswerVCCellDataModel : NSObject

@property (assign, nonatomic) BOOL isRead;                              // read ?
@property (assign, nonatomic) BOOL isEvaluate;                          //
@property (copy, nonatomic) NSString *avatarPicture;                    //
@property (copy, nonatomic) NSString *content;                          //
@property (copy, nonatomic) NSString *sendTime;                         // time
@property (strong, nonatomic) AnswerVCCellDataModelFrame *modelFrame;   // the frame of the model

+ (instancetype)AnswerVCCellDataModelWithDict:(NSDictionary *)dict;

@end
