//
//  ChatListTableViewCell.h
//  TongChuang
//
//  Created by cuixiang on 15/7/21.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListTableViewCell : UITableViewCell

@property (copy, nonatomic) UIImage *chatImg;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *latestMsg;
@property (copy, nonatomic) NSDate *latestMsgDate;
@property (assign, nonatomic) NSInteger msgNotifyCount;

- (void)renderCell;

@end
