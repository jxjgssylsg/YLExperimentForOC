//
//  Macros.h
//  Copyright (c) 2014年 syl. All rights reserved.
//

#pragma once
//
// -------------------------------- 颜色宏 --------------------------------//

#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

#define DefaultLinkColor @"#001cfe"

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define GRAYCOLOR(c) COLOR(c,c,c)
#define BACKGROUND_PINK_COLOR COLOR(255, 236, 238)
#define BACKGROUND_CLEAR_COLOR [UIColor clearColor]
#define BACKGROUND_WHITE_COLOR [UIColor whiteColor]
#define NAVIGATION_TINT_COLOR COLOR(131, 54, 53)

#define LightBlueColor COLOR(21,125,251)
#define LightBlueColor1 COLOR(15, 98, 254)

#define NewBlueColor COLOR(23, 126, 250)
#define NewPurpleColor COLOR(204, 115, 225)
#define NewGrayColor GRAYCOLOR(250)
#define NewYellowColor COLOR(240, 184, 0)
#define AchievementYellowColor COLOR(255, 216, 87)
#define NewBlackColor GRAYCOLOR(50)
#define NewWhiteColor GRAYCOLOR(255)
#define NewYellowBorderColor COLOR(240, 216, 87)

#define RightAnswerItemColor COLOR(102, 177, 50)
#define WrongAnswerItemColor COLOR(255, 39, 18)


// 定义构造单例的宏
#define SharedInstanceInterfaceBuilder(ClassName) \
+ (ClassName*)sharedInstance;

#define SharedInstanceBuilder(ClassName) \
+ (ClassName*)sharedInstance\
{\
static dispatch_once_t onceToken;\
static ClassName* instance;\
dispatch_once(&onceToken, ^{\
instance = [[ClassName alloc] init];\
});\
return instance;\
}

// 教师版横屏设定的宏
#define SetTeacherScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    return UIInterfaceOrientationMaskLandscape;\
}\

// 手机版混合设定的宏
#define SetPhoneMixScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    if ([BFEDeviceTools isPhone] || [BFECommonTools isStudentVersion]) {\
        return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);\
    } else {\
        return UIInterfaceOrientationMaskLandscape;\
    }\
}\

#define SetStudentScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);\
}\

#define SetCommonVersionScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    if ([BFECommonTools isTeacherVersion]) {\
        return UIInterfaceOrientationMaskLandscape;\
    } else {\
        return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);\
    }\
}\


#define SetBlackBackGroundWhiteForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];\
[self.navigationController.navigationBar setBarTintColor:NewBlackColor];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetWhiteBackGroundBlackForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];\
[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetBlackBackGroundWhiteForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
    [super viewWillAppear:animated];\
    SetBlackBackGroundWhiteForgroundStyle\
}

#define SetWhiteBackGroundBlackForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
    [super viewWillAppear:animated];\
    SetWhiteBackGroundBlackForgroundStyle\
}\

#define StrokeView(view) StrokeViewWithColorAndWidth(view, [UIColor redColor], 1)

#define StrokeViewWithColorAndWidth(view, color, width) \
if(DebugMode) {\
view.layer.borderColor = color.CGColor;\
view.layer.borderWidth = width;\
}

// 提示返回未知数据
#define LogUnexpectedDatatReturned NSLog(@"返回数据格式与预期不一致。");

#define PromptUnexpectedDataReturned(containerView) [AutoRemoveMessageView show:@"返回数据格式与预期不一致。" withContainerView:containerView completion:nil];

#define PromptRequestFailed(containerView) [AutoRemoveMessageView show:@"请求失败。" withContainerView:containerView completion:nil];

#define LogDealloced(class) NSLog(@"class is dealloced here.");

// 教师版班级封面按钮的tag值
#define TeacherDoneButtonTag 1000
#define TeacherDeleteButtonTag 200
