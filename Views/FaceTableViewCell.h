//
//  FaceTableViewCell.h
//  haitou
//
//  Created by apple on 15/10/12.
//  Copyright © 2015年 divein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceTableViewCell : UITableViewCell
@property (nonatomic,strong,readonly) UILabel *titleLabel;
@property (nonatomic,strong,readonly) UILabel *contentLabel;
@property (nonatomic,strong,readonly) UILabel *yearLabel;
@property (nonatomic,strong,readonly) UILabel *companyLabel;
@property (nonatomic,strong,readonly) UIImageView *imgView;
@property (nonatomic,strong,readonly) UIImageView *readImageView;
@property (nonatomic,strong,readonly) UIImageView *goodImageView;
@property (nonatomic,strong,readonly) UILabel *readCountLabel;
@property (nonatomic,strong,readonly) UILabel *goodCountLabel;

@end
