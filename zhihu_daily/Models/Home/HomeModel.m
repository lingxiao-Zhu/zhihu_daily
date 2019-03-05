//
//  Home.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

-(void)getLatestStories{
    
    [NetOperation getRequest:@"/api/4/news/latest" success:^(id  _Nonnull responseObject) {
        
        NSDictionary *jsonDic = responseObject;
        NSLog(@"%@", jsonDic);
        NSMutableArray *tArr = [NSMutableArray arrayWithObject:jsonDic];
        [self setValue:tArr forKey:@"sectionStories"];
        self.currentLoadDayStr = jsonDic[@"date"];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    
}

-(void)getBeforeStories{
    
    NSString *strUrl = [NSString stringWithFormat:@"/api/4/news/before%@", self.currentLoadDayStr];
    
    [NetOperation getRequest:strUrl success:^(id  _Nonnull responseObject) {
        NSDictionary *jsonDic = responseObject;
        NSLog(@"%@", jsonDic);
        [self.sectionStories addObject:jsonDic];
        self.currentLoadDayStr = jsonDic[@"date"];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dict = self.sectionStories[section];
    
    NSArray *storys = dict[@"stories"];
    
    return storys.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionStories.count;
}

- (NSString *)titleForSection:(NSInteger)section{
    
    NSString *dateStr = [self.sectionStories[section] objectForKey:@"date"];
    
    return dateStr;
    
}

- (NewsItemCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *obj = [self.sectionStories objectAtIndex:indexPath.section];
    
    NewsItemCell *cell = [[obj objectForKey:@"stories"] objectAtIndex:indexPath.row];
    
    return cell;
    
}

@end
