//
//  RecommendPersonTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendPersonTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Extension.h"
#import "UIColor+Extension.h"

@interface RecommendPersonTableCell () {
    UserInfo *_personInfo;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

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
- (void)setPersonInfo:(UserInfo *)personInfo {
    [self.avatarImgView setCornerRadius:(self.avatarImgView.width / 2) maskToBounds:YES];
    [self.addBtn setCornerRadius:6 maskToBounds:YES];
    [self.addBtn setBorderWidth:1];
    [self.addBtn setBorderColor:UIColorHex(@"#e8e8e8")];
    
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
