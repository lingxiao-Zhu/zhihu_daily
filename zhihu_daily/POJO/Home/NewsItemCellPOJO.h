//
//  NewsItem.h
//  zhihu_daily
//
//  Created by Larry on 2019/3/5.
//  Copyright © 2019 朱凌霄. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsItemCellPOJO : JSONModel

@property (strong, nonatomic)NSString *storyID;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSArray *images;
@property (assign, nonatomic)BOOL multipic;

@end

NS_ASSUME_NONNULL_END
