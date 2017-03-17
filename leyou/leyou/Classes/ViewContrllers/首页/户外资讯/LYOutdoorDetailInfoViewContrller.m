

//
//  LYOutdoorDetailInfoViewContrller.m
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYOutdoorDetailInfoViewContrller.h"
#import "LYCommentTableViewCell.h"
#import <UIView+YYAdd.h>
#import "LYOutdoorInfoModel.h"
#import <YYWebImageManager.h>
#import <YYWebImage.h>
#import "LYComment.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "NSString+Extension.h"
#import "LYCommentsViewController.h"
NSString *const kCommentCellIdentifier = @"kCommentCellIdentifier";
@interface LYOutdoorDetailInfoViewContrller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<LYComment *> *comments;
@property (nonatomic, strong) LYOutdoorInfoModel *model;
@end

@implementation LYOutdoorDetailInfoViewContrller

#pragma mark - init -

- (instancetype)initWithOutdoorDetaInfo:(LYOutdoorInfoModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)setupDataSources{
    [SVProgressHUD showWithStatus:@"加载中"];
    AVQuery *query = [[self.model relationForKey:@"comments"] query];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        NSMutableArray *mcomments = [@[] mutableCopy];
        [objects enumerateObjectsUsingBlock:^(LYComment *comment, NSUInteger idx, BOOL * _Nonnull stop) {
            [mcomments addObject:comment];
        }];
        self.comments = mcomments;
        [self.tableView reloadData];
    }];
}

- (void)setupViews{
    self.title = @"详情";
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [btn setTitle:@"更多跟帖" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor getMainColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont getSubFont];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn addTarget:self action:@selector(jumpAllCommentList) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    _imageView = [YYAnimatedImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.tableView];
    self.imageView.yy_imageURL = [NSURL URLWithString:self.model.image.url];
    self.contentLabel.text = self.model.content;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}
#pragma mark - Life -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model.views = @([self.model.views integerValue] + 1);
    AVObject *update =[AVObject objectWithClassName:self.model.className objectId:self.model.objectId];
    // 修改属性
    [update setObject:self.model.views forKey:@"views"];
    // 保存到云端
    [update saveInBackground];
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count > 5?5:self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifier];
    cell.model = self.comments[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [self.comments[indexPath.row].content clacTextHeight:[UIFont getSubFont] width:SCREEN_WIDTH - 80];
    return 65 + height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat textH =  [self.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size.height;
    return 240 * kSCREEN_HRATE + textH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 65 * kSCREEN_HRATE;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(jumpAllCommentList) forControlEvents:UIControlEventTouchUpInside];
    if(self.comments.count < 5){
        [btn setTitle:@"暂时没有更多跟帖，快来发布吧~" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"更多跟帖" forState:UIControlStateNormal];
    }
    btn.layer.cornerRadius = 3 * kSCREEN_WRATE;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:[UIColor getMainColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont getSubFont];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.borderColor = [UIColor getMainColor].CGColor;
    btn.layer.borderWidth = 1;
    [view addSubview:btn];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor getBgColor];
    [view addSubview:lineView];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45 * kSCREEN_HRATE);
        make.centerY.equalTo(view);
        make.left.mas_equalTo(35 * kSCREEN_WRATE);
        make.right.mas_equalTo(-35 * kSCREEN_WRATE);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.top.mas_equalTo(0);
    }];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.mainView;
}

#pragma mark - Event -

- (void)jumpAllCommentList{
    NSLog(@"跳转到所有评论");
    LYCommentsViewController *vc = [[LYCommentsViewController alloc] init];
    vc.comments = self.comments;
    vc.relation = [self.model relationForKey:@"comments"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - lazy -
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerClass:[LYCommentTableViewCell class] forCellReuseIdentifier:kCommentCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 80 * kSCREEN_HRATE;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIView *)mainView{
    if (!_mainView) {
        CGFloat height = 250 * kSCREEN_HRATE;
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, height)];
        _mainView.backgroundColor = [UIColor whiteColor];
        [_mainView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10 * kSCREEN_WRATE);
            make.right.mas_equalTo(- 10 * kSCREEN_WRATE);
            make.top.mas_equalTo(10 * kSCREEN_HRATE);
            make.height.mas_equalTo(200 * kSCREEN_HRATE);
        }];
        [_mainView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).offset(10 * kSCREEN_HRATE);
            make.left.mas_equalTo(10 * kSCREEN_WRATE);
            make.right.mas_equalTo(- 10 * kSCREEN_WRATE);
        }];
    }
    return _mainView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont getSubFont];
        _contentLabel.textColor = [UIColor getMainTextColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end
