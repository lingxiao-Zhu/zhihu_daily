//
//  HeaderView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/7.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

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
       self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(frame.size.height);
                make.top.left.right.equalTo(self);//设置长宽
            }];
            
            view;
        });
        
        _titleLab = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.backgroundView).offset(-10);
            }];
            label;
        });
        
        _leftBtn = ({
            UIButton *btn = [UIButton new];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self).offset(10.f);
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
