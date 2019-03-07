//
//  Home.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "HomeModel.h"
#import "NSDateFormatter+Extension.h"

@implementation HomeModel

-(void)getLatestStories{
    
    [NetOperation getRequest:@"/api/4/news/latest" success:^(id  _Nonnull responseObject) {
        NSDictionary *jsonDic = responseObject;

        NSMutableArray *sectionArr = [NSMutableArray arrayWithObject:jsonDic];
        NSMutableArray *topArr = [[NSMutableArray alloc] initWithArray:[jsonDic objectForKey:@"top_stories"]];
        
        [self setValue:sectionArr forKey:@"sectionStories"];
        [self setValue:topArr forKey:@"topStories"];

        self.currentLoadDayStr = jsonDic[@"date"];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
    
}

-(void)getBeforeStories{
    
    NSString *strUrl = [NSString stringWithFormat:@"/api/4/news/before%@", self.currentLoadDayStr];
    
    [NetOperation getRequest:strUrl success:^(id  _Nonnull responseObject) {
        NSDictionary *jsonDic = responseObject;
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
    
    return [self stringConvertToSectionTitleText:dateStr];
    
}

- (NSString*)stringConvertToSectionTitleText:(NSString*)str {
    
    NSDateFormatter *formatter = [NSDateFormatter sharedInstance];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:str];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    
    return sectionTitleText;
}

- (NewsItemCellPOJO *)cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *section = [self.sectionStories objectAtIndex:indexPath.section];
    
    NSDictionary *story = [[section objectForKey:@"stories"] objectAtIndex:indexPath.row];
    
    NewsItemCellPOJO *cell = [[NewsItemCellPOJO alloc] initWithDictionary:story error:nil];
    
    return cell;
    
}

@end
