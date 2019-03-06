//
//  TableCellView.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/6.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import "TableCellView.h"

@implementation TableCellView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        //1.添加缩略图
        self.imgView = [[UIImageView alloc] init];
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        self.imgView.clipsToBounds = YES;
        
        [self.contentView addSubview: self.imgView];
        
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 60));
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
        //2.添加名称
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview: self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.imgView);
            make.right.equalTo(self.imgView.mas_left).offset(-10);
        }];
        
        //3.添加分割线
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.f];
        [self.contentView addSubview:divider];
        [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    return self;
    
}

@end
