//
//  ChatListTableViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "BaseTableViewController.h"

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



@end

@interface ChatListTableViewController : BaseTableViewController

@end
