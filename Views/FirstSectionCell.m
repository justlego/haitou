//
//  FirstSectionCell.m
//  haitou
//
//  Created by apple on 15/10/22.
//  Copyright © 2015年 divein. All rights reserved.
//

#import "FirstSectionCell.h"

@implementation FirstSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_contentLabel];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    selected = NO;
}

@end
