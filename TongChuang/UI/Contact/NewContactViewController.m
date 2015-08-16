//
//  NewContactViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "NewContactViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppModel.h"
#import "RecommednTableCell.h"
#import "ChatPushManager.h"
#import "ContactInfoViewController.h"

@interface NewContactViewController ()

@property (nonatomic, assign) BOOL needRefreshFriendListVC;

@end

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新的人脉";
    
    [RecommednTableCell registerCellToTableView:self.tableView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self refresh:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.needRefreshFriendListVC) {
        [self.contactListController refresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self showProgress];
    
    WEAKSELF
    [[AppModel sharedInstance].userModel findAddRequestsWithBlock:^(NSArray *objects, NSError *error) {
        [weakSelf hideProgress];
        
        if (refreshControl) {
            [refreshControl endRefreshing];
        }
        
        if (error) {
            NSLog(@"获取新的人脉失败：%@", error);
            [weakSelf toast:@"获取数据失败"];
        } else {
            [weakSelf showProgress];
            
            [[AppModel sharedInstance].userModel markAddRequestsRead:objects block:^(BOOL succeeded, NSError *error) {
                [weakSelf hideProgress];
                
                if (error) {
                    NSLog(@"标记新的人脉为已读失败：%@", error);
                } else if (objects.count > 0) {
                    weakSelf.needRefreshFriendListVC = YES;
                }
                
                weakSelf.dataSource = [objects mutableCopy];
                [weakSelf.tableView reloadData];
            }];
            
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"系统为你找到以下人脉";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:12];
    header.textLabel.textColor = [UIColor darkGrayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfo *user = [self.dataSource objectAtIndex:indexPath.row];
    
    RecommednTableCell *cell = [RecommednTableCell createOrDequeueCellByTableView:tableView];
    [cell.avatarImgView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    [cell.nameLabel setText:user.name];
    [cell.detailLabel setText:user.schoolName];
    [cell setRoundStyle];
    [cell.actionBtn setTag:user.uid];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    if (indexPath.row < 3) {
        [cell.actionBtn setTitle:@"接受" forState:UIControlStateNormal];
        [cell.actionBtn setBackgroundColor:[UIColor blueColor]];
        [cell.actionBtn addTarget:self action:@selector(acceptBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [cell.actionBtn setTitle:@"添加" forState:UIControlStateNormal];
        [cell.actionBtn setBackgroundColor:[UIColor lightGrayColor]];
        [cell.actionBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactInfoViewController *contactInfoController = [ControllerManager viewControllerInMainStoryboard:@"ContactInfoViewController"];
    contactInfoController.user = [self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:contactInfoController animated:YES];
}

#pragma mark - action
- (void)acceptBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    [self showProgress];
    WEAKSELF
    [[AppModel sharedInstance].userModel agreeAddRequest:btn.tag callback:^(BOOL succeeded, NSError *error) {
        [weakSelf hideProgress];
        
        if (error) {
            NSLog(@"接受好友请求错误：%@", error);
            [weakSelf toast:@"添加好友失败"];
        } else {
            [weakSelf showProgress];
            [[ChatManager manager] sendWelcomeMessageToOther:[NSString stringWithFormat:@"%ld", btn.tag] text:@"我们已经是好友了，来聊天吧" block:^(BOOL succeeded, NSError *error) {
                [weakSelf hideProgress];
                [weakSelf toast:@"添加成功"];
                [weakSelf refresh:nil];
            }];
        }
    }];
}

- (void)addBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
    [self showProgress];
    
    WEAKSELF
    [[AppModel sharedInstance].userModel addUser:btn.tag callback:^(BOOL succeeded, NSError *error) {
        [weakSelf hideProgress];
        
        if (error) {
            NSLog(@"发送添加好友请求失败：%@", error);
            [weakSelf toast:@"添加失败"];
        } else {
            [weakSelf showProgress];
            
            NSString *text = [NSString stringWithFormat:@"%@ 申请加你为好友", [[AppModel sharedInstance].loginModel account]];
            [[ChatPushManager manager] pushMessage:text userIds:@[[NSString stringWithFormat:@"%ld", btn.tag]] block:^(BOOL succeeded, NSError *error) {
                [weakSelf hideProgress];
                
                if (error) {
                    NSLog(@"推送添加好友请求失败：%@", error);
                } else {
                    [weakSelf toast:@"申请成功"];
                }
            }];
        }
    }];
}

@end
