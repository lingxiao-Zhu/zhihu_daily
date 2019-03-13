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
#import "DetailToolBarView.h"
#import <WebKit/WebKit.h>

static const CGFloat kHeaderViewHeight = 240.f;

@interface DetailViewController ()<WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate>

@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)DetailHeaderView *detailHeaderView;
@property(strong, nonatomic)DetailModel *detailModel;
@property(strong, nonatomic)WKWebView *webView;
@property(strong, nonatomic)DetailToolBarView *toolBarView;

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
    [self.detailModel addObserver:self forKeyPath:@"storyExtra" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers{
    [self.detailModel removeObserver:self forKeyPath:@"storyDetail"];
    [self.detailModel removeObserver:self forKeyPath:@"storyExtra"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"storyDetail"]){
        [self.detailHeaderView setImageViewWith:self.detailModel.storyDetail.image];
        [self.webView loadHTMLString:self.detailModel.htmlStr baseURL:[[NSBundle mainBundle]bundleURL]];
    }
    if([keyPath isEqualToString:@"storyExtra"]){
//        UILabel *commentsLabel = [[UILabel alloc] init];
    }
}

-(void)initModel{
    self.detailModel = [[DetailModel alloc] init];
    self.detailModel.storyID = _storyID;
    [self.detailModel fetchStoryDetail];
    [self.detailModel fetchStoryExtra];
    [self configAllObservers];
}

-(void)initSubViews{
    
    CGFloat kToolBarHeight = kIsIphoneX ? 43.f + 34.f : 43.f;
    
    _toolBarView = ({
        DetailToolBarView *view = [[DetailToolBarView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kToolBarHeight, kScreenWidth, kToolBarHeight)];;
        __weak typeof(self)weakSelf = self;
        view.back = ^{
           __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
        [self.view addSubview:view];
        view;
    });
    
    _scrollView = ({
        UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kToolBarHeight)];
        view.contentInset = UIEdgeInsetsMake(-KSafeAreaTop, 0, 0, 0);
        view.delegate = self;
        [self.view addSubview:view];
        view;
    });
    
    _detailHeaderView = ({
        DetailHeaderView *view = [[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight)];
        [view setTitle:self.storyTitle];
        [_scrollView addSubview:view];
        view;
    });
    
    _webView = ({
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        NSString *js = @"document.getElementsByClassName('img-place-holder')[0].style.display = 'none'";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:script];
        
        WKWebView *view = [[WKWebView alloc] initWithFrame:CGRectMake(0, kHeaderViewHeight, kScreenWidth, kScreenHeight) configuration:config];
        view.navigationDelegate = self;
        view.UIDelegate = self;
        
        [view.scrollView setScrollEnabled:NO];
        
        [_scrollView addSubview:view];
        
        view;
    });
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        CGRect frame = self.webView.frame;
        frame.size.height = [data floatValue];
        self.webView.frame = frame;
        
        // scrollview必须设置contentSize
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, [data floatValue]+kHeaderViewHeight);
        [self.webView.scrollView setBackgroundColor:[UIColor clearColor]];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if(offsetY <= 0){
        
        CGRect frame = _detailHeaderView.frame;
        
        frame.origin.y = offsetY;//位置往上移
        frame.size.height = kHeaderViewHeight - offsetY;//高度拉长
        
        _detailHeaderView.frame = frame;
        
    }
    
}

@end
