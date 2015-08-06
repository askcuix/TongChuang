//
//  ContactListViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/21.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactListTableViewCell.h"

static NSString *ContactGroupTableIdentifier = @"ContactGroupTableIdentifier";
static NSString *ContactListTableIdentifier = @"ContactListTableIdentifier";

@interface ContactListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置索引
    self.tableView.sectionIndexColor = [UIColor blackColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor whiteColor];
    
    // 注册表格的nib
    UINib *nib = [UINib nibWithNibName:@"ContactListCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:ContactListTableIdentifier];
    
    nib = [UINib nibWithNibName:@"ContactGroupCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:ContactGroupTableIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    } else if (section == 1) {
        return @"C";
    } else {
        return @"T";
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:ContactGroupTableIdentifier forIndexPath:indexPath];
    } else {
        ContactListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactListTableIdentifier forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            cell.name = @"Chris";
            cell.avatarImg = [UIImage imageNamed:@"avatar.png"];
        } else {
            cell.name = @"Tracy";
            cell.avatarImg = [UIImage imageNamed:@"avatar.png"];
        }
        
        return cell;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSArray *index = @[@"", @"C", @"T"];
    return index;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        view = nil;
    } else {
        // 设置section的背景色
        view.tintColor = [UIColor lightGrayColor];
        
        // 设置section文字颜色
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        [header.textLabel setTextColor:[UIColor darkGrayColor]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView reloadData];
    }
}

@end
