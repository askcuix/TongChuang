//
//  RecommednTableCell.m
//  TongChuang
//
//  Created by cuixiang on 15/8/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "RecommednTableCell.h"

@implementation RecommednTableCell

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
    return NSStringFromClass([RecommednTableCell class]);
}

+ (void)registerCellToTableView:(UITableView *)tableView {
    UINib *nib = [UINib nibWithNibName:@"RecommendContactTableCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:[RecommednTableCell identifier]];
}

+ (RecommednTableCell *)createOrDequeueCellByTableView:(UITableView *)tableView {
    RecommednTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommednTableCell identifier]];
    if (cell == nil) {
        cell = [[RecommednTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[RecommednTableCell identifier]];
        if (cell == nil) {
            [RecommednTableCell registerCellToTableView:tableView];
            return [self createOrDequeueCellByTableView:tableView];
        }
    }
    return cell;
}

@end
