//
//  DetailHeaderView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailHeaderView.h"

@implementation DetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.添加图片
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height)];
        
        [self addSubview:image];
        
    }
    return self;
}

@end
