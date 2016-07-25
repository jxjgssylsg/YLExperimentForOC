//
//  CollectionViewCell.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/7/15.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}
- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup {
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleLabel.layer.cornerRadius = 5.0; 
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4.0;
    self.titleLabel.layer.masksToBounds = YES;
    
    // 选中时 image
    UIImage *image = [UIImage imageNamed:@"selectedBackground.png"];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp]; // 缩小成 1/2
    _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _selectedImage.image = image;
    // _selectedImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:_selectedImage];
}

@end
