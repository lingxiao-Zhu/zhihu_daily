//
//  DetailModel.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailStoryPOJO.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

@property(strong, nonatomic)NSString *storyID;
@property(strong, nonatomic)DetailStoryPOJO* storyDetail;

-(void)getStoryDetail;
-(NSString *)htmlStr;

@end

NS_ASSUME_NONNULL_END
