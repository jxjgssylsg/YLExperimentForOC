//
//  CacheTool.h
//  YLExperimentForOC
//
//  Created by syl on 16/4/26.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKCacheTool : NSObject

/** 单例模式 */
+ (id)sharedManager;

/** 删除缓存 */
- (NSString *)deleteCach;

/** 得到缓存大小 */
- (NSString *)getCachSize;

@end
