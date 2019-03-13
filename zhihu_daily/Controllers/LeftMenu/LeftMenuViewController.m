//
//  LeftMenuViewController.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/13.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "LeftMenuViewController.h"

//views
#import "LeftMenuHeaderView.h"

@interface LeftMenuViewController ()

@property(strong, nonnull)LeftMenuHeaderView *headerView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.11 green:0.14 blue:0.17 alpha:1.00];
    [self initSubviews];
}

- (void)initSubviews{
    
    _headerView = ({
        CGRect frame = CGRectMake(0, KSafeAreaTop, self.view.frame.size.width, 80.f);
        LeftMenuHeaderView *view = [[LeftMenuHeaderView alloc] initWithFrame:frame];
        [self.view addSubview:view];
        view;
    });
    
}



@end
