//
//  popAnimation.m
//  UIScreenEdgePanGestureRecognizer
//
//  Created by Jazys on 15/3/25.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "PopAnimation.h"

@interface PopAnimation ()
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 这个方法返回动画执行的时间
    return 0.25;
}

/**
 *  transitionContext 你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  获取动画来自的那个控制器  From where
     */
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /**
     *  获取转场到的那个控制器   To where
     */
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个 containerView 来作为一个“舞台”，让动画执行。
     */
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext]; 

    /**
     *  执行动画，我们让fromVC的视图移动到屏幕最右侧
     */
    [UIView animateWithDuration:duration animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0); // 平移向量
    }completion:^(BOOL finished) {
        /**
         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
         */
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    // _transitionContext = transitionContext;
    //----------------pop动画一-------------------------//
    /*
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:containerView cache:YES];
    // stop then exe the method
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    [UIView commitAnimations];//提交UIView动画
    [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    */
    //----------------pop动画二-------------------------//
    /*
    CATransition *tr = [CATransition animation];
    tr.type = @"cube";
    tr.subtype = @"fromLeft";
    tr.duration = duration;
    tr.removedOnCompletion = NO;
    tr.fillMode = kCAFillModeForwards;
    tr.delegate = self;
    [containerView.layer addAnimation:tr forKey:nil];
    [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    */
}

- (void)animationDidStop:(CATransition *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}
@end
