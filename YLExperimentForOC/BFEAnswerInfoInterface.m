//
//  BFEAnswerInfoInterface.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/8/1.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "BFEAnswerInfoInterface.h"
#import "Macros.h"
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface BFEAnswerInfoInterface ()

@end

@implementation BFEAnswerInfoInterface

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setHeaderImage];
        [self setContentLabel];
    }
    return self;
}

- (void)setHeaderImage {
    _imagePath = @"bgEarn.png";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 268)];
    imageView.image = [UIImage imageNamed:_imagePath];
    imageView.contentMode = UIViewContentModeScaleAspectFit; // UIViewContentModeScaleAspectFit;
    _headerImageView = imageView;
    [self addSubview:_headerImageView];
}

- (void)setContentLabel {
    _content = @"Step 1: Receive questions and answers in audios from students. \nStep 2: Assess the answers with 2-minute videos. \nStep 3: Send back and get $1. \nYou can choose how many answers to assess every day \nAssessments should be more postive to encourage students. \nFocus more on the opinions or things students said.\n ";
    UILabel *contentLabel = [[UILabel alloc] init];
    // contentLabel.frame = CGRectMake(25, 372, 0, 0);
    // contentLabel.font = [UIFont systemFontOfSize:16];
    // contentLabel.textColor = [UIColor colorWithRed:157 / 255.0f green:157 / 255.0 blue:157 / 255.0 alpha:1];
    contentLabel.text = _content;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 0;
    // [contentLabel sizeToFit];
    
    // 正则表达式
    NSRange stepRange = [contentLabel.text rangeOfString:@"You can choose[.\\n]*day" options: NSRegularExpressionSearch]; // 注. [.?(] 中括号中的字符并非元字符,变成了普通的字符,所以无效,请看定义
    stepRange = [contentLabel.text rangeOfString:@"You can choose[\\s\\S]*said." options:NSRegularExpressionSearch];
    stepRange = [contentLabel.text rangeOfString:@"You can choose(.|\\n)*said." options:NSRegularExpressionSearch];
    stepRange = [contentLabel.text rangeOfString:@"You can choose(.|\\n)*said/." options:NSRegularExpressionSearch];
    stepRange = [contentLabel.text rangeOfString:@"You can choose(.|\\n)*said\." options:NSRegularExpressionSearch];
    stepRange = [contentLabel.text rangeOfString:@"You can choose(.|\\n)*said" options:NSRegularExpressionSearch];
    stepRange = [contentLabel.text rangeOfString:@"You can choose(.|\\n)*said\.\\." options:NSRegularExpressionSearch];
    
    _content =@"///\\"; // 这里是 ///\ 噢
    stepRange = [_content rangeOfString:@"/" options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"\/" options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"." options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"\." options:NSRegularExpressionSearch]; // 无法转义 ?
    stepRange = [_content rangeOfString:@"\\." options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"[/aeiou]" options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"[aeiou]" options:NSRegularExpressionSearch];
    
    _content = @"a///.\."; // 这里变成了 a///..
    stepRange = [_content rangeOfString:@"\\." options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@".\\." options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"\\.\\." options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"w" options:NSRegularExpressionSearch];
    stepRange = [_content rangeOfString:@"\w" options:NSRegularExpressionSearch]; // 这里是 w
    stepRange = [_content rangeOfString:@"\\w" options:NSRegularExpressionSearch]; // 这里才是 \w,要理解好, 转义后的字符串才是输入, 所以 \w 转义成了 w, 而 \\w 转义成了 \w, 才是元字符
    
    // 上面的都是测试
    _content = @"Step 1: Receive questions and answers in audios from students. \nStep 2: Assess the answers with 2-minute videos. \nStep 3: Send back and get $1. \nYou can choose how many answers to assess every day \nAssessments should be more postive to encourage students. \nFocus more on the opinions or things students said.\n ";
    stepRange = [contentLabel.text rangeOfString:@"Step 1:[\\s\\S]*said." options:NSRegularExpressionSearch];
    NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
    tempParagraph.lineSpacing = 4;
    tempParagraph.paragraphSpacing = 4;
    tempParagraph.lineBreakMode = NSLineBreakByWordWrapping;
   // tempParagraph.firstLineHeadIndent = 20.f;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSParagraphStyleAttributeName:tempParagraph} range:stepRange];
    // 第二个属性
    stepRange = [contentLabel.text rangeOfString:@"You can choose[\\s\\S]*said." options:NSRegularExpressionSearch];
    tempParagraph.paragraphSpacing = 7;
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:tempParagraph} range:stepRange];
    
    stepRange = [contentLabel.text rangeOfString:@"Step 1:" options:NSRegularExpressionSearch];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} range:stepRange];
    
    stepRange = [contentLabel.text rangeOfString:@"Step 2:" options:NSRegularExpressionSearch];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} range:stepRange];
    
    stepRange = [contentLabel.text rangeOfString:@"Step 3:" options:NSRegularExpressionSearch];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} range:stepRange];
    
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 25, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    contentLabel.frame = CGRectMake(25, 278, rect.size.width, rect.size.height);
    contentLabel.attributedText = attrStr;
     _contentLabel = contentLabel;
    [self addSubview:_contentLabel];
    
    /*
    UILabel *lbTemp =[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 700)];
    lbTemp.backgroundColor = [UIColor brownColor];
    lbTemp.lineBreakMode =  NSLineBreakByCharWrapping;
    lbTemp.numberOfLines = 0;
    lbTemp.text = @"天天\n上课,还挂科,是在是蛋疼.....希望这个地球更加美丽漂亮,随便写些东西都不是容易的事情啊";
    NSRange stepRange = [lbTemp.text rangeOfString:@"Step 1:"];
    [self.view addSubview:lbTemp];
    
    NSMutableParagraphStyle *tempParagraph = [[NSMutableParagraphStyle alloc] init];
    tempParagraph.lineSpacing = 20;
    tempParagraph.firstLineHeadIndent = 20.f;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:lbTemp.text];
    [attrStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25],NSForegroundColorAttributeName:[UIColor redColor],NSParagraphStyleAttributeName:tempParagraph} range:allRange];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    lbTemp.frame = CGRectMake(50, 50, rect.size.width, rect.size.height);
    lbTemp.attributedText = attrStr;
     */
}

@end
