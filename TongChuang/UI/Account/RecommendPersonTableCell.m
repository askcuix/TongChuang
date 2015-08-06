//
//  RecommendPersonTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendPersonTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RecommendPersonTableCell () {
    PersonInfo *_personInfo;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

- (IBAction)addBtnClick:(UIButton *)sender;

@end

@implementation RecommendPersonTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view
- (void)setPersonInfo:(PersonInfo *)personInfo {
    if (!personInfo) {
        return;
    }
    
    _personInfo = personInfo;
    
    if ([_personInfo.avatarUrl length] > 0) {
        [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_personInfo.avatarUrl]];
    }
    
    if ([_personInfo.name length] > 0) {
        _nameLabel.text = _personInfo.name;
    }
    
    if ([_personInfo.schoolName length] > 0) {
        _schoolLabel.text = _personInfo.schoolName;
    }
}

#pragma mark - action
- (IBAction)addBtnClick:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"联系人ID：%ld", (long)_personInfo.uid];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查看联系人" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}
@end
