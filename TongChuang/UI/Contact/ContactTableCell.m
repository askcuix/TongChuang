//
//  ContactTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactTableCell.h"

@implementation ContactTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRoundImageStyle {
    [self.avatarImgView setContentMode:UIViewContentModeScaleAspectFill];
    
    // 设置layer对象的圆角半径。将方形图像变成圆形图像，半径应设置为UIImageView宽度的一半。
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.frame.size.width / 2;
    // 必须将clipsToBounds属性设置为YES，layer才能生效。
    self.avatarImgView.clipsToBounds = YES;
}

+ (NSString *)identifier {
    return NSStringFromClass([ContactTableCell class]);
}

+ (void)registerCellToTableView:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:@"ContactTableCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[ContactTableCell identifier]];
}

+ (ContactTableCell *)createOrDequeueCellByTableView:(UITableView *)tableView {
    ContactTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactTableCell identifier]];
    if (cell == nil) {
        cell = [[ContactTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ContactTableCell identifier]];
        if (cell == nil) {
            [ContactTableCell registerCellToTableView:tableView];
            return [self createOrDequeueCellByTableView:tableView];
        }
    }
    return cell;
}

@end
