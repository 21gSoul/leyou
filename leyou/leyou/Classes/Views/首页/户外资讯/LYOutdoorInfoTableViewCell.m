//
//  LYOutdoorInfoTableViewCell.m
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYOutdoorInfoTableViewCell.h"
#import "LYOutdoorInfoModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface LYOutdoorInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;

@end
@implementation LYOutdoorInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LYOutdoorInfoModel *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[model.image getThumbnailURLWithScaleToFit:YES width:70 height:70]]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image.url] placeholderImage:[UIImage imageWithData:imageData]];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.intro;
    self.viewsLabel.text = [model.views stringValue];
}

@end
