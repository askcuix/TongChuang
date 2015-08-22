//
//  UniversityInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UniversityInfoViewController.h"
#import "UIView+Extension.h"
#import "KeyboardHelper.h"
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

@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *universityLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)jumpBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIButton *)sender;

- (IBAction)changeSchool:(UIButton *)sender;
- (IBAction)changeMajor:(UIButton *)sender;
- (IBAction)changeStartTime:(UIButton *)sender;

@end

@implementation UniversityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题信息
    self.title = [NSString stringWithFormat:@"(%d/%d)填写学校资料", [DegreeInfo currentStep:self.currentDegree HighestDegree:self.highestDegree], [DegreeInfo stepCount:self.highestDegree]];
    
    //设置学历
    _schoolLabel.text = [DegreeInfo degreeName:self.currentDegree];
    
    //设置下一步按钮
    [self.nextBtn setCornerRadius:4 maskToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[KeyboardHelper helper] setViewToKeyboardHelper:_classField withShouldOffsetView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)jumpBtnClick:(UIBarButtonItem *)sender {
    [_classField resignFirstResponder];
    
    [self nextStep];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    [_classField resignFirstResponder];
    
    if ([self.universityLabel.text length] == 0) {
        [self showHUDText:@"学校不能为空" type:Fail];
        return;
    }
    
    if ([self.majorLabel.text length] == 0) {
        [self showHUDText:@"专业不能为空" type:Fail];
        return;
    }
    
    if ([[self.classField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        [self showHUDText:@"班级不能为空" type:Fail];
        return;
    }
    
    if ([self.startTimeLabel.text length] == 0) {
        [self showHUDText:@"入学时间不能为空" type:Fail];
        return;
    }
    
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

- (IBAction)changeSchool:(UIButton *)sender {
    [_classField resignFirstResponder];
    
    if (!_schoolPickerView) {
        NSArray *schoolData = @[@"中山大学", @"华南理工大学", @"广东工业大学", @"华南农业大学"];
        _schoolPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:schoolData delegate:self];
        _schoolPickerView = [[PickerView alloc] initWithDelegate:_schoolPickerDelegate withDataSource:_schoolPickerDelegate];
    }
    
    [_schoolPickerView showInView:self.view withBlur:YES];
}

- (IBAction)changeMajor:(UIButton *)sender {
    [_classField resignFirstResponder];
    
    if (!_majorPickerView) {
        NSArray *majorData = @[@"计算机技术", @"电子商务", @"法律"];
        _majorPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:majorData delegate:self];
        _majorPickerView = [[PickerView alloc] initWithDelegate:_majorPickerDelegate withDataSource:_majorPickerDelegate];
    }
    
    [_majorPickerView showInView:self.view withBlur:YES];
}

- (IBAction)changeStartTime:(UIButton *)sender {
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
