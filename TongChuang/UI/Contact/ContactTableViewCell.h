//
//  ContactTableViewCell.h
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

+ (NSString *)identifier;

+ (void)registerCellToTalbeView:(UITableView *)tableView;

+ (ContactTableViewCell *)createOrDequeueCellByTableView:(UITableView *)tableView;

@end
