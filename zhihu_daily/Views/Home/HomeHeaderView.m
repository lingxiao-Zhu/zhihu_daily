//
//  HeaderView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/7.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        CGRect frame = CGRectMake(0, 0, kScreenWidth, KSafeAreaTop + kHeaderHeight);
        
        self.frame = frame;
        
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        
        _backgroundView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha: 1];

        [self addSubview:_backgroundView];
        
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);//设置长宽
        }];

        _titleLab = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self).offset(-8);
            }];
            label;
        });
        
        _leftBtn = ({
            UIButton *btn = [UIButton new];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.titleLab).offset(-2);
                make.left.mas_equalTo(self.mas_left).offset(16.f);
                make.size.mas_equalTo(CGSizeMake(19.f, 19.f));
            }];
            [btn addTarget:self action:@selector(tapLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        
    }
    return self;
}

- (void)tapLeftBtn:(id)sender {
    if (_leftBtnTapAction) {
        _leftBtnTapAction();
    }
}

@end
