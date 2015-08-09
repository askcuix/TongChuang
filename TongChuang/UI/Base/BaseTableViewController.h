//
//  BaseTableViewController.h
//  TongChuang
//
//  Created by cuixiang on 15/8/9.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)loadDataSource;

@end
