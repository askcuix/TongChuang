//
//  ChatListTableViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "AVIMConversation+Custom.h"
#import "ConversationCell.h"

/**
 *  最近对话页面的协议
 */
@protocol ChatListDelegate <NSObject>

@optional

/**
 *  来设置 tabbar 的 badge。
 *  @param totalUnreadCount 未读数总和。没有算免打扰对话的未读数。
 */
- (void)setBadgeWithTotalUnreadCount:(NSInteger)totalUnreadCount;

/**
 *  点击了某对话。此时可跳转到聊天页面
 *  @param viewController 最近对话 controller
 *  @param conv           点击的对话
 */
- (void)viewController:(UIViewController *)viewController didSelectConv:(AVIMConversation *)conv;

- (void)prepareConversationsWhenLoad:(NSArray *)conversations completion:(AVBooleanResultBlock)completion;

@end

@interface ChatListTableViewController : UITableViewController <ChatListDelegate>

@end
