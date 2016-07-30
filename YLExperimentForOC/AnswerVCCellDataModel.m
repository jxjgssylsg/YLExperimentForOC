//
//  AnswerVCCellDataModel.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AnswerVCCellDataModel.h"
#import "AnswerVCCellDataModelFrame.h"

@implementation AnswerVCCellDataModel

+ (instancetype)AnswerVCCellDataModelWithDict:(NSDictionary *)dict {
    AnswerVCCellDataModel *cellData = [[AnswerVCCellDataModel alloc] init];
    [cellData setValuesForKeysWithDictionary:dict];
    __weak AnswerVCCellDataModel *weakSelf = cellData;
    cellData.modelFrame = [AnswerVCCellDataModelFrame  AnswerVCCellDataModelFrameWithModel:weakSelf];
    return cellData;
}

// 注:对象中包含的 >= dic 中包含的键值,是可以正常初始化的,否则需调用以下方法,要不然会崩溃的
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"hehe~");
}

@end
