//
//  ContactInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "ContactInfoViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "AppModel.h"
#import "ChatPushManager.h"

@interface ContactInfoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestDegreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestSchoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@end

@implementation ContactInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"同窗资料";
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnClick:)];
    backBtn.tintColor = UIColorHex(@"#46a5e3");
    [self.navigationItem setLeftBarButtonItem:backBtn];
    
    self.highestDegreeLabel.text = @"就读学校";
    
    [self.avatarImgView setCornerRadius:(self.avatarImgView.width / 2) maskToBounds:YES];
    [self.actionBtn setCornerRadius:4 maskToBounds:YES];
    
    [self initView];
}

- (void)initView {
    [self showProgress];
    
    WEAKSELF
    [[AppModel sharedInstance].userModel findUser:_user.uid callback:^(UserProfile *user, NSError *error) {
        if (error) {
            [weakSelf hideProgress];
            NSLog(@"获取用户失败：%@", error);
            [weakSelf toast:@"获取用户信息失败"];
        } else {
            [weakSelf.avatarImgView sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]];
            [weakSelf.nameLabel setText:user.name];
            [weakSelf.locationLabel setText:user.location];
            
            NSString *highestDegreeName;
            switch (user.highestDegree) {
                case Doctor:
                    highestDegreeName = @"博士";
                    break;
                case Master:
                    highestDegreeName = @"硕士";
                    break;
                case Bachelor:
                    highestDegreeName= @"本科";
                    break;
                default:
                    highestDegreeName = @"";
                    break;
            }
            [weakSelf.highestDegreeLabel setText:[NSString stringWithFormat:@"%@就读学校", highestDegreeName]];
            
            for (EducationInfo *edu in user.eduInfo) {
                if (edu.degree == user.highestDegree) {
                    [weakSelf.highestSchoolLabel setText:edu.schooleName];
                    [weakSelf.majorLabel setText:edu.major];
                    [weakSelf.classLabel setText:edu.className];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy"];
                    [weakSelf.startTimeLabel setText:[dateFormatter stringFromDate:edu.startTime]];
                    
                    break;
                }
            }
            
            [[AppModel sharedInstance].userModel isFriend:_user.uid callback:^(BOOL isFriend, NSError *error) {
                [weakSelf hideProgress];
                
                if (error) {
                    NSLog(@"获取好友关系失败：%@", error);
                    [weakSelf toast:@"获取用户信息失败"];
                } else {
                    if (isFriend) {
                        [weakSelf.actionBtn setTitle:@"开始聊天" forState:UIControlStateNormal];
                        [weakSelf.actionBtn addTarget:self action:@selector(goChat:) forControlEvents:UIControlEventTouchUpInside];
                    } else {
                        [weakSelf.actionBtn setTitle:@"添加好友" forState:UIControlStateNormal];
                        [weakSelf.actionBtn addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goChat:(id)sender {
    
}

- (void)addContact:(id)sender {
    [self showProgress];
    
    WEAKSELF
    [[AppModel sharedInstance].userModel addUser:_user.uid callback:^(BOOL succeeded, NSError *error) {
        [weakSelf hideProgress];
        
        if (error) {
            NSLog(@"发送添加好友请求失败：%@", error);
            [weakSelf toast:@"添加失败"];
        } else {
            [weakSelf showProgress];
            
            NSString *text = [NSString stringWithFormat:@"%@ 申请加你为好友", [[AppModel sharedInstance].loginModel account]];
            [[ChatPushManager manager] pushMessage:text userIds:@[[NSString stringWithFormat:@"%ld", (long)_user.uid]] block:^(BOOL succeeded, NSError *error) {
                [weakSelf hideProgress];
                
                if (error) {
                    NSLog(@"推送添加好友请求失败：%@", error);
                } else {
                    [weakSelf toast:@"申请成功"];
                }
            }];
        }
    }];
}

@end
