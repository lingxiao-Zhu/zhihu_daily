//
//  SectionTitleView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/6.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "SectionTitleView.h"

@implementation SectionTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];

    return self;
    
}

- (void)setHeaderFooterBackgroundColor:(UIColor *)color{
    self.contentView.backgroundColor = color;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = [UIColor whiteColor];
}

@end
