//
//  Utils.m
//  zhihu_daily
//
//  Created by Larry on 2019/3/6.
//  Copyright © 2019 朱凌霄. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIImage *)imageFromURLString:(NSString *)urlstring{
    return [UIImage imageWithData:[NSData
                                   dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

@end
