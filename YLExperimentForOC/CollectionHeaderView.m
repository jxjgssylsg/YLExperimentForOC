//
//  CollectionHeaderView.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "CollectionHeaderView.h"

float CYLFilterHeaderViewHeigt = 38;

@implementation CollectionHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [self headViewInit];
    }
    return self;
}

- (id)headViewInit {
    self.backgroundColor = [UIColor colorWithRed:188.0/255.0 green:188.0/255.0 blue:188.0/255.0 alpha:1.0];
    UIView *yellowSmallIcon = [[UIView alloc] initWithFrame:CGRectMake(15, 7, 6, 17)];
    yellowSmallIcon.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:204 / 255.0 blue:36 / 255.0 alpha:1.0];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(26, 0, 200, 30)];
    self.titleLabel.text = @"关于老师";
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.titleLabel];
    [self addSubview:yellowSmallIcon];
    return self;
}

@end
