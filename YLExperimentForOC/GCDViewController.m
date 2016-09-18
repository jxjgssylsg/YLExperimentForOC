//
//  ViewController.m
//  gcdTest
//
//  Created by rongfzh on 12-8-7.
//  Copyright (c) 2012年 rongfzh. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }
    });
    
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_group_t group = dispatch_group_create();
    //    dispatch_group_async(group, queue, ^{
    //        [NSThread sleepForTimeInterval:1];
    //        NSLog(@"group1");
    //    });
    //    dispatch_group_async(group, queue, ^{
    //        [NSThread sleepForTimeInterval:2];
    //        NSLog(@"group2");
    //    });
    //    dispatch_group_async(group, queue, ^{
    //        [NSThread sleepForTimeInterval:3];
    //        NSLog(@"group3");
    //    });
    //    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    //        NSLog(@"updateUi");
    //    });
    //    dispatch_release(group);
    
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_async2");
    });
    // dispatch_barrier_async 是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
    dispatch_barrier_async(queue, ^{  // 这里运行时,说明 asyn1, asyn2 都已完成,那么线程也已经结束了,可以重新分配了
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
        
    });
    dispatch_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3");
    });
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
