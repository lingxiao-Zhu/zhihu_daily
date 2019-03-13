//
//  DetailExtraPOJO.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/13.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailExtraPOJO : JSONModel

@property (assign, nonatomic)NSInteger long_comments;
@property (assign, nonatomic)NSInteger popularity;
@property (assign, nonatomic)NSInteger short_comments;
@property (assign, nonatomic)NSInteger comments;

@end

NS_ASSUME_NONNULL_END
