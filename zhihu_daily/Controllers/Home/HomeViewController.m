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

static const CGFloat kSectionHeaderHeight = 50.f;

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.homeModel = [[HomeModel alloc] init];
    [self configAllObservers];
    [self.homeModel getLatestStories];
}

-(void)dealloc{
    [self removeAllObservers];
}

- (void)configAllObservers{
    [self.homeModel addObserver:self forKeyPath:@"sectionStories" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeAllObservers{
     [self.homeModel removeObserver:self forKeyPath:@"sectionStories"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:@"sectionStories"]){
        [self.tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryItem"];
    
    if(cell == nil){
        cell = [[TableCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoryItem"];
    }
   
    NewsItemCellPOJO *newsItemCellPOJO = [self.homeModel cellForRowAtIndexPath:indexPath];
    
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

@end
