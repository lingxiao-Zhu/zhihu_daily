//
//  CarouselView.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarouselView : UIView <SDCycleScrollViewDelegate>

-(void)setTitle:(NSArray *)titles;

-(void)setImageUrls:(NSArray *)imageUrls;

-(void)setRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
