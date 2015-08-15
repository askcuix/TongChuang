//
//  ContactTableViewCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
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
    return NSStringFromClass([ContactTableViewCell class]);
}

+ (void)registerCellToTalbeView:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:@"ContactTableCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[ContactTableViewCell identifier]];
}

+ (ContactTableViewCell *)createOrDequeueCellByTableView:(UITableView *)tableView {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactTableViewCell identifier]];
    if (cell == nil) {
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ContactTableViewCell identifier]];
        if (cell == nil) {
            [ContactTableViewCell registerCellToTalbeView:tableView];
            return [self createOrDequeueCellByTableView:tableView];
        }
    }
    return cell;
}

@end
