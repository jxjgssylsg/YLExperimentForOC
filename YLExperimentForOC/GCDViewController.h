//
//  ViewController.h
//  gcdTest
//
//  Created by rongfzh on 12-8-7.
//  Copyright (c) 2012年 rongfzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end


/*
http://www.cnblogs.com/wendingding/p/3806821.html#undefined
 
 （1）使用dispatch_queue_create函数创建串行队列
 
 dispatch_queue_t  dispatch_queue_create(const char *label,  dispatch_queue_attr_t attr); // 队列名称， 队列属性，一般用NULL即可
 
 示例：
 
 dispatch_queue_t queue = dispatch_queue_create("wendingding", NULL); // 创建
 
 dispatch_release(queue); // 非ARC需要释放手动创建的队列
 
 （2）使用主队列（跟主线程相关联的队列）
 
 主队列是GCD自带的一种特殊的串行队列,放在主队列中的任务，都会放到主线程中执行
 
 使用dispatch_get_main_queue()获得主队列
 
 示例：
 
 dispatch_queue_t queue = dispatch_get_main_queue();
 
 dispatch_queue_t dispatch_get_global_queue(dispatch_queue_priority_t priority,unsigned long flags);
 
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 获得全局并发队列
 
       全局并发队列 手动创建串行队列  主队列
 同步:  没有,串行    没有,串行      没有,串行
 异步:  有,并发      有,串行       没有,串行
 
 
 （6）小结
 
 说明：同步函数不具备开启线程的能力，无论是什么队列都不会开启线程；异步函数具备开启线程的能力，开启几条线程由队列决定（串行队列只会开启一条新的线程，并发队列会开启多条线程）。
 
 同步函数
 
 （1）并发队列：不会开线程
 
 （2）串行队列：不会开线程
 
 异步函数
 
 （1）并发队列：能开启N条线程
 
 （2）串行队列：开启1条线程
 
 补充：
 
 凡是函数中，各种函数名中带有create\copy\new\retain等字眼，都需要在不需要使用这个数据的时候进行release。
 GCD的数据类型在ARC的环境下不需要再做release。
 CF（core Foundation）的数据类型在ARC环境下还是需要做release。
 异步函数具备开线程的能力，但不一定会开线程
 
 注: 主队列一定不会开启新线程的!
 
 http://www.cnblogs.com/wendingding/p/3807265.html 文顶顶
 一、主队列介绍
 
 主队列：是和主线程相关联的队列，主队列是GCD自带的一种特殊的串行队列，放在主队列中得任务，都会放到主线程中执行。
 提示：如果把任务放到主队列中进行处理，那么不论处理函数是异步的还是同步的都不会开启新的线程。
 获取主队列的方式：
 dispatch_queue_t queue=dispatch_get_main_queue();
 注. 主队列使用同步函数 dispatch_sync，在主线程中会发生死循环！任务无法往下执行。


// 从子线程回到主线程:
 
     dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     // 执⾏耗时的异步操作...
     dispatch_async(dispatch_get_main_queue(), ^{
     
     // 回到主线程,执⾏UI刷新操作
     });
     });
 
 https://zonble.gitbooks.io/kkbox-ios-dev/content/threading/gcd.html
 如果我們想要讓好幾件工作都在背景執行，而每件工作並非平行執行，而是一件工作做完之後，再繼續下一件，我們便可以使用 serial 的 queue。像這樣
     dispatch_queue_t serialQueue = \
     dispatch_queue_create("com.kkbox.queue", DISPATCH_QUEUE_SERIAL);
     
     dispatch_async(serialQueue, ^{
     [someObject doSomethingHere];
     });
     
     dispatch_async(serialQueue, ^{
     [someObject doSomethingHereAsWell];
     });
 
 https://cnbin.github.io/blog/2015/05/26/ios-gcdshi-yong-ji-qiao/
 dispatch queue 分成以下三种：
 
 运行在主线程的Main queue，通过dispatch_get_main_queue获取。
 
 并行队列global dispatch queue，通过dispatch_get_global_queue获取，由系统创建三个不同优先级的dispatch queue。并行队列的执行顺序与其加入队列的顺序相同。
 
 串行队列serial queues一般用于按顺序同步访问，可创建任意数量的串行队列，各个串行队列之间是并发的。 当想要任务按照某一个特定的顺序执行时，串行队列是很有用的。串行队列在同一个时间只执行一个任务。我们可以使用串行队列代替锁去保护共享的数据。和锁不同，一个串行队列可以保证任务在一个可预知的顺序下执行。serial queues通过dispatch_queue_create创建，可以使用函数dispatch_retain和dispatch_release去增加或者减少引用计数。
 
 //  后台执行：
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
 // something
 });
 
 // 主线程执行：
 dispatch_async(dispatch_get_main_queue(), ^{
 // something
 });
 
 // 一次性执行：
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 // code to be executed once
 });
 
 // 延迟2秒执行：
 double delayInSeconds = 2.0;
 dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
 dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
 // code to be executed on the main queue after delay
 });
 
 // 自定义dispatch_queue_t
 dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", DISPATCH_QUEUE_SERIAL);
 dispatch_async(urls_queue, ^{
 　 　// your code
 });
 dispatch_release(urls_queue);
 
 // 合并汇总结果
 dispatch_group_t group = dispatch_group_create();
 dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
 // 并行执行的线程一
 });
 dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
 // 并行执行的线程二
 });
 dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
 // 汇总结果
 });
 
 串行队列
 dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", DISPATCH_QUEUE_SERIAL);
 //并行队列
 dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", DISPATCH_QUEUE_CONCURRENT);
 
 注. dispatch_after是延迟提交，不是延迟运行
 */