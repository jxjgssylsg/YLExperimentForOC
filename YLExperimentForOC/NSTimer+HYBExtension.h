//
//  NSTimer+HYBExtension.h
//  HYBTimerExtension
//
//  Created by huangyibiao on 15/4/16.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSTimer (HYBExtension)

/**
 *  无参数无返回值Block
 */
typedef void (^HYBVoidBlock)(void);

/**
 *  创建Timer---Block版本
 *
 *  @param interval 每隔interval秒就回调一次callback
 *  @param repeats  是否重复
 *  @param callback 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                   callback:(HYBVoidBlock)callback;

/**
 *  创建Timer---Block版本
 *
 *  @param interval 每隔interval秒就回调一次callback
 *  @param count  回调多少次后自动暂停，如果count <= 0，则表示无限次，否则表示具体的次数
 *  @param callback 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(HYBVoidBlock)callback;

/**
 *  开始启动定时器
 */
- (void)fireTimer;

/**
 *  暂停定时器
 */
- (void)unfireTimer;

/**
 *  Make it invalid if currently it is valid.
 */
- (void)invalid;

@end
