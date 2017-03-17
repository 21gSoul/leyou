//
//  LYOutdoorInfoViewController.m
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYOutdoorInfoViewController.h"
#import "LYOutdoorInfoTableViewCell.h"
#import "LYOutdoorDetailInfoViewContrller.h"
#import <SDCycleScrollView.h>
#import "LYOutdoorInfoModel.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <MJRefresh.h>
NSString *const kCellIdentifier = @"OutdoorInfoTableViewCell";

@interface LYOutdoorInfoViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *outdoorInfos;
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, assign) NSInteger skip;
@end

@implementation LYOutdoorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)setupDataSources{
    _outdoorInfos = [NSArray new];
    _skip = 0;
    [self loadDataSources:YES];
    
}

- (void)setupViews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
}

- (void)loadDataSources:(BOOL)isDown{
    AVQuery *query = [AVQuery queryWithClassName:@"OutdoorsInfo"];
    query.limit = 10;
    [query whereKey:@"label" equalTo:self.outdoorType];
    [SVProgressHUD showWithStatus:@"加载中"];
    self.loading = YES;
    if (!isDown) {
        query.skip = self.skip;
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.loading = NO;
        if (!error) {
            if (!isDown) {
                self.skip += 10;
            }
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            NSMutableArray *models;
            if (isDown) {
                models = [@[] mutableCopy];
            }else{
                models = [self.outdoorInfos mutableCopy];
            }
            [objects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LYOutdoorInfoModel *model = (LYOutdoorInfoModel *)obj;
                [models addObject:model];
            }];
            self.outdoorInfos = models;
            [self dealWithDataSources];
        }else{
            self.tableView.emptyDataSetDelegate = self;
            self.tableView.emptyDataSetSource = self;
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            [self.tableView reloadEmptyDataSet];
        }
    }];
}


- (void)dealWithDataSources{
    NSMutableArray *titles = [@[] mutableCopy];
    NSMutableArray *imageUrl = [@[] mutableCopy];
    NSInteger count = self.outdoorInfos.count;
    NSInteger idx = -1;
    for (int i = 0; i < 3; i++) {
        NSInteger currentIdx;
        while (YES) {
            currentIdx = arc4random() % count;
            if (idx != currentIdx) {
                idx = currentIdx;
                break;
            }
        }
        LYOutdoorInfoModel *Model = self.outdoorInfos[idx];
        [titles addObject:Model.title];
        [imageUrl addObject:Model.image.url];
    }
    self.headerView.titlesGroup = titles;
    self.headerView.imageURLStringsGroup = imageUrl;
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.outdoorInfos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYOutdoorInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.outdoorInfos[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself);
    CGFloat height =[tableView fd_heightForCellWithIdentifier:kCellIdentifier configuration:^(id cell) {
        LYOutdoorInfoTableViewCell *oudoorCell = (LYOutdoorInfoTableViewCell *)cell;
        oudoorCell.model = weakself.outdoorInfos[indexPath.row];
    }];
    NSLog(@"height:%.2f",height);
    return height >= 95 ? height:95;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150 * kSCREEN_HRATE;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LYOutdoorInfoModel *model = self.outdoorInfos[indexPath.row];
    LYOutdoorDetailInfoViewContrller *vc = [[LYOutdoorDetailInfoViewContrller alloc] initWithOutdoorDetaInfo:model];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate -
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
    LYOutdoorDetailInfoViewContrller *vc = [[LYOutdoorDetailInfoViewContrller alloc] initWithOutdoorDetaInfo:[self findOutdoorInfo:cycleScrollView.titlesGroup[index]]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Event -
- (void)refreshDataSource{
    [self loadDataSources:YES];
}

- (void)loadMoreDataSource{
    [self loadDataSources:NO];
}
#pragma mark - prvate -
- (LYOutdoorInfoModel *)findOutdoorInfo:(NSString *)title{
    for (LYOutdoorInfoModel *model in self.outdoorInfos) {
        if ([title isEqualToString:model.title]) {
            return model;
        }
    }
    return nil;
}

#pragma mark - Lazy -

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refreshDataSource];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreDataSource];
        }];
        [_tableView registerNib:[UINib nibWithNibName:@"LYOutdoorInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (SDCycleScrollView *)headerView{
    if (!_headerView) {
        _headerView = [[SDCycleScrollView alloc] init];;
        _headerView.delegate = self;
        _headerView.placeholderImage = [UIImage imageNamed:@""];
        _headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _headerView;
}

- (void)setLoading:(BOOL)loading{
    [super setLoading:loading];
    [self.tableView reloadEmptyDataSet];
}

@end
