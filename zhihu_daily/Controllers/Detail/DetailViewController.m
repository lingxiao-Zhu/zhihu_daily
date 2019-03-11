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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initModel];
    [self initSubViews];
}

-(void)dealloc{
    [self removeAllObservers];
}

- (void)configAllObservers{
    [self.detailModel addObserver:self forKeyPath:@"storyDetail" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers{
    [self.detailModel removeObserver:self forKeyPath:@"storyDetail"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"storyDetail"]){
        [self.detailHeaderView setImageViewWith:self.detailModel.storyDetail.image];
    }
    
}

-(void)initModel{
    self.detailModel = [[DetailModel alloc] init];
    self.detailModel.storyID = _storyID;
    [self.detailModel getStoryDetail];
    [self configAllObservers];
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
        [view setTitle:self.storyTitle];
        [self.scrollView addSubview:view];
        view;
    });
}

@end
