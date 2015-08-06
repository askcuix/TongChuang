//
//  UniversityInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UniversityInfoViewController.h"
#import "HighSchoolInfoViewController.h"
#import "SingerPickerViewDelegate.h"

@interface UniversityInfoViewController () <SingerPickerDelegate> {
    SingerPickerViewDelegate *_schoolPickerDelegate;
    SingerPickerViewDelegate *_majorPickerDelegate;
    SingerPickerViewDelegate *_startTimePickerDelegate;
    PickerView *_schoolPickerView;
    PickerView *_majorPickerView;
    PickerView *_startTimePickerView;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;
- (IBAction)jumpBtnClick:(UIButton *)sender;

@end

@implementation UniversityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题信息
    NSString *titleInfo = [NSString stringWithFormat:@"填写学校资料（已完成%ld/%ld）", [DegreeInfo currentStep:self.currentDegree HighestDegree:self.highestDegree], [DegreeInfo stepCount:self.highestDegree]];
    _titleLabel.text = titleInfo;
    NSString *titleHintInfo = [NSString stringWithFormat:@"（系统将自动为你寻找%@同窗）", [DegreeInfo degreeName:self.currentDegree]];
    _hintLabel.text = titleHintInfo;
    NSString *schoolInfo = [NSString stringWithFormat:@"%@就读学校", [DegreeInfo degreeName:self.currentDegree]];
    _schoolLabel.text = schoolInfo;
    
    //更改学校
    [self.universityLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *schoolGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSchool)];
    [self.universityLabel addGestureRecognizer:schoolGesture];
    
    //更改专业
    [self.majorLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *majorGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMajor)];
    [self.majorLabel addGestureRecognizer:majorGesture];
    
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
    if (self.currentDegree == Bachelor) {
        HighSchoolInfoViewController *highSchoolController = [ControllerManager viewControllerInSettingStoryboard:@"HighSchoolInfoViewController"];
        highSchoolController.highestDegree = _highestDegree;
        
        [self.navigationController pushViewController:highSchoolController animated:YES];
    } else {
        UniversityInfoViewController *nextDegreeController = [ControllerManager viewControllerInSettingStoryboard:@"UniversityInfoViewController"];
        nextDegreeController.highestDegree = _highestDegree;
        nextDegreeController.currentDegree = _currentDegree + 1;
        
        [self.navigationController pushViewController:nextDegreeController animated:YES];
    }
}

- (void)changeSchool {
    [_classField resignFirstResponder];
    
    if (!_schoolPickerView) {
        NSArray *schoolData = @[@"中山大学", @"华南理工大学", @"广东工业大学", @"华南农业大学"];
        _schoolPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:schoolData delegate:self];
        _schoolPickerView = [[PickerView alloc] initWithDelegate:_schoolPickerDelegate withDataSource:_schoolPickerDelegate];
    }
    
    [_schoolPickerView showInView:self.view withBlur:YES];
}

- (void)changeMajor {
    [_classField resignFirstResponder];
    
    if (!_majorPickerView) {
        NSArray *majorData = @[@"计算机技术", @"电子商务", @"法律"];
        _majorPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:majorData delegate:self];
        _majorPickerView = [[PickerView alloc] initWithDelegate:_majorPickerDelegate withDataSource:_majorPickerDelegate];
    }
    
    [_majorPickerView showInView:self.view withBlur:YES];
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
        self.universityLabel.text = pickedValue;
    } else if (_majorPickerView == sender) {
        self.majorLabel.text = pickedValue;
    } else if (_startTimePickerView == sender) {
        self.startTimeLabel.text = pickedValue;
    }
}

@end
