//
//  RecommendCircleTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommendCircleTableCell.h"

@interface RecommendCircleTableCell () {
    CircleInfo *_circleInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)lookBtnClick:(UIButton *)sender;

@end

@implementation RecommendCircleTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view
- (void)setCircleInfo:(CircleInfo *)circleInfo {
    if (!circleInfo) {
        return;
    }
    
    _circleInfo = circleInfo;
    
    if ([_circleInfo.name length] > 0) {
        self.nameLabel.text = _circleInfo.name;
    }
}

#pragma mark - action
- (IBAction)lookBtnClick:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"圈子ID：%ld", (long)_circleInfo.cid];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查看圈子" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
}
@end
