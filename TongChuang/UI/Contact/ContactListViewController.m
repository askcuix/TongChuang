//
//  ContactListTableViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <JSBadgeView/JSBadgeView.h>
#import "NewContactTableViewCell.h"
#import "ContactTableCell.h"
#import "AppModel.h"
#import "ViewUtil.h"
#import "ChatManager.h"
#import "NewContactViewController.h"
#import "ContactInfoViewController.h"

@interface ContactListViewController () <UIAlertViewDelegate> {
    JSBadgeView *_badgeView;
}

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, assign) NSInteger badgeNumber;
@property (nonatomic, strong) NSArray *groupData;
@property (nonatomic, strong) NSArray *circleData;

@end

@implementation ContactListViewController

- (instancetype)init {
    if ((self = [super init])) {
        self.title = @"人脉";
        
        [ViewUtil setNormalTabItem:self imageName:@"contact_normal.png"];
        [ViewUtil setSelectedTabItem:self imageName:@"contact_press.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NewContactTableViewCell registerCellToTableView:self.tableView];
    [ContactTableCell registerCellToTableView:self.tableView];
    
    [self.tableView addSubview:self.refreshControl];
    
    [self refresh];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _refreshControl;
}

- (void)refreshView {
    if (_badgeNumber > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", _badgeNumber];
    } else {
        self.tabBarItem.badgeValue = nil;
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigation
- (void)goNewFriend:(id)sender {
    NewContactViewController *controller = [[NewContactViewController alloc] init];
    controller.contactListController = self;
    
    [[self navigationController] pushViewController:controller animated:YES];
    
    self.tabBarItem.badgeValue = nil;
    if (_badgeView) {
        [_badgeView removeFromSuperview];
    }
}

#pragma mark - load data
- (void)refresh {
    [self refresh:nil];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self showProgress];
    
    WEAKSELF
    [self loadDataWithBlock:^(BOOL totalError, NSError *error) {
        [weakSelf hideProgress];
        
        if (refreshControl != nil) {
            [refreshControl endRefreshing];
        }
        
        if (!totalError) {
            [weakSelf refreshView];
        }
        
        if (error) {
            [weakSelf toast:@"数据更新错误"];
        }
    }];
}

- (void)loadDataWithBlock:(void (^)(BOOL totalError, NSError *error))dataBlock {
    __block NSError *loadError;
    __block NSInteger errorCount = 0;
    
    //获取人脉
    [self getFriendsWithBlock:^(NSError *error) {
        if (error) {
            errorCount++;
            loadError = error;
        }
    }];
    
    //获取新的人脉
    [self countNewAddRequestBadge:^(NSError *error) {
        if (error) {
            errorCount++;
            loadError = error;
        }
    }];
    
    //获取群
    [self getGroupsWithBlock:^(NSError *error) {
        if (error) {
            errorCount++;
            loadError = error;
        }
    }];
    
    //获取圈子
    [self getCirclesWithBlock:^(NSError *error) {
        if (error) {
            errorCount++;
            loadError = error;
        }
    }];
    
    BOOL totalError = errorCount == 4 ? YES : NO;
    dataBlock(totalError, loadError);
}

- (void)getFriendsWithBlock:(void (^)(NSError *error))friendsBlock {
    [[AppModel sharedInstance].userModel getFriendsWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"获取人脉列表失败：%@", error);;
            friendsBlock(error);
        } else {
            if (objects == nil) {
                objects = [NSMutableArray array];
            }
            
            self.dataSource = [objects mutableCopy];
            friendsBlock(nil);
        }
    }];
}

- (void)countNewAddRequestBadge:(void (^)(NSError *error))badgeBlock {
    [[AppModel sharedInstance].userModel countUnreadAddRequestsWithBlock:^(NSInteger number, NSError *error) {
        if (error) {
            NSLog(@"获取新的人脉数量失败：%@", error);
            badgeBlock(error);
        } else {
            self.badgeNumber = number;
            badgeBlock(nil);
        }
    }];
}

- (void)getGroupsWithBlock:(void (^)(NSError *error))groupsBlock {
    [[ChatManager manager] findGroupedConvsWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"获取群列表失败：%@", error);
            groupsBlock(error);
        } else {
            if (objects == nil) {
                objects = [NSArray array];
            }
            
            self.groupData = objects;
            groupsBlock(nil);
        }
    }];
}

- (void)getCirclesWithBlock:(void (^)(NSError *error))circlesBlock {
    [[AppModel sharedInstance].circleModel getCirclesWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"获取圈子列表失败：%@", error);
            circlesBlock(error);
        } else {
            if (objects == nil) {
                objects = [NSArray array];
            }
            
            self.circleData = objects;
            circlesBlock(nil);
        }
    }];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.groupData.count;
    } else if (section == 2) {
        return self.circleData.count;
    } else {
        return self.dataSource.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"", @"我的群", @"我的圈子", @"我的好友"][section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewContactTableViewCell *cell = [NewContactTableViewCell createOrDequeueCellByTableView:tableView];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        [cell.iconImgView setImage:[UIImage imageNamed:@"new_friends_icon"]];
        [cell.titleLabel setText:@"新的人脉"];
        
        if (_badgeView) {
            [_badgeView removeFromSuperview];
        }
        
        if (_badgeNumber > 0) {
            _badgeView = [[JSBadgeView alloc] initWithParentView:cell.iconImgView alignment:JSBadgeViewAlignmentTopRight];
            _badgeView.badgeText = [NSString stringWithFormat:@"%ld", _badgeNumber];
        }
        
        return cell;
    } else if (indexPath.section == 1) {
        AVIMConversation *conv = [self.groupData objectAtIndex:indexPath.row];
        
        ContactTableCell *cell = [ContactTableCell createOrDequeueCellByTableView:tableView];
        [cell.avatarImgView setImage:conv.icon];
        [cell.nameLabel setText:conv.title];
        [cell.detailLabel setText:@"2015级3班群"];
        [cell setRoundImageStyle];
        
        return cell;
    } else if (indexPath.section == 2) {
        CircleInfo *circle = [self.circleData objectAtIndex:indexPath.row];
        
        ContactTableCell *cell = [ContactTableCell createOrDequeueCellByTableView:tableView];
        [cell.avatarImgView setImage:[UIImage imageNamed:@"group_icon"]];
        [cell.nameLabel setText:circle.name];
        [cell.detailLabel setText:nil];
        [cell setRoundImageStyle];
        
        return cell;
    } else {
        UserInfo *user = [self.dataSource objectAtIndex:indexPath.row];
        
        ContactTableCell *cell = [ContactTableCell createOrDequeueCellByTableView:tableView];
        [cell.avatarImgView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
        [cell.nameLabel setText:user.name];
        [cell.detailLabel setText:user.schoolName];
        [cell setRoundImageStyle];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        view = nil;
    } else {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        header.textLabel.font = [UIFont systemFontOfSize:12];
        header.textLabel.textColor = [UIColor darkGrayColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self performSelector:@selector(goNewFriend:) withObject:nil afterDelay:0];
    } else if (indexPath.section == 1) {
        
    } else if (indexPath.section == 2) {
        
    } else {
        ContactInfoViewController *contactInfoController = [ControllerManager viewControllerInMainStoryboard:@"ContactInfoViewController"];
        contactInfoController.user = [self.dataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:contactInfoController animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = indexPath.row;
        [alertView show];
    }
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UserInfo *user = [self.dataSource objectAtIndex:alertView.tag];
        
        [self showProgress];
        
        [[AppModel sharedInstance].userModel removeFriend:user callback:^(BOOL succeeded, NSError *error) {
            [self hideProgress];
            
            if (!error) {
                [self.dataSource removeObjectAtIndex:alertView.tag];
                [self.tableView reloadData];
            }
        }];
        
    }
}

@end
