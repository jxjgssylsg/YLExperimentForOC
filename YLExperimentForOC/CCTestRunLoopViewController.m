//
//  CCViewController.m
//  RunLoopDemo
//
//  Created by Chun Ye on 10/20/14.
//  Copyright (c) 2014 Chun Tips. All rights reserved.
//

#import "CCTestRunLoopViewController.h"
#import "AppDelegate.h"
#import "RuntimeViewController.h"
#import <objc/runtime.h>


@interface CCTestRunLoopViewController ()

@property (nonatomic) BOOL normalThreadDidFinishFlag;
@property (nonatomic) BOOL runLoopThreadDidFinishFlag;

@end

@implementation CCTestRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSObject *a = [[NSObject alloc] init];
    // id ab = a;
    // objc_getClass("ssss");
    // objc_getClass("ssss");
    Class c1 = objc_getClass("Person");
    // object_getClass(a);
    [[UIButton appearance] setBackgroundColor:[UIColor blueColor]];
    
    /* 点击之后 产生一个普通的 Thread 执行任务,线程完成之后再继续运行。 在这个过程中会阻塞 UI 线程。点击下面的Normal按钮没有输出。 */
    UIButton *normalThreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    normalThreadButton.frame = CGRectMake(10, 30, 200, 50);
    normalThreadButton.backgroundColor = [UIColor redColor];
    
    [normalThreadButton setTitle:@"Normal Thread" forState:UIControlStateNormal];
    [normalThreadButton addTarget:self action:@selector(handleNormalThreadButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalThreadButton];
    
    /* 点击之后 启动一个线程，使用Run Loop，等待线程完成后再继续执行任务。 在这个过程中 不会阻塞UI线程。点击下面的 Normal 按钮会正常输出。 */
    UIButton *runLoopThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    runLoopThreadButton.backgroundColor = [UIColor redColor];
    [runLoopThreadButton setTitle:@"Run Loop Thread" forState:UIControlStateNormal];
    [runLoopThreadButton addTarget:self action:@selector(handleRunLoopThreadButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:runLoopThreadButton];
    self.view.backgroundColor = [UIColor grayColor];
    
    /* 测试 Button 看 UI 是否能正常响应 */
    UIButton *normalButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 170, 200, 50)];
    normalThreadButton.backgroundColor = [UIColor redColor];
    [normalButton setTitle:@"Normal" forState:UIControlStateNormal];
    [normalButton addTarget:self action:@selector(handleNormalButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:normalButton];
    
    /* Test Run Loop Custom Source Thread Button */
    // 注. 在原 Demo 中,没弄过来
    {
        UIButton *testCustomSourceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 300, 50)];
        [testCustomSourceButton setTitle:@"Test Custom Source" forState:UIControlStateNormal];
        [testCustomSourceButton addTarget:self action:@selector(handleTestCustomSourceButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testCustomSourceButton];
    }
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Handler

- (void)handleNormalThreadButtonTouchUpInside {
    NSLog(@"Enter handleNormalThreadButtonTouchUpInside");
    // 注. 这里是主线程
    self.normalThreadDidFinishFlag = NO;

    NSLog(@"Start a New Normal Thread");
    NSThread *normalThread = [[NSThread alloc] initWithTarget:self selector:@selector(handleNormalThreadTask) object:nil];
    [normalThread start];
    
    // 等待线程完成再执行以下任务，在这种情况下会阻塞 UI 线程
    while (!self.normalThreadDidFinishFlag) {
        NSLog(@"----- ssssssssyl");
        [NSThread sleepForTimeInterval:0.1];
    }
    
    // 直到线程执行完成，才会打印 handleNormalButtonTouchUpInside 中的输出信息
    NSLog(@"Exit handleNormalThreadButtonTouchUpInside");
}

- (void)handleRunLoopThreadButtonTouchUpInside {
    NSLog(@"Enter handleRunLoopThreadButtonTouchUpInside");
    // 这里是主线程
    self.runLoopThreadDidFinishFlag = NO;
    
    NSLog(@"Start a New Run Loop Thread");
    NSThread *runLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(handleRunLoopThreadTask) object:nil];
    [runLoopThread start];
    
    // 使用 Run Loop，在线程执行期间，handleNormalButtonTouchUpInside 能够正常输入信息
    while (!self.runLoopThreadDidFinishFlag) {
        NSLog(@"Begin RunLoop");
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        // [[NSRunLoop currentRunLoop] run];  // 用这句的话，runloop 就不会退出了
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"---------- ----- End RunLoop");
    }
    
    // Run Loop 真神奇
    NSLog(@"Exit handleRunLoopThreadButtonTouchUpInside");

}

// nomal 按钮,测试是否会得到响应
- (void)handleNormalButtonTouchUpInside {
    NSLog(@"Enter handleNormalButtonTouchUpInside");
    
    NSLog(@"Exit handleNormalButtonTouchUpInside");
}


- (void)handleTestCustomSourceButtonTouchUpInside {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
   // [appDelegate testInputSourceEvent];
}

#pragma mark - Private

- (void)handleNormalThreadTask {
    NSLog(@"Enter Normal Thread");
    // 这里是新开辟的线程
    for (NSInteger i = 0; i < 5; i ++) {
        NSLog(@"In Normal Thread, count = %ld", i);
        sleep(1);
    }
    
    _normalThreadDidFinishFlag = YES;
    
    NSLog(@"Exit Normal Thread");
}

- (void)handleRunLoopThreadTask {
    // 这里是新开辟的线程
    NSLog(@"Enter Run Loop Thread");
    
    for (NSInteger i = 0; i < 5; i ++) {
        NSLog(@"In Run Loop Thread, count = %ld", i);
        sleep(1);
    }
    
#if 0
    // 错误示范
    _runLoopThreadDidFinishFlag = YES;
    // 这个时候并不能执行线程完成之后的任务，因为 Run Loop 所在的线程并不知道runLoopThreadDidFinishFlag 被重新赋值。Run Loop 这个时候没有被任务事件源唤醒。
    // 你会发现这个时候点击屏幕中的 UI，线程将会继续执行。 因为 Run Loop 被 UI 事件唤醒。
    // 正确的做法是使用 "selector" 方法唤醒 Run Loop。 即如下:
#else
    [self performSelectorOnMainThread:@selector(updateRunLoopThreadDidFinishFlag) withObject:nil waitUntilDone:NO];
#endif
    
    NSLog(@"Exit Run Loop Thread");
}

- (void)updateRunLoopThreadDidFinishFlag {
    _runLoopThreadDidFinishFlag = YES;
}

@end
