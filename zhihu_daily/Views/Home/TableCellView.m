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
        
        //1.添加名称
        self.titleLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview: self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        //2.添加缩略图
        
    }
    
    return self;
    
}

@end
