//
//  DetailToolBarView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailToolBarView.h"

@implementation DetailToolBarView

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
        CALayer *lineLayer = [CALayer new];
        lineLayer.frame = CGRectMake(0.f, 0.f, frame.size.width, 1.f);
        lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.layer addSublayer:lineLayer];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

@end
