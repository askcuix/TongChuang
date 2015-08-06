//
//  EditPersonalInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/22.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "EditPersonalInfoViewController.h"
#import "EditNameViewController.h"

@interface EditPersonalInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nativePlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *graduateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation EditPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 隐藏空的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //设置table的背景色
    [self.tableView setBackgroundColor:[UIColor colorWithRed:205.0f/255.0f green:205.0f/255.0f blue:205.0f/255.0f alpha:0.2]];
    
    //初始化数据
    self.avatarImgView.image = [UIImage imageNamed:@"avatar.png"];
    self.nameLabel.text = @"Chris";
    self.nativePlaceLabel.text = @"广东广州";
    self.statusLabel.text = @"未婚";
    self.graduateTimeLabel.text = @"2006年07月15日";
    self.degreeLabel.text = @"大学本科";
    self.industryLabel.text = @"互联网";
    self.locationLabel.text = @"广东广州";
    
    //设置头像样式
    [self.avatarImgView setContentMode:UIViewContentModeScaleAspectFill];
    // 设置layer对象的圆角半径。将方形图像变成圆形图像，半径应设置为UIImageView宽度的一半。
    self.avatarImgView.layer.cornerRadius = self.avatarImgView.frame.size.width / 2;
    // 必须将clipsToBounds属性设置为YES，layer才能生效。
    self.avatarImgView.clipsToBounds = YES;
    //设置边框的宽度和边框颜色
    self.avatarImgView.layer.borderWidth = 3.0f;
    self.avatarImgView.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// set section height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // 设置section的背景色
    view.tintColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //清除每行头的空白
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //去除最后一行的分割线
    if (indexPath.section == 2) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editNameSegue"]) {
        EditNameViewController *vc = [segue destinationViewController];
        vc.name = self.nameLabel.text;
    }

}

@end
