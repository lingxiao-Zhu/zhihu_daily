//
//  DetailViewController.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailModel.h"
#import "DetailStoryPOJO.h"
#import "DetailHeaderView.h"

@interface DetailViewController ()<UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)DetailHeaderView *detailHeaderView;
@property(strong, nonatomic)DetailModel *detailModel;
@property(strong, nonatomic)DetailStoryPOJO *storyDetail;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initModel];
    [self initSubViews];
}

-(void)initModel{
    _detailModel = [[DetailModel alloc] init];
    _detailModel.storyID = _storyID;
    [_detailModel getStoryDetail];    
}

-(void)initSubViews{
    _scrollView = ({
        UIScrollView *view = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        view.delegate = self;
        view.backgroundColor = [UIColor redColor];
        view.contentInset = UIEdgeInsetsMake(-KSafeAreaTop, 0, 0, 0);
        [self.view addSubview:view];
        view;
    });
    
    _detailHeaderView = ({
        DetailHeaderView *view = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240.f)];
        [self.scrollView addSubview:view];
        view;
    });
}

@end
