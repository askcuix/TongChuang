//
//  RecommendGroupTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendGroupTableCell.h"
#import "UIView+Extension.h"

@interface RecommendGroupTableCell () {
    GroupInfo *_groupInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIButton *lookBtn;


- (IBAction)lookBtnClick:(UIButton *)sender;

@end

@implementation RecommendGroupTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view
- (void)setGroupInfo:(GroupInfo *)groupInfo {
    [self.degreeLabel setCornerRadius:2 maskToBounds:YES];
    [self.lookBtn setCornerRadius:6 maskToBounds:YES];
    
    if (!groupInfo) {
        return;
    }
    
    _groupInfo = groupInfo;
    
    if ([_groupInfo.name length] > 0) {
        _nameLabel.text = _groupInfo.name;
    }
    
    if ([_groupInfo.info length] > 0) {
        _detailLabel.text = _groupInfo.info;
    }
    
    _degreeLabel.text = [DegreeInfo simpleDegreeName:_groupInfo.degree];
}

#pragma mark - action
- (IBAction)lookBtnClick:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"群ID：%ld", (long)_groupInfo.gid];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查看群" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}
@end
