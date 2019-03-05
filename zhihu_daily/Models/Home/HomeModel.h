//
//  Home.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject

@property(strong, readonly, nonatomic)NSMutableArray *topStories;//不能直接addObject，需要初始化
@property(strong, nonatomic)NSMutableArray *sectionStories;
@property(assign, nonatomic)BOOL isLoading;
@property(strong, nonatomic)NSString *currentLoadDayStr; //已加载最靠前那一天的日期字符串

//NSUInteger是无符号的
//int和NSInteger其实是差不多的，但更推荐使用NSInteger，因为使用NSInteger,这样就不用考虑设备是32位还是64位了。

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;
//- (StoryCellViewModel *)cellViewModelAtIndexPath:(NSIndexPath *)indexPath;

- (void)getLatestStories;
- (void)getBeforeStories;

@end

NS_ASSUME_NONNULL_END
