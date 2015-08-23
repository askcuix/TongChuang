//
//  ConversationCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/10.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ConversationCell.h"
#import "UIColor+Extension.h"

static CGFloat kImageSize = 50;
static CGFloat kVerticalSpacing = 8;
static CGFloat kHorizontalSpacing = 10;
static CGFloat kTimestampeLabelWidth = 100;

static CGFloat kNameLabelHeightProportion = 3.0 / 5;
static CGFloat kNameLabelHeight;
static CGFloat kMessageLabelHeight;
static CGFloat kLittleBadgeSize = 10;

@implementation ConversationCell

+ (ConversationCell *)dequeueOrCreateCellByTableView :(UITableView *)tableView {
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConversationCell identifier]];
    if (cell == nil) {
        cell = [[ConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[self class] identifier]];
    }
    return cell;
}

+ (void)registerCellToTableView: (UITableView *)tableView {
    [tableView registerClass:[ConversationCell class] forCellReuseIdentifier:[[self class] identifier]];
}

+ (NSString *)identifier {
    return NSStringFromClass([ConversationCell class]);
}

+ (CGFloat)heightOfCell {
    return 66;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    kNameLabelHeight = kImageSize * kNameLabelHeightProportion;
    kMessageLabelHeight = kImageSize - kNameLabelHeight;
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.timestampLabel];
    [self addSubview:self.litteBadgeView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.messageTextLabel];
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHorizontalSpacing, kVerticalSpacing, kImageSize, kImageSize)];
    }
    return _avatarImageView;
}

- (UIView *)litteBadgeView {
    if (_litteBadgeView == nil) {
        _litteBadgeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLittleBadgeSize, kLittleBadgeSize)];
        _litteBadgeView.backgroundColor = [UIColor redColor];
        _litteBadgeView.layer.masksToBounds = YES;
        _litteBadgeView.layer.cornerRadius = kLittleBadgeSize / 2;
        _litteBadgeView.center = CGPointMake(CGRectGetMaxX(_avatarImageView.frame), CGRectGetMinY(_avatarImageView.frame));
        _litteBadgeView.hidden = YES;
    }
    return _litteBadgeView;
}

- (UILabel *)timestampLabel {
    if (_timestampLabel == nil) {
        _timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - kHorizontalSpacing - kTimestampeLabelWidth, CGRectGetMinY(_avatarImageView.frame), kTimestampeLabelWidth, kNameLabelHeight)];
        _timestampLabel.font = [UIFont systemFontOfSize:11];
        _timestampLabel.textAlignment = NSTextAlignmentRight;
        _timestampLabel.textColor = UIColorHex(@"#b2b2b2");
    }
    return _timestampLabel;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_avatarImageView.frame) + kHorizontalSpacing, CGRectGetMinY(_avatarImageView.frame), CGRectGetMinX(_timestampLabel.frame) - kHorizontalSpacing * 3 - kImageSize, kNameLabelHeight)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = UIColorHex(@"#262626");
    }
    return _nameLabel;
}

- (UILabel *)messageTextLabel {
    if (_messageTextLabel == nil) {
        _messageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame), CGRectGetWidth([UIScreen mainScreen].bounds)- 3 * kHorizontalSpacing - kImageSize, kMessageLabelHeight)];
        _messageTextLabel.backgroundColor = [UIColor clearColor];
        _messageTextLabel.font = [UIFont systemFontOfSize:13];
        _messageTextLabel.textColor = UIColorHex(@"#8d8d8d");
    }
    return _messageTextLabel;
}

- (JSBadgeView *)badgeView {
    if (_badgeView == nil) {
        _badgeView = [[JSBadgeView alloc] initWithParentView:_avatarImageView alignment:JSBadgeViewAlignmentTopRight];
    }
    return _badgeView;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.badgeView.badgeText = nil;
    self.litteBadgeView.hidden = YES;
    self.messageTextLabel.text = nil;
    self.timestampLabel.text = nil;
    self.nameLabel.text = nil;
}

@end
