//
//  DetailHeaderView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/11.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "DetailHeaderView.h"

@interface DetailHeaderView()

@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *titleLabel;

@end

@implementation DetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.添加图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, frame.size.height)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;

        [self addSubview:self.imageView];
        
        //2.添加title
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
    
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView).offset(10);
            make.bottom.equalTo(self.imageView).offset(-20);
            make.right.equalTo(self.imageView).offset(-10);
        }];
        
    }
    return self;
}

- (void)setImageViewWith:(NSString *)imageURLStr{
    
    
    // todo: 使用model的高清图，传递过来的太模糊
    NSURL *imageURL =  [NSURL URLWithString:imageURLStr];
    
    [_imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"Image_Preview"]];
}

-(void)setTitle:(NSString *)title{
    
     self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
