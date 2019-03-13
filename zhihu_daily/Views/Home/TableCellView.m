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
            make.size.mas_equalTo(CGSizeMake(80, 60));
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
        
        //3.添加是否多图说明
        self.morePicView = [[UIImageView alloc] init];
        self.morePicView.contentMode = UIViewContentModeScaleAspectFill;
        self.morePicView.clipsToBounds = YES;
        [self.contentView addSubview: self.morePicView];
        [self.morePicView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.right.equalTo(self.imgView);
            make.bottom.equalTo(self.imgView);
        }];
        
    }
    
    return self;
    
}

@end
