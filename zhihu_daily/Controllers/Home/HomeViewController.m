//
//  HomeViewController.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeViewController.h"
#import "SectionTitleView.h"
#import "TableCellView.h"
#import "CarouselView.h"
#import "HeaderView.h"
#import "CarouselItemPOJO.h"

static const CGFloat kSectionHeaderHeight = 50.f;
static const CGFloat CarouselViewHeight = 240.f;

@interface HomeViewController ()

@property(strong, nonatomic)CarouselView *carouselView;
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)HeaderView *headerView;

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

-(void)prepareHeader{
    
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, KSafeAreaTop + 38.f)];
    
    self.headerView.titleLab.attributedText = [[NSAttributedString alloc] initWithString:@"今日新闻" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.view addSubview:self.headerView];
    
}

-(void)prepareTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(-KSafeAreaTop, 0, 0, 0);
    
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
    
    cell.imgView.image = [Utils imageFromURLString:[newsItemCellPOJO.images firstObject]];
    
    cell.titleLabel.text = newsItemCellPOJO.title;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section == 0){
//        return 0;
//    }
    return kSectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SectionTitleView *sHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    
    if(sHeader == nil){
        sHeader = [[SectionTitleView alloc] initWithReuseIdentifier:@"SectionHeader"];
    }
    
    [sHeader setHeaderFooterBackgroundColor:[UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:1.f]];
    
    sHeader.textLabel.textColor = [UIColor whiteColor];
    
    return sHeader;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
    //获取偏移量
    CGFloat y = scrollView.contentOffset.y;
    
    if (y <= 0 ) {
        
        //恢复header颜色
        self.headerView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0];
        
        //限制下拉距离
        NSInteger distance = -80;
        
        if(scrollView.contentOffset.y < distance && scrollView.isDragging){
            
            y = distance;
            
            [scrollView setContentOffset:CGPointMake(0, distance)];
            
        }
        
        //我们只需要改变图片的y值和高度即可
        CGRect rect = self.tableView.tableHeaderView.frame;
        rect.origin.y = y;
        rect.size.height = CarouselViewHeight - y;
        [self.carouselView setRect:rect];
    
    }else{
        
        //改变header颜色
        self.headerView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha: y / (CarouselViewHeight-38.f)];
        
    }
    
}

//实现分页
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
