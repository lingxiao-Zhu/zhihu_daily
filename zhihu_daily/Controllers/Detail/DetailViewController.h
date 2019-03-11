//
//  DetailViewController.h
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property(copy, nonatomic)NSString *storyTitle;
@property(copy, nonatomic)NSString *imageURL;
@property(copy, nonatomic)NSString *storyID;

@end

NS_ASSUME_NONNULL_END
