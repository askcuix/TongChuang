//
//  RecommendListViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendListViewController.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "ControllerManager.h"
#import "AppModel.h"
#import "RecommendGroupTableCell.h"
#import "RecommendCircleTableCell.h"
#import "RecommendPersonTableCell.h"

static NSString *RecommendGroupTableIdentifier = @"RecommendGroupTableViewCell";
static NSString *RecommendCircleTableIdentifier = @"RecommendCircleTableViewCell";
static NSString *RecommendPersonTableIdentifier = @"RecommendPersonTableViewCell";

@interface RecommendListViewController () {
    NSMutableArray *_groupList;
    NSMutableArray *_circleList;
    NSMutableArray *_personList;
}

- (IBAction)doneBtnClick:(UIBarButtonItem *)sender;

@end

@implementation RecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    // Do any additional setup after loading the view.
    _groupList = [NSMutableArray array];
    for (int i = 1; i < 2; i++) {
        GroupInfo *groupInfo = [[GroupInfo alloc] init];
        groupInfo.gid = i;
        groupInfo.name = [NSString stringWithFormat:@"广东财经大学 法律"];
        groupInfo.info = [NSString stringWithFormat:@"2014级3班"];
        groupInfo.degree = Bachelor;
        [_groupList addObject:groupInfo];
    }
    
    _circleList = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        CircleInfo *circleInfo = [[CircleInfo alloc] init];
        circleInfo.cid = i;
        circleInfo.name = [NSString stringWithFormat:@"广东财经大学 法律"];
        circleInfo.info = @"2014级圈子";
        circleInfo.degree = Master;
        [_circleList addObject:circleInfo];
    }
    
    [[AppModel sharedInstance].userModel getFriendsWithBlock:^(NSArray *objects, NSError *error) {
        _personList = [objects mutableCopy];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_groupList count];
    } else if (section == 1) {
        return [_circleList count];
    }

    return [_personList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"为你找到的群";
    } else if (section == 1) {
        return @"为你找到的圈子";
    }
    
    return @"为你找到的同学";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GroupInfo *groupInfo = _groupList[indexPath.row];
        RecommendGroupTableCell *groupCell = [tableView dequeueReusableCellWithIdentifier:RecommendGroupTableIdentifier];
        [groupCell setGroupInfo:groupInfo];
        [groupCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return groupCell;
    } else if (indexPath.section == 1) {
        CircleInfo *circleInfo = _circleList[indexPath.row];
        RecommendCircleTableCell *circleCell = [tableView dequeueReusableCellWithIdentifier:RecommendCircleTableIdentifier];
        [circleCell setCircleInfo:circleInfo];
        [circleCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return circleCell;
    }
    
    UserInfo *person = _personList[indexPath.row];
    RecommendPersonTableCell *personCell = [tableView dequeueReusableCellWithIdentifier:RecommendPersonTableIdentifier];
    [personCell setPersonInfo:person];
    [personCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return personCell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // 设置section的背景色
    view.tintColor = UIColorHex(@"#f5f5f5");
    
    // 设置section文字颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:UIColorHex(@"#5b5b5b")];
    [header.textLabel setFont:[UIFont systemFontOfSize:13]];
    
    if (section == 2) {
        if ([_personList count] > 0) {
            UIButton *addAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(tableView.width - 65 - 15, 8, 65, 25)];
            
            [addAllBtn setBorderWidth:1];
            [addAllBtn setBorderColor:UIColorHex(@"#a1a1a1")];
            [addAllBtn setCornerRadius:4 maskToBounds:YES];
            [addAllBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            [addAllBtn setTitle:@"一键添加" forState:UIControlStateNormal];
            [addAllBtn setTitleColor:UIColorHex(@"#46a5e3") forState:UIControlStateNormal];
            [addAllBtn addTarget:self action:@selector(addAllRecommendPerson) forControlEvents:UIControlEventTouchUpInside];
            
            [header.textLabel setFrame:CGRectMake(15, 22, tableView.width - addAllBtn.width - 15 - 15 * 2, [self tableView:tableView heightForHeaderInSection:section] - 22)];
            
            [header addSubview:addAllBtn];
        } else {
            [header.textLabel setFrame:CGRectMake(15, 22, tableView.width - 15 * 2, [self tableView:tableView heightForHeaderInSection:section] - 22)];
        }
    } else {
        [header.textLabel setFrame:CGRectMake(15, 7, tableView.width - 15 * 2, [self tableView:tableView heightForHeaderInSection:section] - 7)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - action
- (IBAction)doneBtnClick:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[ControllerManager sharedInstance] presentMainView];
    }];
}

- (void) addAllRecommendPerson {
    
}
@end
