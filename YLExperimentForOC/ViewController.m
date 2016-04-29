//
//  ViewController.m
//  YLExperimentForOC
//
//  Created by syl on 16/4/26.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "ViewController.h"
#import "QREncoding.h"
#import "CalendarViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self creatQRCode];
    [self creatSimpleCalendar];
}
- (void)creatQRCode
{
    CGFloat imageSize = ceilf(self.view.bounds.size.width * 0.6f);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf(self.view.bounds.size.width * 0.5f - imageSize * 0.5f), floorf(self.view.bounds.size.height * 0.5f - imageSize * 0.5f), imageSize, imageSize)];
    //生成二维码图片
    imageView.image = [QREncoding createQRcodeForString:@"http://www.baidu.com" withSize:imageView.bounds.size.width withRed:255 green:0 blue:0];
    //添加中心图片
    UIImageView *centerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhifubao.png"]];
    centerImage.frame= CGRectMake(0, 0, 38.f, 38.f);
    centerImage.center = CGPointMake(CGRectGetWidth(imageView.frame)/2.f, CGRectGetHeight(imageView.frame)/2.f);
    [imageView addSubview:centerImage];
    [self.view addSubview:imageView];

}
- (void)creatSimpleCalendar
{
    CalendarViewController *temp = [[CalendarViewController alloc] init];
    [temp.view setFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self addChildViewController:temp];
    [self.view addSubview:temp.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
