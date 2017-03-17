//
//  LYCommentsViewController.m
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYCommentsViewController.h"
#import "LYCommentTableViewCell.h"
#import "NSString+Extension.h"
#import <MJRefresh.h>
NSString *const kAllCommentIdentifier = @"kAllCommentIdentifier";
@interface LYCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger skip;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LYCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupDataSources{
    _skip = 0;
}

- (void)setupViews{
    self.title = @"评论";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
}

- (void)loadDataSources:(BOOL)isDown{
    [SVProgressHUD showWithStatus:@"加载中"];
    AVQuery *query = [self.relation query];
    query.limit = 10;
    if (isDown) {
        query.skip = 0;
    }else{
        query.skip = self.skip;
    }
    WS(weakself);
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        [weakself.tableView.mj_footer endRefreshing];
        [weakself.tableView.mj_header endRefreshing];
        if (!error) {
            if (!isDown) {
                weakself.skip += 10;
            }
            NSMutableArray *mcomments;
            if (isDown) {
                mcomments = [@[] mutableCopy];
            }else{
                mcomments = [self.comments mutableCopy];
            };
        [objects enumerateObjectsUsingBlock:^(LYComment *comment, NSUInteger idx, BOOL * _Nonnull stop) {
            [mcomments addObject:comment];
        }];
        weakself.comments = mcomments;
        [weakself.tableView reloadData];
      }
    }];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAllCommentIdentifier];
    if (!cell) {
        cell = [[LYCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAllCommentIdentifier];
    }
    cell.model = self.comments[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [self.comments[indexPath.row].content clacTextHeight:[UIFont getSubFont] width:SCREEN_WIDTH - 80];
    return 65 + height;
}


#pragma mark - Event -
- (void)refreshDataSource{
    [self loadDataSources:YES];
}

- (void)loadMoreDataSource{
    [self loadDataSources:NO];
}

#pragma mark - Lazy -
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshDataSource];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreDataSource];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 80 * kSCREEN_HRATE;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end
