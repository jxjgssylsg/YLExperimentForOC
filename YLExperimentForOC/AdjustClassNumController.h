//
//  AdjustClassNumController.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/12.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdjustClassNumController;

@protocol AdjustClassNumControllerDelegate <NSObject>

- (void)confirmBtnPressed:(AdjustClassNumController *)ClassNumController; // 点击了确定

@end

@interface AdjustClassNumController : UIViewController

- (instancetype)initWithMaxClassNum:(NSInteger)maxNum currentClassNum:(NSInteger)currentNum;

@property (weak, nonatomic) id<AdjustClassNumControllerDelegate> delegate;
@property (strong, nonatomic) UIView *maskView; // 遮罩层

@end
