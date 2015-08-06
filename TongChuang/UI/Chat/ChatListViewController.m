//
//  ChatListViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/21.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatListViewController.h"
#import "ChatListTableViewCell.h"

static NSString *ChatListTableIdentifier = @"ChatListTableIdentifier";

@interface ChatListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *nib = [UINib nibWithNibName:@"ChatListCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:ChatListTableIdentifier];
    
    //设置tab bar图标新消息数量提示
    UITabBarItem * item = [self.tabBarController.tabBar.items objectAtIndex:0];
    item.badgeValue= [NSString stringWithFormat:@"%d",1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatListTableIdentifier forIndexPath:indexPath];
    cell.title = @"Chris";
    cell.chatImg = [UIImage imageNamed:@"avatar.png"];
    cell.latestMsg = @"您有新消息来啦。。。。。。。";
    cell.latestMsgDate = [NSDate date];
    
    if (indexPath.row == 0) {
        cell.msgNotifyCount = 1;
    }
    
    [cell renderCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
