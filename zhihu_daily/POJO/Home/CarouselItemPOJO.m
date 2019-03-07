//
//  CarouselItemPOJO.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/7.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "CarouselItemPOJO.h"

@implementation CarouselItemPOJO

//属性名称映射
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"storyID":@"id"}];
}

@end
