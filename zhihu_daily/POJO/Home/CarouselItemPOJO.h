//
//  CarouselItemPOJO.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/7.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarouselItemPOJO : JSONModel

@property (strong, nonatomic)NSString *storyID;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *image;

@end

NS_ASSUME_NONNULL_END
