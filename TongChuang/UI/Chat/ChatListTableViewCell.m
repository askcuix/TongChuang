//
//  ChatListTableViewCell.m
//  TongChuang
//
//  Created by cuixiang on 15/7/21.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ChatListTableViewCell.h"
#import <JSBadgeView.h>

@interface ChatListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *chatImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *avatarView;

@end

@implementation ChatListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)renderCell {
    if (_title) {
        self.titleLabel.text = _title;
    }
    
    if (_latestMsgDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        dateFormatter.locale = locale;
        
        self.timeLabel.text = [dateFormatter stringFromDate:_latestMsgDate];
    }
    
    if (self.msgNotifyCount && self.msgNotifyCount > 0) {
        if (_latestMsg) {
            self.msgLabel.text = [NSString stringWithFormat:@"[%ld条] %@", (long)_msgNotifyCount, _latestMsg];
        }
        
        if (_chatImg) {
            self.chatImgView.image = _chatImg;
            JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:self.avatarView alignment:JSBadgeViewAlignmentTopRight];
            badgeView.badgeText = [NSString stringWithFormat:@"%ld", (long)self.msgNotifyCount];
        }
    } else {
        if (_latestMsg) {
            self.msgLabel.text = _latestMsg;
        }
        
        if (_chatImg) {
            self.chatImgView.image = _chatImg;
        }
    }
    
    self.chatImgView.layer.cornerRadius = 10.0f;
    self.chatImgView.clipsToBounds = YES;
}

@end
