//
//  DetailToolBarView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailToolBarView.h"

//单个按钮
@interface HPYButton : UIButton

@end

@implementation HPYButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.titleLabel.center = CGPointMake(self.frame.size.width/2+10.f, self.frame.size.height/2-8.f);
    self.titleLabel.bounds = CGRectMake(0, 0, 30, 10);
    self.titleLabel.font = [UIFont systemFontOfSize:8];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation DetailToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *lineLayer = [CALayer new];
        lineLayer.frame = CGRectMake(0.f, 0.f, frame.size.width, 1.f);
        lineLayer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self.layer addSublayer:lineLayer];
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat btn_width = frame.size.width / 5;
        CGFloat btn_height = frame.size.height - [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        
        // 1.添加返回按钮
        HPYButton *btnBack = [[HPYButton alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_height)];
        [btnBack setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
    
        // 2.添加下一篇按钮
        HPYButton *btnNext = [[HPYButton alloc] initWithFrame:CGRectMake(btn_width, 0, btn_width, btn_height)];
        [btnNext setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
        [self addSubview:btnNext];
        
        // 3.添加点赞按钮
        HPYButton *btnVote = [[HPYButton alloc] initWithFrame:CGRectMake(btn_width*2, 0, btn_width, btn_height)];
        [btnVote setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
        [btnVote setTitle:@"100" forState:UIControlStateNormal];
        [btnVote setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:btnVote];
        
        // 4.添加分享按钮
        HPYButton *btnShare = [[HPYButton alloc] initWithFrame:CGRectMake(btn_width*3, 0, btn_width, btn_height)];
        [btnShare setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
        [self addSubview:btnShare];
        
        // 5.添加评论按钮
        HPYButton *btnComment = [[HPYButton alloc] initWithFrame:CGRectMake(btn_width*4, 0, btn_width, btn_height)];
        [btnComment setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
        [btnComment setTitle:@"100" forState:UIControlStateNormal];
        [btnComment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btnComment];
        
    }
    return self;
}

- (void)backAction:(id)sender {
    !_back ? :_back();
}

@end
