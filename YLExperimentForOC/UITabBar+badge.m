//
//  UITabBar+badge.m
//  NavigationAndTabbar
//
//  Created by mingdffe on 16/8/15.
//  Copyright © 2016年 Rifkilabs. All rights reserved.
//

#import "UITabBar+badge.h"
// #define TabbarItemNums 5.0  // tabbar的数量 如果是5个设置为5.0
#import <objc/runtime.h>
// #import "UITabBarButton.h"

@implementation UITabBar (badge)
// 显示小红点
- (void)showBadgeOnItemIndex:(int)index barItemNum:(int)itemNum {


    // 移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    [self printRuntime];
    
    // 新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5; // 圆形
    badgeView.backgroundColor = [UIColor redColor]; // 颜色：红色
    CGRect tabFrame = self.frame;
    
    // 确定小红点的位置
    float percentX = (index + 0.6) / itemNum;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10); // 圆形大小为 10
    [self addSubview:badgeView];
}

// 隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index {
    // 移除小红点
    [self removeBadgeOnItemIndex:index];
}

// 移除小红点
- (void)removeBadgeOnItemIndex:(int)index {
    // 按照 tag 值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}


- (void)printRuntime {
    [self printIvarList];
    [self printPropertyList];
    [self printMethodList];
}

- (void)printIvarList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    

    // 获取所有成员变量，对于属性会自动生成_成员变量
    Ivar *ivars = class_copyIvarList([UITabBarItem class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar); // runtime是用C写的。
        const char *ivarType = ivar_getTypeEncoding(ivar);
        NSString *strName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSString *strType = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
        NSLog(@"ivarName : %@", strName);
        NSLog(@"ivarType : %@", strType);
    }
    // _unselectedImage, _view:UITabBarButton
    Ivar _ivarMyName = class_getInstanceVariable([UITabBarItem class], "_myName");
    NSLog(@"_ivarMyName : %@", object_getIvar(self, _ivarMyName));
    object_setIvar(self, _ivarMyName, @"MyName");
    NSLog(@"_ivarMyName : %@", object_getIvar(self, _ivarMyName));
    
    free(ivars);
    
    NSLog(@"\n\n");
}

- (void)printPropertyList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有属性
    objc_property_t *properties = class_copyPropertyList([UITabBarItem class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        const char *propertyAttr = property_getAttributes(property);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *strAttr = [NSString stringWithCString:propertyAttr encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", strName);
        NSLog(@"propertyAttr : %@", strAttr);
        
        u_int attrCount = 0;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        for (int j = 0; j < attrCount; j++) {
            objc_property_attribute_t attr = attrs[j];
            const char *attrName = attr.name;
            const char *attrValue = attr.value;
            NSLog(@"attrName: %s", attrName);
            NSLog(@"attrValue: %s", attrValue);
        }
        free(attrs);
    }
    free(properties);
    
    NSLog(@"\n\n");
}

- (void)printMethodList {
    NSLog(@"%s", __func__);
    u_int count = 0;
    // 获取所有方法
    Method *methods = class_copyMethodList([UITabBarItem class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        // 方法类型是SEL选择器类型
        SEL methodName = method_getName(method);
        NSString *str = [NSString stringWithCString:sel_getName(methodName) encoding:NSUTF8StringEncoding];
        
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"methodName : %@, arguments Count: %d", str, arguments);
        //
        //        const char *retType = method_copyReturnType(method);
        //        if (retType != "@") {
        //            str = [NSString stringWithCString:retType encoding:NSUTF8StringEncoding];
        //            NSLog(@"returnType : %@", str);
        //        }
        //
        //        const char *argType = method_copyArgumentType(method, i);
        //        if (argType != NULL && argType != "@") {
        //            str = [NSString stringWithCString:argType encoding:NSUTF8StringEncoding];
        //            NSLog(@"returnType : %@", str);
        //        }
    }
    free(methods);
    
    NSLog(@"\n\n");
}

@end
