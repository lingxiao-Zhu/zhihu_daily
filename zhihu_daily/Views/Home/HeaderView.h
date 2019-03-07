//
//  HeaderView.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/7.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^leftBtnTapBlock)(void);

@interface HeaderView : UIView

@property (strong,nonatomic)UIView *backgroundView;
@property (strong,nonatomic)UILabel *titleLab;
@property (strong,nonatomic)UIButton *leftBtn;
@property (strong,nonatomic)leftBtnTapBlock leftBtnTapAction;

@end

NS_ASSUME_NONNULL_END
