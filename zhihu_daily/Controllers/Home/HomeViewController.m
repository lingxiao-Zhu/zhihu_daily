//
//  HomeViewController.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeViewController.h"

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoryItem"];
    
    cell.textLabel.text = @"aaaa";
    
    return cell;
    
}

@end
