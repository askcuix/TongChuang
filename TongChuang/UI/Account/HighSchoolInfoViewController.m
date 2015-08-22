//
//  HighSchoolInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "HighSchoolInfoViewController.h"
#import "UIView+Extension.h"
#import "CommonTypes.h"
#import "KeyboardHelper.h"
#import "SingerPickerViewDelegate.h"
#import "IndustryInfoViewController.h"

@interface HighSchoolInfoViewController () <SingerPickerDelegate> {
    SingerPickerViewDelegate *_schoolPickerDelegate;
    SingerPickerViewDelegate *_startTimePickerDelegate;
    PickerView *_schoolPickerView;
    PickerView *_startTimePickerView;
}

@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)jumpBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIButton *)sender;

- (IBAction)changeSchool:(UIButton *)sender;
- (IBAction)changeStartTime:(UIButton *)sender;

@end

@implementation HighSchoolInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题信息
    self.title = [NSString stringWithFormat:@"(%d/%d)填写学校资料", [DegreeInfo stepCount:self.highestDegree] - 1, [DegreeInfo stepCount:self.highestDegree]];
    
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
    
    if ([self.schoolLabel.text length] == 0) {
        [self showHUDText:@"学校不能为空" type:Fail];
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
    IndustryInfoViewController *industryController = [ControllerManager viewControllerInSettingStoryboard:@"IndustryInfoViewController"];
    industryController.highestDegree = _highestDegree;
    
    [self.navigationController pushViewController:industryController animated:YES];
}

- (IBAction)changeSchool:(UIButton *)sender {
    [_classField resignFirstResponder];
    
    if (!_schoolPickerView) {
        NSArray *schoolData = @[@"执信中学", @"华师附中"];
        _schoolPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:schoolData delegate:self];
        _schoolPickerView = [[PickerView alloc] initWithDelegate:_schoolPickerDelegate withDataSource:_schoolPickerDelegate];
    }
    
    [_schoolPickerView showInView:self.view withBlur:YES];
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
        self.schoolLabel.text = pickedValue;
    } else if (_startTimePickerView == sender) {
        self.startTimeLabel.text = pickedValue;
    }
}
@end
