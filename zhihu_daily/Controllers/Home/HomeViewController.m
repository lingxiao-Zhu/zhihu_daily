//
//  HomeViewController.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"
#import "SectionTitleView.h"
#import "TableCellView.h"
#import "CarouselView.h"
#import "HomeHeaderView.h"
#import "RefreshView.h"
#import "CarouselItemPOJO.h"

static const CGFloat CarouselViewHeight = 240.f;
static const CGFloat Distance = -80.f;//限制下拉高度

@interface HomeViewController ()

@property(strong, nonatomic)CarouselView *carouselView;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)HomeHeaderView *headerView;
@property(strong, nonatomic)RefreshView *refreshView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.homeModel = [[HomeModel alloc] init];
    
    [self prepareTableView];
    
    [self configAllObservers];
    [self.homeModel getLatestStories];
}

//返回home页面后，恢复
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
}

//离开home页面后，不能打开侧边栏
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
}

-(void)prepareTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [tableView setSeparatorColor:[UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(-KSafeAreaTop, 0, 0, 0);
    [tableView setSeparatorInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    self.tableView = tableView;
    
    [self.view addSubview:tableView];
    
    [self prepareCarouselView];
    
}

-(void)prepareCarouselView{
    CGRect cViewSize = CGRectMake(0, 0, kScreenWidth, CarouselViewHeight);
    self.carouselView = [[CarouselView alloc] initWithFrame:cViewSize];
    self.tableView.tableHeaderView = self.carouselView;
    [self prepareHeader];
}

-(void)prepareHeader{
    
    self.headerView = [[HomeHeaderView alloc] init];
    
    self.headerView.titleLab.attributedText = [[NSAttributedString alloc] initWithString:@"今日要闻" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.headerView.leftBtn setBackgroundImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    
    __weak typeof(self)weakSelf = self;
    self.headerView.leftBtnTapAction = ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    };
    
    [self.view addSubview:self.headerView];
    
    [self prepareRefreshView];
    
}

-(void)prepareRefreshView{
    
    self.refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(0.f,0, 20.f, 20.f)];
    
    [self.view addSubview:self.refreshView];
    
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.titleLab);
        make.left.equalTo(self.headerView.titleLab).offset(-25);
    }];
    
}

-(void)dealloc{
    [self removeAllObservers];
}

- (void)configAllObservers{
    [self.homeModel addObserver:self forKeyPath:@"sectionStories" options:NSKeyValueObservingOptionNew context:nil];
    [self.homeModel addObserver:self forKeyPath:@"topStories" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers{
    [self.homeModel removeObserver:self forKeyPath:@"sectionStories"];
    [self.homeModel removeObserver:self forKeyPath:@"topStories"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"sectionStories"]){
        [self.tableView reloadData];
    }
    
    if([keyPath isEqualToString:@"topStories"]){
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        NSArray *topStorys = [[NSArray alloc] initWithArray:self.homeModel.topStories];
        for(int i = 0; i < topStorys.count; i++){
            CarouselItemPOJO *cItem = [[CarouselItemPOJO alloc] initWithDictionary:topStorys[i] error:nil];
            [titles addObject:cItem.title];
            [images addObject:cItem.image];
        }
        [self.carouselView setTitle:titles];
        [self.carouselView setImageUrls:images];
    }
    
}

#pragma mark -- 实现数据源协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.homeModel numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.homeModel numberOfRowsInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.homeModel titleForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryItem"];
    
    if(cell == nil){
        cell = [[TableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoryItem"];
    }
   
    NewsItemCellPOJO *newsItemCellPOJO = [self.homeModel cellForRowAtIndexPath:indexPath];
    
    //文章主图
    NSURL *url = [NSURL URLWithString:[newsItemCellPOJO.images firstObject]];
    
    [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Image_Preview"]];
    
    cell.titleLabel.text = newsItemCellPOJO.title;
    
    if(newsItemCellPOJO.multipic){
        cell.morePicView.image = [UIImage imageNamed:@"Home_Morepic"];
    }else{
        cell.morePicView.image = nil;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.00001f;
    }
    return kHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SectionTitleView *sHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    
    if(sHeader == nil){
        sHeader = [[SectionTitleView alloc] initWithReuseIdentifier:@"SectionHeader"];
    }
    
    [sHeader setHeaderFooterBackgroundColor:[UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:1.f]];
    
    sHeader.textLabel.textColor = [UIColor whiteColor];
    
    sHeader.textLabel.alpha = section == 0 ? 0 : 1;
    
    return sHeader;
    
}


//监听释放拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //获取偏移量
    CGFloat y = scrollView.contentOffset.y;
    if(y <= Distance && !self.refreshView.refresh){
        [self.refreshView startAnimation];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stopAnimaion) userInfo:nil repeats:NO];
    }
}

-(void)stopAnimaion{
    [_refreshView stopAnimation];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取偏移量
    CGFloat y = scrollView.contentOffset.y;
    
    if (y <= 0 ) {
        
        //恢复header颜色
        self.headerView.backgroundView.alpha = 0;
        
        [_refreshView redrawFromProgress:y/Distance];
        
        if(y < Distance && scrollView.isDragging){
            y = Distance;
            [scrollView setContentOffset:CGPointMake(0, Distance)];
        }
        
        //拉伸轮播图
        CGRect rect = self.tableView.tableHeaderView.frame;
        rect.origin.y = y;
        rect.size.height = CarouselViewHeight - y;
        [self.carouselView setRect:rect];
    
    }else{
        
        [_refreshView redrawFromProgress:0];
        
        //改变header颜色
        self.headerView.backgroundView.alpha = y / (CarouselViewHeight-kHeaderHeight);
        
    }
    
}

//实现分页
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsItemCellPOJO *nowStoryInfo = [self.homeModel cellForRowAtIndexPath:indexPath];
    
    NSDictionary *lastStoryInfoDic = [[[self.homeModel.sectionStories lastObject] objectForKey:@"stories"] lastObject];
    
    NewsItemCellPOJO *lastStoryInfo = [[NewsItemCellPOJO alloc] initWithDictionary:lastStoryInfoDic error:nil];
    
    if([nowStoryInfo.storyID isEqualToString:lastStoryInfo.storyID]){
        [self.homeModel getBeforeStories];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if(section == 0){
        self.headerView.titleLab.alpha = 1;
        [self.headerView.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerView);
        }];
        self.tableView.contentInset = UIEdgeInsetsMake(-KSafeAreaTop, 0, 0, 0);
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if(section == 0){
        self.headerView.titleLab.alpha = 0;
        [self.headerView.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerView).offset(-kHeaderHeight);
        }];
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    NewsItemCellPOJO *newsItemCellPOJO = [self.homeModel cellForRowAtIndexPath:indexPath];
        
    detailVC.storyTitle = newsItemCellPOJO.title;
    
    detailVC.storyID = newsItemCellPOJO.storyID;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
