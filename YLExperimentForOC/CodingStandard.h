//
//  CodingStandard.h
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/13.
//  Copyright © 2016年 yilin. All rights reserved.
//

#ifndef CodingStandard_h
#define CodingStandard_h

/*

// ------------------------  类,属性 ------------------------//
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIWindow *window;

@end
 
@implementation _YYWebImageSetter {
    NSURL *_imageURL;
    NSOperation *_operation; // 空一格
    int32_t _sentinel;
}


// ------------------------ 方法 ------------------------//
- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic;

- (void)setImageWithURL:(NSURL *)imageURL options:(YYWebImageOptions)options {
    
}


// ------------------------  定义代理 ------------------------//
@protocol WBEmoticonScrollViewDelegate <UICollectionViewDelegate>

- (void)emoticonScrollViewDidTapCell:(WBEmoticonCell *)cell;

@end
  
@property (nonatomic, weak) id<T1StatusCellDelegate> delegate; // 代理使用
    

// ------------------------  block 定义 ------------------------//
typedef NSComparisonResult (^NSComparator)(id obj1, id obj2);
typedef void (^CoverDecodeBlock)(id src);
typedef void (^SingleFrameDecodeBlock)(id src, NSUInteger index);
typedef void (^AllFrameDecodeBlock)(id src, BOOL reverseOrder);
 
UIViewAnimationOptionBeginFromCurrentState animations:^{
   .....
}

[self enumerateAttribute:YYTextBackedStringAttributeName inRange:range options:kNilOptions usingBlock:^(id value, NSRange range, BOOL *stop) {
    ......
}
 
// ------------------------  宏定义 定义 ------------------------//
#define Me @"shengyilin"   // 一般情况下
 
#define ParagraphAttribute(_attr_) \
NSParagraphStyle *style = self.paragraphStyle; \
if (!style) style = [NSParagraphStyle defaultParagraphStyle]; \
return style. _attr_;
 
#define ParagraphAttributeAtIndex(_attr_) \
NSParagraphStyle *style = [self paragraphStyleAtIndex:index]; \
if (!style) style = [NSParagraphStyle defaultParagraphStyle]; \
return style. _attr_;
 
 - (NSTextAlignment)alignment {
     ParagraphAttribute(alignment); // 这个宏包括了 return
 }
 
// ------------------------  Switch case ------------------------//
switch (property->_type & YYEncodingTypeMask) {
     case YYEncodingTypeObject: {
         id v = ((id (*)(id, SEL))(void *) objc_msgSend)((id)model, property->_getter);
         if (!propertyDesc) propertyDesc = @"<nil>";
     } break;
     case YYEncodingTypeStruct: case YYEncodingTypeUnion: {
         NSValue *value = [model valueForKey:property->_name];
     } break;
     default: propertyDesc = @"<unknown>"; break;
 }
}
 
// ------------------------  泛型 ------------------------//
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
 }
 
#endif /* CodingStandard_h */




