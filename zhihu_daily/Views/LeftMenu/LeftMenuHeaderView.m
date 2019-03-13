//
//  LeftMenuHeaderView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/13.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "LeftMenuHeaderView.h"

@implementation LeftMenuHeaderView

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
        
        //1.添加头像
        UIImageView *avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_Avatar"]];
        [self addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50.f, 50.f));
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self).offset(10);
        }];
        
        //2.添加名称
        UILabel *name = [[UILabel alloc] init];
        name.text = @"请登录";
        name.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1.00];
        [self addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avatar);
            make.left.mas_equalTo(avatar.mas_right).offset(20);
        }];
        
    }
    return self;
}



@end
