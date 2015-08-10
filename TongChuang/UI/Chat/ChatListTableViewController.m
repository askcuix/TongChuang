//
//  ChatListTableViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatListTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DateTools/DateTools.h>
#import "ConnStatusView.h"
#import "ChatManager.h"
#import "ChatUserModel.h"
#import "ChatMessageHelper.h"
#import "ConversationStore.h"

@interface ChatListTableViewController ()

@property (nonatomic, strong) ConnStatusView *clientStatusView;
@property (nonatomic, strong) NSMutableArray *conversations;
@property (atomic, assign) BOOL isRefreshing;

@end

static NSMutableArray *cacheConvs;

@implementation ChatListTableViewController

- (instancetype)init {
    if ((self = [super init])) {
        _conversations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ConversationCell registerCellToTableView:self.tableView];
    
    self.refreshControl = [self getRefreshControl];
    
    // 当在其它 Tab 的时候，收到消息 badge 增加，所以需要一直监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:kChatNotificationMessageReceived object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:kChatNotificationUnreadsUpdated object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStatusView) name:kChatNotificationConnectivityUpdated object:nil];
    
    [self updateStatusView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 刷新 unread badge 和新增的对话
    [self performSelector:@selector(refresh:) withObject:nil afterDelay:0];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - client status view
- (ConnStatusView *)clientStatusView {
    if (_clientStatusView == nil) {
        _clientStatusView = [[ConnStatusView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), kStatusViewHight)];
    }
    return _clientStatusView;
}

- (void)updateStatusView {
    if ([ChatManager manager].connect) {
        self.tableView.tableHeaderView = nil ;
    }else {
        self.tableView.tableHeaderView = self.clientStatusView;
    }
}

- (UIRefreshControl *)getRefreshControl {
    UIRefreshControl *refreshConrol = [[UIRefreshControl alloc] init];
    [refreshConrol addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    return refreshConrol;
}

#pragma mark - refresh
- (void)refresh {
    [self refresh:nil];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    if (self.isRefreshing) {
        return;
    }
    
    self.isRefreshing = YES;
    [[ChatManager manager] findRecentConversationsWithBlock:^(NSArray *conversations, NSInteger totalUnreadCount, NSError *error) {
        dispatch_block_t finishBlock = ^{
            [self stopRefreshControl:refreshControl];
            if ([self filterError:error]) {
                self.conversations = [conversations mutableCopy];
                [self.tableView reloadData];
                if ([self respondsToSelector:@selector(setBadgeWithTotalUnreadCount:)]) {
                    [self setBadgeWithTotalUnreadCount:totalUnreadCount];
                }
                [self selectConversationIfHasRemoteNotificatoinConvid];
            }
            self.isRefreshing = NO;
        };
        
        if ([self respondsToSelector:@selector(prepareConversationsWhenLoad:completion:)]) {
            [self prepareConversationsWhenLoad:conversations completion:^(BOOL succeeded, NSError *error) {
                if ([self filterError:error]) {
                    finishBlock();
                } else {
                    [self stopRefreshControl:refreshControl];
                    self.isRefreshing = NO;
                }
            }];
        } else {
            finishBlock();
        }
    }];
}

- (void)selectConversationIfHasRemoteNotificatoinConvid {
    if ([ChatManager manager].remoteNotificationConvid) {
        // 进入之前推送弹框点击的对话
        BOOL found = NO;
        for (AVIMConversation *conversation in self.conversations) {
            if ([conversation.conversationId isEqualToString:[ChatManager manager].remoteNotificationConvid]) {
                if ([self respondsToSelector:@selector(viewController:didSelectConv:)]) {
                    [self viewController:self didSelectConv:conversation];
                    found = YES;
                }
            }
        }
        if (!found) {
            NSLog(@"not found remoteNofitciaonID");
        }
        [ChatManager manager].remoteNotificationConvid = nil;
    }
}

#pragma mark - utils

- (void)stopRefreshControl:(UIRefreshControl *)refreshControl {
    if (refreshControl != nil && [[refreshControl class] isSubclassOfClass:[UIRefreshControl class]]) {
        [refreshControl endRefreshing];
    }
}

- (BOOL)filterError:(NSError *)error {
    if (error) {
        [[[UIAlertView alloc]
          initWithTitle:nil message:[NSString stringWithFormat:@"%@", error] delegate:nil
          cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.conversations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationCell *cell = [ConversationCell dequeueOrCreateCellByTableView:tableView];
    AVIMConversation *conversation = [self.conversations objectAtIndex:indexPath.row];
    if (conversation.type == ConversationTypeSingle) {
        ChatUserModel *user = [[ChatManager manager].userDelegate getUserById:conversation.otherId];
        cell.nameLabel.text = user.username;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
    } else {
        [cell.avatarImageView setImage:conversation.icon];
        cell.nameLabel.text = conversation.displayName;
    }
    if (conversation.lastMessage) {
        cell.messageTextLabel.attributedText = [[ChatMessageHelper helper] attributedStringWithMessage:conversation.lastMessage conversation:conversation];
        cell.timestampLabel.text = [[NSDate dateWithTimeIntervalSince1970:conversation.lastMessage.sendTimestamp / 1000] timeAgoSinceNow];
    }
    if (conversation.unreadCount > 0) {
        if (conversation.muted) {
            cell.litteBadgeView.hidden = NO;
        } else {
            cell.badgeView.badgeText = [NSString stringWithFormat:@"%ld", conversation.unreadCount];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AVIMConversation *conversation = [self.conversations objectAtIndex:indexPath.row];
        [[ConversationStore store] deleteConversation:conversation];
        [self refresh];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVIMConversation *conversation = [self.conversations objectAtIndex:indexPath.row];
    if ([self respondsToSelector:@selector(viewController:didSelectConv:)]) {
        [self viewController:self didSelectConv:conversation];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ConversationCell heightOfCell];
}

#pragma mark - ChatListDelegate
- (void)viewController:(UIViewController *)viewController didSelectConv:(AVIMConversation *)conv {
    
}

- (void)setBadgeWithTotalUnreadCount:(NSInteger)totalUnreadCount {
    if (totalUnreadCount > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)totalUnreadCount];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:totalUnreadCount];
    } else {
        self.tabBarItem.badgeValue = nil;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

@end
