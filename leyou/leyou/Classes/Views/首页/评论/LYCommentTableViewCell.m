//
//  LYCommentTableViewCell.m
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYCommentTableViewCell.h"
#import "UIFont+DefaultFont.h"
#import "UIColor+DefaultColor.h"
#import <Masonry.h>
#import "CommonMarco.h"
#import <YYWebImage.h>
#import "LYRouteManager.h"
#import "LYReplyViewController.h"
@interface LYCommentTableViewCell()
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIButton *replyBtn;
@end
@implementation LYCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    _headImg = [UIImageView new];
    _headImg.layer.cornerRadius = 3 * kSCREEN_WRATE;
    _headImg.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _userNameLabel = [UILabel new];
    _userNameLabel.font = [UIFont getSupFont];
    _userNameLabel.textColor = [UIColor getTitleColor];
    _userNameLabel.text = @"tttt";
    [self.contentView addSubview:_userNameLabel];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont getSupFont];
    _timeLabel.textColor = [UIColor getSubTextColor];
    [self.contentView addSubview:_timeLabel];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeBtn addTarget:self action:@selector(likeComment:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn setImage:[UIImage imageNamed:@"like_gary"] forState:UIControlStateNormal];
    [_likeBtn setImage:[UIImage imageNamed:@"like_blue"] forState:UIControlStateSelected];
    [self.contentView addSubview:_likeBtn];
    
    _likeLabel = [UILabel new];
    _likeLabel.font = [UIFont getSupFont];
    _likeLabel.textColor = [UIColor getSubTextColor];
    [self.contentView addSubview:_likeLabel];
    
    _replyLabel = [UILabel new];
    _replyLabel.font = [UIFont getSupFont];
    _replyLabel.textColor = [UIColor getSubTextColor];
    [self.contentView addSubview:_replyLabel];
    
    _replyBtn = [UIButton new];
    [_replyBtn addTarget:self action:@selector(jumpToReplyList) forControlEvents:UIControlEventTouchUpInside];
    [_replyBtn setImage:[UIImage imageNamed:@"reply_"] forState:UIControlStateNormal];
    [self.contentView addSubview:_replyBtn];

    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont getSubFont];
    _contentLabel.textColor = [UIColor getMainTextColor];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor getBgColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(1);
        make.left.right.mas_offset(0);
        make.top.offset(0);
    }];
}

- (void)layoutSubviews{
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10 * kSCREEN_WRATE);
        make.size.mas_offset(CGSizeMake(40 * kSCREEN_HRATE, 40 * kSCREEN_HRATE));
        make.top.mas_equalTo(10 * kSCREEN_HRATE);
        
    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImg.mas_right).offset(10 * kSCREEN_WRATE);
        make.top.equalTo(self.headImg);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5 * kSCREEN_WRATE);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30 * kSCREEN_WRATE, 30 * kSCREEN_WRATE));
        make.top.equalTo(self.userNameLabel);
        make.left.mas_offset(250 * kSCREEN_WRATE);
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeBtn);
        make.left.equalTo(self.likeBtn.mas_right).offset(5 * kSCREEN_WRATE);
    }];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(30 * kSCREEN_WRATE, 30 * kSCREEN_WRATE));
        make.centerY.equalTo(self.likeBtn);
        make.left.equalTo(self.likeLabel.mas_right).offset(5 * kSCREEN_WRATE);
    }];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeBtn);
        make.left.equalTo(self.replyBtn.mas_right).offset(5 * kSCREEN_WRATE);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(8 * kSCREEN_HRATE);
        make.right.mas_offset(-20 * kSCREEN_WRATE);
    }];
    [super layoutSubviews];
    
}

#pragma mark - Event -

- (void)likeComment:(UIButton *)sender{
    sender.selected = !sender.selected;
    UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
    [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
        sender.layer.affineTransform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:op animations:^{
             sender.layer.affineTransform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
                sender.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
            } completion:NULL];
        }];
    }];
    NSInteger likes = [self.model.likes integerValue];;
    if (sender.selected) {
        likes++;
    }else{
        likes--;
    }
    self.model.likes = @(likes);
    AVObject *todo =[AVObject objectWithClassName:@"Comments" objectId:self.model.objectId];
    // 修改属性
    [todo setObject:self.model.likes forKey:@"likes"];
    // 保存到云端
    [todo saveInBackground];
    self.likeLabel.text = [self.model.likes stringValue];
}

- (void)jumpToReplyList{
    //到回复列表
    NSLog(@"到回复列表");
    LYReplyViewController *vc = [[LYReplyViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"@%@",self.model.user.nickName];
    [LRM pushViewController:vc];
}

#pragma mark - setter -
- (void)setModel:(LYComment *)model{
    if (_model == model) {
        return;
    }
    _model = model;

    AVQuery *userQuery = [AVQuery queryWithClassName:model.user.className];
    [userQuery getObjectInBackgroundWithId:model.user.objectId block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        _model.user = (LYUser *)object;
        self.headImg.yy_imageURL = [NSURL URLWithString:_model.user.headImage.url];
        self.userNameLabel.text = _model.user.nickName;
    }];
    self.headImg.yy_imageURL = [NSURL URLWithString:model.user.headImage.url];
    //self.userNameLabel.text = model.user.nickName;
    self.timeLabel.text = model.time;
    self.likeLabel.text = [model.likes stringValue];
    self.contentLabel.text = model.content;
    AVQuery *query = [[model relationForKey:@"replies"] query];
    WS(weakself);
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            NSMutableArray *arr = [@[] mutableCopy];
            [objects enumerateObjectsUsingBlock:^(LYReply *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [arr addObject:obj];
            }];
            weakself.replies = arr;
            weakself.replyLabel.text = [NSString stringWithFormat:@"%ld",arr.count];
         
        }
    }];    
}
@end
