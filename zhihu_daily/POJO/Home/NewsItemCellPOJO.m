//
//  NewsItem.m
//  zhihu_daily
//
//  Created by Larry on 2019/3/5.
//  Copyright © 2019 朱凌霄. All rights reserved.
//

#import "NewsItemCellPOJO.h"

@implementation NewsItemCellPOJO

//属性名称映射
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"storyID":@"id"}];
}

//属性是否可以为空
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    if([propertyName isEqualToString:@"multipic"]){
        return YES;
    }
//    if([propertyName isEqualToString:@"images"]) {
//        return YES;
//    }
    return NO;
}

@end
