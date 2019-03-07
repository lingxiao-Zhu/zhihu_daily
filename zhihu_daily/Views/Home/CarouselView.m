//
//  CarouselView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView()

@property(strong, nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation CarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews:frame];
    }
    return self;
}

- (void)initSubViews:(CGRect)frame{
    
    // 网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    
    self.cycleScrollView.clipsToBounds = YES;

    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    
    [self addSubview:self.cycleScrollView];
    
}

-(void)setRect:(CGRect)rect{
    self.cycleScrollView.frame = rect;
}

-(void)setTitle:(NSArray *)titles;{
    self.cycleScrollView.titlesGroup = titles;
}

- (void)setImageUrls:(NSArray *)imageUrls{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = imageUrls;
    });
}

@end
