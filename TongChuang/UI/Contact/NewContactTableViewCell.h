//
//  ContactTableViewCell.h
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (NSString *)identifier;

+ (void)registerCellToTableView:(UITableView *)tableView;

+ (NewContactTableViewCell *)createOrDequeueCellByTableView:(UITableView *)tableView;

@end
