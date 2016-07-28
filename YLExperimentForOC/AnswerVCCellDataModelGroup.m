//
//  AnswerVCCellDataModelGroup.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/28.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "AnswerVCCellDataModelGroup.h"
#import "AnswerVCCellDataModel.h"

@implementation AnswerVCCellDataModelGroup

+ (NSMutableArray *)AnswerVCCellDataModelGroupWithNameOfContent:(NSString *)name {
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dic in arr) {
        AnswerVCCellDataModel *mo = [AnswerVCCellDataModel AnswerVCCellDataModelWithDict:dic];
        [dataArr addObject:mo];
    }
    
    return dataArr;
}

@end
