//
//  Utils.h
//  zhihu_daily
//
//  Created by Larry on 2019/3/6.
//  Copyright © 2019 朱凌霄. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+ (UIImage *)imageFromURLString: (NSString *) urlstring;

+ (void)showLoading:(NSString *)title;
+ (void)showLoading;
+ (void)hideLoading;
+ (void)showToast:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
