//
//  Utils.m
//  zhihu_daily
//
//  Created by Larry on 2019/3/6.
//  Copyright © 2019 朱凌霄. All rights reserved.
//

#import "Utils.h"
#import <MBProgressHUD/MBProgressHUD.h>

static MBProgressHUD *hud;

@implementation Utils

+ (UIImage *)imageFromURLString:(NSString *)urlstring{
    return [UIImage imageWithData:[NSData
                                   dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

+ (void)showLoading:(NSString *)title{
    hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].keyWindow rootViewController].view animated:YES];
    hud.label.text = title;
}

+ (void)showLoading{
    hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].keyWindow rootViewController].view animated:YES];
}

+ (void)hideLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

+ (void)showToast:(NSString *)msg{
    hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].keyWindow rootViewController].view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:3.f];
}


@end
