//
//  HomeViewController.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UITableViewController

@property(strong, nonatomic)HomeModel *homeModel;

@end

NS_ASSUME_NONNULL_END
