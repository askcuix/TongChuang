//
//  ConversationCell.h
//  TongChuang
//
//  Created by cuixiang on 15/8/10.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSBadgeView/JSBadgeView.h>

@interface ConversationCell : UITableViewCell

+ (CGFloat)heightOfCell;

+ (ConversationCell *)dequeueOrCreateCellByTableView :(UITableView *)tableView;

+ (void)registerCellToTableView: (UITableView *)tableView ;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel  *messageTextLabel;
@property (nonatomic, strong) JSBadgeView *badgeView;
@property (nonatomic, strong) UIView *litteBadgeView;
@property (nonatomic, strong) UILabel *timestampLabel;

@end
