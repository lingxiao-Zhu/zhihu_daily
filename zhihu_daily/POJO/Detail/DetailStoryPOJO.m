//
//  DetailStoryPOJO.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailStoryPOJO.h"

@implementation DetailStoryPOJO

//属性名称映射
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"storyID":@"id"}];
}


@end
