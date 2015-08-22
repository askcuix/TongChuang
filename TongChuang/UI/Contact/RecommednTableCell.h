//
//  RecommednTableCell.h
//  TongChuang
//
//  Created by cuixiang on 15/8/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommednTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

+ (NSString *)identifier;

+ (void)registerCellToTableView:(UITableView *)tableView;

+ (RecommednTableCell *)createOrDequeueCellByTableView:(UITableView *)tableView;

@end
