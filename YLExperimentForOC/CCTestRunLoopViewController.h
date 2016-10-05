//
//  CCViewController.h
//  RunLoopDemo
//
//  Created by Chun Ye on 10/20/14.
//  Copyright (c) 2014 Chun Tips. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    测试如何使用Run Loop阻塞线程，等待其他线程执行后再执行操作。
 */
@interface CCTestRunLoopViewController : UIViewController


@end

/*
 ttp://chun.tips/blog/2014/10/20/zou-jin-run-loopde-shi-jie-%5B%3F%5D-:shi-yao-shi-run-loop%3F/
 
 UIApplicationMain()方法在这里不仅完成了初始化我们的程序并设置程序Delegate的任务，而且随之开启了主线程的Run Loop, 开始接受处理事件。
 
 从图中可以看出，Run Loop是线程中的一个循环，并对接收到的事件进行处理。我们的代码可以通过提供while或者for循环来驱动Run Loop。在循环中，Run Loop对象来负责事件处理代码（接收事件并且调用事件处理方法）。
 
 Run Loop从两个不同的事件源中接收消息:
 1. Input source用来投递异步消息，通常消息来自另外的"线程"或者程序。在接收到消息并调用程序指定方法时，线程中对应的NSRunLoop对象会通过执行runUntilDate:方法来退出。
 2. Timer source 用来投递 timer 事件（Schedule 或者 Repeat）中的同步消息。在处理消息时，并"不会"退出Run Loop。
 3. Run Loop还有一个观察者Observer的概念，可以往Run Loop中加入自己的观察者以便监控Run Loop的运行过程。
 
 # Run Loop modes #
 
 Run Loop mode 可以理解为一个集合中包括所有要监视的事件源和要通知的 Run Loop 中注册的观察者。每一次运行自己的 Run Loop 时，都需要显示或者隐示的指定其运行于哪一种 Mode。在设置 Run Loop mode 后，你的 Run Loop会自动过滤和其他 mode 相关的事件源，而只监视和当前设置 mode 相关的源(通知相关的观察者)。大多数时候，Run Loop都是运行在系统定义的默认模式上。
 
 注. Run Loop Mode 区分基于事件的源，而不是事件的种类。比如你不能通过 Run Loop mode 去只选择鼠标点击事件或者键盘输入事件。你可以使用Run Loop Mode去监听端口，暂停计时器或者改变其他源。
 
 注. 我们可以给Mode指定任意名称，但是它对应的集合内容不能是任意的。我们需要添加Input source, Timer source 或者 Observer到自己自定义的Mode。
 
 下面列出 iOS 下一些已经定义的Run Loop Modes:
 1) NSDefaultRunLoopMode: 大多数工作中默认的运行方式。
 2) NSConnectionReplyMode: 使用这个 mode 去监听 NSConnection 对象的状态，我们"很少"需要自己使用这个 Mode。
 3) NSModalPanelRunLoopMode: 使用这个 mode 在 Model Panel 情况下去区分事件(OS x 开发中会遇到)。
 4) UITrackingRunLoopMode: 使用这个 mode 去跟踪来自用户交互的事件（比如 UITableView 上下滑动）。
 5) GSEventReceiveRunLoopMode: 用来接受系统事件，内部的 Run Loop Mode。
 6) NSRunLoopCommonModes: 这是一个伪模式，其为一组 run loop mode 的集合。如果将 Input source 加入此模式，意味着关联 Input source 到 Common modes 中包含的所有模式下。在 iOS 系统中 NSRunLoopCommonMode 包含NSDefaultRunLoopMode、NSTaskDeathCheckMode、UITrackingRunLoopMode.可使用 CFRunLoopAddCommonMode 方法向 Common modes 中添加自定义 mode。
 
 注. Run Loop 运行时只能以一种固定的 mode 运行，只会监控这个 mode 下添加的 Timer source 和 Input source 。如果这个 mode 下没有添加事件源，Run Loop 会立刻返回。
 
 # 事件源 #
 
 Input source 有两个不同的种类: Port-Based Sources 和 Custom Input Sources. Run Loop 本身并不关心 Input source 是哪一种类型。系统会实现两种不同的 Input source 供我们使用。这两种不同类型的 Input source 的区别在于：Port-Based Sources 由"内核"自动发送，Custom Input Sources 需要从 "其他线程" 手动发送。
 
 1. Custom Input Sources:
 我们可以使用 Core Foundation 里面的 CFRunLoopSourceRef 类型相关的函数来创建 Custom input source。
 
 2. Port-Based Sources:
 通过内置的端口相关的对象和函数，配置基于端口的 Input source。 (比如在主线程创建子线程时传入一个 NSPort 对象,主线程和子线程就可以进行通讯。NSPort对象会负责自己创建和配置Input source。)
 
 3. Cocoa Perform Selector Sources
 Cocoa 框架为我们定义了一些 Custom Input Sources，允许我们在线程中执行一系列 selector 方法。
 //在主线程的Run Loop下执行指定的 @selector 方法
 performSelectorOnMainThread:withObject:waitUntilDone:
 performSelectorOnMainThread:withObject:waitUntilDone:modes:
 
 //在当前线程的Run Loop下执行指定的 @selector 方法
 performSelector:onThread:withObject:waitUntilDone:
 performSelector:onThread:withObject:waitUntilDone:modes:
 
 //在当前线程的Run Loop下延迟加载指定的 @selector 方法
 performSelector:withObject:afterDelay:
 performSelector:withObject:afterDelay:inModes:
 
 //取消当前线程的调用
 cancelPreviousPerformRequestsWithTarget:
 cancelPreviousPerformRequestsWithTarget:selector:object:
 
 注：
 和Port-Based Sources一样的是：这些 selector 的请求会在目标线程中序列化，以减缓线程中多个方法执行带来的同步问题。
 和Port-Based Sources不一样的是： 一个selector方法执行完之后会自动从当前Run Loop中移除。
 
 注. 走进Run Loop世界系列的第二章会专门讨论如何自定义事件源。
 
 4. Timer Sources
 Timer source 在预设的时间点同步的传递消息。Timer是线程通知自己做某件事的一种方式。
 Foundation 中 NSTimer Class 提供了相关方法来设置 Timer source. 需要注意的是除了 scheduledTimerWithTimeInterval 开头的方法创建的 timer 都需要手动添加到当前 Run Loop 中。（scheduledTimerWithTimeInterval 创建的 timer 会自动以 Default mode 加载到当前 Run Loop 中。）
 
 注. Timer在选择使用一次后，在执行完成时，会从 Run Loop 中移除。选择循环时，会一直保存在当前 Run Loop 中，直到调用 invalidate 方法。
 
 5. Run Loop Observers
 事件源是同步或者异步的事件驱动时触发，而 Run Loop observer 则在 Run Loop 本身进入某个状态时得到通知:
 {
	Run Loop 进入的时候
	Run Loop 处理一个 timer 的时候
	Run Loop 处理一个 Input source 的时候
	Run Loop 进入睡眠的时候
	Run Loop 被唤醒的时候，在唤醒它的事件被处理之前
	Run Loop 停止的时候
 }
 
 注. observer 需要使用 Core Foundataion 框架。和 timer 一样，Run Loop Observers 也可以使用一次或者选择 repeat。如果只使用一次，Observer会在它被执行后自己从Run Loop中移除。而循环的Observer会一直保存在Run Loop中。
 
 # Run Loop 事件队列 #
 Run Loop 本质是一个处理事件源的循环。我们对 Run Loop 的运行时具有控制权，如果当前没有时间发生，Run Loop会让当前线程进入"睡眠模式"，来减轻 CPU 压力。如果有事件发生，Run Loop 就处理事件并通知相关的 Observer。具体的顺序如下:
	1) Run Loop 进入的时候，会通知 Observer
	2) timer 即将被触发时，会通知 Observer
	3) 有其它非 Port-Based Input source 即将被触发时，会通知 Observer
	4) 启动非 Port-Based Input source 的事件源
	5) 如果基于 Port 的 Input source 事件源即将触发时，立即处理该事件，并跳转到 9
	6) 通知 observer 当前线程进入睡眠状态
	7) 将线程置入睡眠状态直到有以下事件发生：1. Port-Based Input source 被触发。2. Timer被触发。 3. Run Loop  设置的时间已经超时。 4. Run Loop 被显示唤醒。
	8) 通知 observer 线程将要被唤醒
	9) 处理被触发的事件：1. 如果是用户自定义的 Timer，处理 Timer 事件后重启 Run Loop 并直接进入步骤 2。 2.如果线程被显示唤醒又没有超时，那么进入步骤2。 3.如果是其他Input source 事件源有事件发生，直接传递这个消息。
	10) 通知 Observer Run Loop 结束，Run Loop 退出。
 
 # 何时使用 Run Loop #
 下面是官方 document 提供的使用 Run Loop 的几个场景:
	1. 需要使用 Port-Based Input source 或者 Custom Input source 和 "其他线程"通讯时
	2. 需要在线程中使用 Timer
	3. 需要在线程中使用上文中提到的 selector 相关方法
	4. 需要让线程执行周期性的工作
 
 注. 使用Foundation中的NSRunLoop类来修改自己的Run Loop，我们必须在Run Loop的所在线程中完成这些操作。在其他线程中给Run Loop添加事件源或者Timer会导致程序崩溃。
 
 # Show time #
 1.使用 NSRunLoop 的 currentRunLoop 可以获得当前线程的 Run Loop 对象。
 NSRunLoop *currentThreadRunLoop = [NSRunLoop currentRunLoop];
 // 或者
 CFRunLoopRef currentThreadRunLoop = CFRunLoopGetCurrent();
 
 2. 在配置Run Loop之前，我们必须添加一个事件源或者 Timer source 给它。如果 Run Loop 没有任何源需要监视的话，会立刻退出。同样的我们可以给 Run Loop 注册 Observer。
 
 我们一般可以通过这几张方式"启动"Run Loop：
 1. 无条件的 : 不推荐使用，这种方式启动Run Loop会让一个线程处于永久的循环中。退出Run Loop的唯一方式就是显
 示的去杀死它。 - (void)run;
 2. 设置超时时间 - (void)runUntilDate:(NSDate *)limitDate;
 3. 特定的Mode - (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;
 
 
 退出Run Loop一般如下：
 1. 设置超时时间："推荐使用"
 2. 通知 Run Loop 停止：使用 CFRunLoopStop 来显式的停止 Run loop。无条件启动的 Run Loop 中调用这个方法退出 Run Loop。
 
 注. 尽管移除 Run Loop 的 Input source 和 timer 也可能导致 Run loop 退出，但这并不是可靠的退出 Run loop 的方法。一些状态下系统会添加 Input source 到 Run loop 里面来处理所需事件。由于我们的代码未必会考虑到这些 Input source，这样可能导致无法移除这些事件源，从而导致 Run loop 不能正常退出。
 
 注. 为当前长时间运行的线程配置 Run Loop 的时候，最好添加至少一个 Input source 到 Run Loop 以接收消息。虽然我们可以使用 timer 来进入 Run Loop，但是一旦 timer 触发后，它通常就变为无效了，这会导致 Run Loop 退出。虽然附加一个循环的 timer 可以让 Run Loop 运行一个相对较长的周期，但是这也会导致周期性的唤醒线程，这实际上是轮询（polling）的另一种形式而已。与之相反，Input source 会一直等待某事件发生，"在事件发生前它会让线程处于休眠状态"。
 
 # 如何正确使用Run Loop阻塞线程 #
 见原文
 
 # Run Loop开发中遇到的问题 #
 1) NSTimer, NSURLConnection 和 NSStream 默认运行在 Default mode 下，UIScrollView 在接收到用户交互事件时，主线程 Run Loop 会设置为 UITrackingRunLoopMode 下，这个时候 NSTimer 不能 fire，NSURLConnection 的数据也无法处理。
 
 上述代码，在正常情况下 label 可以刷新 text，但是在用户拖动 tableView 时，label 将不在更新，直到手指离开屏幕。 解决方法，一种是修改 timer 运行的 Run Loop 模式，将其加入 NSRunLoopCommonModes 中。
 // self.testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self         selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
 
 self.testTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
 [[NSRunLoop currentRunLoop] addTimer:self.testTimer forMode:NSRunLoopCommonModes];
 
 另外一种解决方法是在另外一个线程中处理Timer事件，在perform到主线程去更新Label。
 
 NSURLConnection和NSTimer也大致如此，其中注意NSURLConnection要使用- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately生成NSURLConnection对象，并且第三个参数要设置为NO。之后再用- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode设置Run Loop与其模式。
 关于NSURLConnection的最佳实践可以参考AFNetworking。
 
 2) NSTimer 的构造方法会对传入的 target 对象强引用，直到这个 timer 对象 invalidated。在使用时需要注意内存问题，根据需要，要在适当的地方调用 invalidated 方法。
 
 3) 运行一次的 timer 源也可能导致 Run Loop 退出：一次的 timer 在执行完之后会自己从 Run Loop 中删除，如果使用while 来驱动 Run Loop 的话，下一次再运行 Run Loop 就可能导致退出，因为此时已经没有其他的源需要监控。
 
 http://www.cnblogs.com/chenxianming/p/5527498.html
 总结：
 
 1、[runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]其实是为线程创建
 
 一个循环，如果线程已经有，创建的是一个子循环。
 
 2、通过[runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]创建的循环过一段时间或
 
 马上返回，这取决于输入源及系统的调度。所以用while进行不断驱动，不停创建循环。
 
 3、我们看到日志打印出kCFRunLoopExit是子循环的exit.
 
 https://hit-alibaba.github.io/interview/iOS/ObjC-Basic/Runloop.html
 
 # Runloop 与线程 #
 
 Runloop 和线程是绑定在一起的。每个线程（包括主线程）都有一个对应的 Runloop 对象。我们并不能自己创建 Runloop 对象，但是可以获取到系统提供的 Runloop 对象。
 
 主线程的 Runloop 会在应用启动的时候完成启动，其他线程的 Runloop 默认并不会启动，需要我们手动启动。
 
 # Input Source 和 Timer source #
 
 这两个都是 Runloop 事件的来源，其中 Input Source 又可以分为三类
 
 Port-Based Sources，系统底层的 Port 事件，例如 CFSocketRef ，在应用层基本用不到
 Custom Input Sources，用户手动创建的 Source
 Cocoa Perform Selector Sources， Cocoa 提供的 performSelector 系列方法，也是一种事件源
 Timer Source 顾名思义就是指定时器事件了。
 
 # Runloop observer #
 Runloop 通过监控 Source 来决定有没有任务要做，除此之外，我们还可以用 Runloop Observer 来监控 Runloop 本身的状态。 Runloop Observer 可以监控下面的 runloop 事件：
	The entrance to the run loop.
	When the run loop is about to process a timer.
	When the run loop is about to process an input source.
	When the run loop is about to go to sleep.
	When the run loop has woken up, but before it has processed the event that woke it up.
	The exit from the run loop.
 
 
 */
