//
//  ContactTableViewCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "NewContactTableViewCell.h"

@implementation NewContactTableViewCell

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

+ (NSString *)identifier {
    return NSStringFromClass([NewContactTableViewCell class]);
}

+ (void)registerCellToTableView:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:@"NewContactTableCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[NewContactTableViewCell identifier]];
}

+ (NewContactTableViewCell *)createOrDequeueCellByTableView:(UITableView *)tableView {
    NewContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewContactTableViewCell identifier]];
    if (cell == nil) {
        cell = [[NewContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewContactTableViewCell identifier]];
        if (cell == nil) {
            [NewContactTableViewCell registerCellToTableView:tableView];
            return [self createOrDequeueCellByTableView:tableView];
        }
    }
    return cell;
}

@end
