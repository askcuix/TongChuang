//
//  RecommendListViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendListViewController.h"
#import "ControllerManager.h"
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
    for (int i = 1; i < 4; i++) {
        GroupInfo *groupInfo = [[GroupInfo alloc] init];
        groupInfo.gid = i;
        groupInfo.name = [NSString stringWithFormat:@"同学群%d", i];
        [_groupList addObject:groupInfo];
    }
    
    _circleList = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        CircleInfo *circleInfo = [[CircleInfo alloc] init];
        circleInfo.cid = i;
        circleInfo.name = [NSString stringWithFormat:@"圈子%d", i];
        [_circleList addObject:circleInfo];
    }
    
    _personList = [NSMutableArray array];
    for (int i = 1; i < 11; i++) {
        UserInfo *person = [[UserInfo alloc] init];
        person.uid = i;
        person.name = [NSString stringWithFormat:@"同学%d", i];
        person.avatarUrl = @"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg";
        person.schoolName = [NSString stringWithFormat:@"学校%d", i];
        [_personList addObject:person];
    }
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
        return groupCell;
    } else if (indexPath.section == 1) {
        CircleInfo *circleInfo = _circleList[indexPath.row];
        RecommendCircleTableCell *circleCell = [tableView dequeueReusableCellWithIdentifier:RecommendCircleTableIdentifier];
        [circleCell setCircleInfo:circleInfo];
        return circleCell;
    }
    
    UserInfo *person = _personList[indexPath.row];
    RecommendPersonTableCell *personCell = [tableView dequeueReusableCellWithIdentifier:RecommendPersonTableIdentifier];
    [personCell setPersonInfo:person];
    return personCell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // 设置section的背景色
    view.tintColor = [UIColor lightGrayColor];
    
    // 设置section文字颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor darkGrayColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 80;
    }
    
    return 50;
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
@end
