//
//  ContactListTableViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactListTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <JSBadgeView/JSBadgeView.h>
#import "ContactTableViewCell.h"
#import "AppModel.h"

static NSString *kCellImageKey = @"image";
static NSString *kCellBadgeKey = @"badge";
static NSString *kCellTextKey = @"text";
static NSString *kCellSelectorKey = @"selector";

@interface ContactListTableViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *headerSectionData;

@end

@implementation ContactListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ContactTableViewCell registerCellToTalbeView:self.tableView];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigation
- (void)goNewFriend:(id)sender {
    
}

#pragma mark - load data
- (void)refresh {
    [self refresh:nil];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self showProgress];
    [self findFriendsAndBadgeNumberWithBlock:^(NSArray *friends, NSInteger badgeNumber, NSError *error) {
        [self hideProgress];
        
        if (refreshControl != nil) {
            [refreshControl endRefreshing];
        }
        
        if (!error) {
            [self refreshWithFriends:friends badgeNumber:badgeNumber];
        }
    }];
}

- (void)findFriendsAndBadgeNumberWithBlock:(void (^)(NSArray *friends, NSInteger badgeNumber, NSError *error))friendsAndBadgeBlock {
    [[AppModel sharedInstance].userModel findFriendsWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            friendsAndBadgeBlock(nil, 0, error);
        } else {
            if (objects == nil) {
                objects = [NSMutableArray array];
            }
            [self countNewAddRequestBadge:^(NSInteger badgeNumber, NSError *error) {
                friendsAndBadgeBlock(objects, badgeNumber, error);
            }];
        }
    }];
}

- (void)countNewAddRequestBadge:(void (^)(NSInteger badgeNumber, NSError *error))badgeBlock {
    [[AppModel sharedInstance].userModel countUnreadAddRequestsWithBlock:^(NSInteger number, NSError *error) {
        if (error) {
            badgeBlock(0, error);
        } else {
            badgeBlock(number, nil);
        }
    }];
}

- (void)refreshWithFriends:(NSArray *)friends badgeNumber:(NSInteger)number{
    if (number > 0) {
        NSLog(@"==============badge number: %ld", number);
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", number];
    } else {
        self.tabBarItem.badgeValue = nil;
    }
    
    self.headerSectionData = [NSMutableArray array];
    [self.headerSectionData addObject:@{ kCellImageKey:[UIImage imageNamed:@"new_friends_icon"], kCellTextKey:@"新的朋友",kCellBadgeKey:@(number), kCellSelectorKey:NSStringFromSelector(@selector(goNewFriend:))}];
    
    self.dataSource = [friends mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.headerSectionData.count;
    } else {
        return self.dataSource.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"", @""][section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [@[@0, @14][section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [ContactTableViewCell createOrDequeueCellByTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    if (indexPath.section == 0) {
        static NSInteger kBadgeViewTag = 103;
        JSBadgeView *badgeView = (JSBadgeView *)[cell viewWithTag:kBadgeViewTag];
        if (badgeView) {
            [badgeView removeFromSuperview];
        }
        
        NSDictionary *cellData = self.headerSectionData[indexPath.row];
        [cell.myImageView setImage:cellData[kCellImageKey]];
        cell.myLabel.text = cellData[kCellTextKey];
        NSInteger badgeNumber = [cellData[kCellBadgeKey] integerValue];
        if (badgeNumber > 0) {
            badgeView = [[JSBadgeView alloc] initWithParentView:cell.myImageView alignment:JSBadgeViewAlignmentTopRight];
            badgeView.tag = kBadgeViewTag;
            badgeView.badgeText = [NSString stringWithFormat:@"%ld", badgeNumber];
        }
    } else {
        UserInfo *user = [self.dataSource objectAtIndex:indexPath.row];
        [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
        cell.myLabel.text = user.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    } else {
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"解除好友关系吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
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
