//
//  FaceTableViewCell.m
//  haitou
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 divein. All rights reserved.
//

#import "FaceTableViewCell.h"


@implementation FaceTableViewCell
{
    CGSize size;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        size = self.bounds.size;
        
        [self addTitleLabel];
        [self addTextView];
        [self addYearLabel];
        [self addCompanyLabel];
        [self addImageView];
        [self addReadImageView];
        [self addReadCountLabel];
        [self addGoodImageView];
        [self addGoodCountLabel];
    }
    return self;
}


- (void)addTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, size.width, 20)];
    [self.contentView addSubview:_titleLabel];
}

- (void)addTextView
{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 40, size.width-70, 45)];
    _textView.font = [UIFont systemFontOfSize:10];
    _textView.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.6];
    _textView.scrollEnabled = NO;
    [self.contentView addSubview:_textView];

}

- (void)addYearLabel
{
    _yearLabel = [[UILabel alloc] initWithFrame:(CGRect){20,90,30,20}];
    _yearLabel.font = [UIFont systemFontOfSize:10];
    _yearLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_yearLabel];
}

- (void)addCompanyLabel
{
    _companyLabel = [[UILabel alloc] initWithFrame:(CGRect){50,90,size.width-180,20}];
    _companyLabel.font = [UIFont systemFontOfSize:10];
    _companyLabel.textAlignment = NSTextAlignmentLeft;
    _companyLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_companyLabel];
}

- (void)addImageView
{
    _imgView = [[UIImageView alloc] initWithFrame:(CGRect){size.width-50,40,65,65}];
    [self.contentView addSubview:_imgView];

}

- (void)addReadImageView
{
    _readImageView = [[UIImageView alloc] initWithFrame:(CGRect){size.width-135,90,20,20}];
    [self.contentView addSubview:_readImageView];

}

- (void)addReadCountLabel
{
    _readCountLabel = [[UILabel alloc] initWithFrame:(CGRect){size.width-115,90,20,20}];
    _readCountLabel.font = [UIFont systemFontOfSize:8];
    _readCountLabel.textColor = [UIColor blueColor];
    _readCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_readCountLabel];
}

- (void)addGoodImageView
{
    _goodImageView = [[UIImageView alloc] initWithFrame:(CGRect){size.width-95,90,20,20}];
    [self.contentView addSubview:_goodImageView];
}

- (void)addGoodCountLabel
{
    _goodCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width-75, 90, 20, 20)];
    _goodCountLabel.font = [UIFont systemFontOfSize:8];
    _goodCountLabel.textColor = [UIColor blueColor];
    _goodCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_goodCountLabel];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
