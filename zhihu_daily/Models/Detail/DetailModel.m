//
//  DetailModel.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (void)getStoryDetail{
    
    NSString *strUrl = [NSString stringWithFormat:@"/api/4/news/%@", _storyID];
    
    [NetOperation getRequest:strUrl success:^(id  _Nonnull responseObject) {
        
        DetailStoryPOJO *storyDetail = [[DetailStoryPOJO alloc] initWithDictionary:responseObject error:nil];
        
        [self setValue:storyDetail forKey:@"storyDetail"];
        
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"fail_DetailModel");
        
    }];
    
}

- (NSString *)htmlStr {
    
    NSString *str = @"<html><head><meta name='viewport' content='initial-scale=1.0,user-scalable=no' /><link type='text/css' rel='stylesheet' href='http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3' ></link></head><body>%@</body></html>";
    
    return [NSString stringWithFormat:str, _storyDetail.body];
}

@end
