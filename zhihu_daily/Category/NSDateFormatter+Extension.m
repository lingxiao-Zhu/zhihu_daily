//
//  NSDateFormatter+Extension.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/6.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id shareInstance;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

@end
