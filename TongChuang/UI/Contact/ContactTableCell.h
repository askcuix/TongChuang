//
//  ContactTableCell.h
//  TongChuang
//
//  Created by cuixiang on 15/8/15.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

+ (NSString *)identifier;

+ (void)registerCellToTableView:(UITableView *)tableView;

+ (ContactTableCell *)createOrDequeueCellByTableView:(UITableView *)tableView;

- (void)setRoundImageStyle;

@end
