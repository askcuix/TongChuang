//
//  HighSchoolInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "HighSchoolInfoViewController.h"
#import "CommonTypes.h"
#import "SingerPickerViewDelegate.h"
#import "IndustryInfoViewController.h"

@interface HighSchoolInfoViewController () <SingerPickerDelegate> {
    SingerPickerViewDelegate *_schoolPickerDelegate;
    SingerPickerViewDelegate *_startTimePickerDelegate;
    PickerView *_schoolPickerView;
    PickerView *_startTimePickerView;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;
- (IBAction)jumpBtnClick:(UIButton *)sender;


@end

@implementation HighSchoolInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题信息
    NSString *titleInfo = [NSString stringWithFormat:@"填写学校资料（已完成%ld/%ld）", [DegreeInfo stepCount:self.highestDegree] - 1, [DegreeInfo stepCount:self.highestDegree]];
    _titleLabel.text = titleInfo;
    
    //更改学校
    [self.schoolLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *schoolGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSchool)];
    [self.schoolLabel addGestureRecognizer:schoolGesture];
    
    //更改入学时间
    [self.startTimeLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *startTimeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStartTime)];
    [self.startTimeLabel addGestureRecognizer:startTimeGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_classField resignFirstResponder];
    
    [self nextStep];
}

- (IBAction)jumpBtnClick:(UIButton *)sender {
    [_classField resignFirstResponder];
    
    [self nextStep];
}

- (void)nextStep {
    IndustryInfoViewController *industryController = [ControllerManager viewControllerInSettingStoryboard:@"IndustryInfoViewController"];
    
    [self.navigationController pushViewController:industryController animated:YES];
}

- (void)changeSchool {
    [_classField resignFirstResponder];
    
    if (!_schoolPickerView) {
        NSArray *schoolData = @[@"执信中学", @"华师附中"];
        _schoolPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:schoolData delegate:self];
        _schoolPickerView = [[PickerView alloc] initWithDelegate:_schoolPickerDelegate withDataSource:_schoolPickerDelegate];
    }
    
    [_schoolPickerView showInView:self.view withBlur:YES];
}

- (void)changeStartTime {
    [_classField resignFirstResponder];
    
    if (!_startTimePickerView) {
        NSMutableArray *startTimeData = [NSMutableArray array];
        for (int i = 1980; i < 2015; i++) {
            [startTimeData addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _startTimePickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:startTimeData delegate:self];
        _startTimePickerView = [[PickerView alloc] initWithDelegate:_startTimePickerDelegate withDataSource:_startTimePickerDelegate];
    }
    
    [_startTimePickerView showInView:self.view withBlur:YES];
}

#pragma mark - SingerPickerDelegate
- (void)pickValueDone:(id)sender data:(NSString *)pickedValue {
    if (_schoolPickerView == sender) {
        self.schoolLabel.text = pickedValue;
    } else if (_startTimePickerView == sender) {
        self.startTimeLabel.text = pickedValue;
    }
}
@end
