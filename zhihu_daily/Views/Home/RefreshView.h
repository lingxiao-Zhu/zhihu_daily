//
//  RefreshView.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/8.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefreshView : UIView

@property(assign,nonatomic)BOOL refresh;

- (void)startAnimation;

- (void)stopAnimation;

- (void)redrawFromProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
