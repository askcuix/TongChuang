//
//  ContactListTableViewCell.m
//  TongChuang
//
//  Created by cuixiang on 15/7/21.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactListTableViewCell.h"

@interface ContactListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ContactListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setter
- (void)setName:(NSString *)n {
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    }
}

- (void)setAvatarImg:(UIImage *)img {
    if (img) {
        _avatarImg = [img copy];
        self.avatarView.image = _avatarImg;
    }
}

@end
