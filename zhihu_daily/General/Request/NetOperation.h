//
//  NetOperation.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^success)(id responseObject);
typedef void (^failure)(NSError *error);

@interface NetOperation : NSObject

+(void)getRequest:(NSString *)URLString success:(success)success failure:(failure)failure;

+(void)postRequest:(NSString *)URLString parameter:(id)parameter success:(success)success failure:(failure)failure;

@end

NS_ASSUME_NONNULL_END
