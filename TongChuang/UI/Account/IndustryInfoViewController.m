//
//  IndustryInfoViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "IndustryInfoViewController.h"
#import "UIView+Extension.h"
#import "SingerPickerViewDelegate.h"
#import "DoublePickerViewDelegate.h"
#import "ControllerManager.h"
#import "MatchFriendsViewController.h"

@interface IndustryInfoViewController () <SingerPickerDelegate, DoublePickerDelegate> {
    SingerPickerViewDelegate *_industryPickerDelegate;
    DoublePickerViewDelegate *_nativeLocPickerDelegate;
    DoublePickerViewDelegate *_currentLocPickerDelegate;
    PickerView *_industryPickerView;
    PickerView *_nativeLocPickerView;
    PickerView *_currentLocPickerView;
}
@property (weak, nonatomic) IBOutlet UILabel *nativeLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLocLabel;
@property (weak, nonatomic) IBOutlet UILabel *industryLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)backBtnClick:(UIBarButtonItem *)sender;
- (IBAction)nextBtnClick:(UIButton *)sender;

- (IBAction)changeNativeLocation:(UIButton *)sender;
- (IBAction)changeCurrentLocation:(UIButton *)sender;
- (IBAction)changeIndustry:(UIButton *)sender;


@end

@implementation IndustryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题信息
    self.title = [NSString stringWithFormat:@"(%d/%d)填写资料", [DegreeInfo stepCount:self.highestDegree], [DegreeInfo stepCount:self.highestDegree]];
    
    //设置下一步按钮
    [self.nextBtn setCornerRadius:4 maskToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)backBtnClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextBtnClick:(UIButton *)sender {
    if ([self.nativeLocLabel.text length] == 0) {
        [self showHUDText:@"籍贯不能为空" type:Fail];
        return;
    }
    
    if ([self.currentLocLabel.text length] == 0) {
        [self showHUDText:@"所在地不能为空" type:Fail];
        return;
    }
    
    if ([self.industryLabel.text length] == 0) {
        [self showHUDText:@"行业不能为空" type:Fail];
        return;
    }
    
    [self nextStep];
}

- (void)nextStep {
    MatchFriendsViewController *matchController = [ControllerManager viewControllerInSettingStoryboard:@"MatchFriendsViewController"];
    
    [self.navigationController pushViewController:matchController animated:YES];
}

- (IBAction)changeNativeLocation:(UIButton *)sender {
    if (!_nativeLocPickerView) {
        NSDictionary *locationData = @{@"广东" : @[@"深圳", @"广州", @"珠海"],
                                       @"湖南" : @[@"长沙", @"湘潭", @"株洲"],
                                       @"湖北" : @[@"武汉", @"襄樊", @"黄冈"]};
        _nativeLocPickerDelegate = [[DoublePickerViewDelegate alloc] initWithData:locationData delegate:self];
        _nativeLocPickerView = [[PickerView alloc] initWithDelegate:_nativeLocPickerDelegate withDataSource:_nativeLocPickerDelegate];
    }
    
    [_nativeLocPickerView showInView:self.view withBlur:YES];
}

- (IBAction)changeCurrentLocation:(UIButton *)sender {
    if (!_currentLocPickerView) {
        NSDictionary *locationData = @{@"广东" : @[@"深圳", @"广州", @"珠海"],
                                       @"湖南" : @[@"长沙", @"湘潭", @"株洲"],
                                       @"湖北" : @[@"武汉", @"襄樊", @"黄冈"]};
        _currentLocPickerDelegate = [[DoublePickerViewDelegate alloc] initWithData:locationData delegate:self];
        _currentLocPickerView = [[PickerView alloc] initWithDelegate:_currentLocPickerDelegate withDataSource:_currentLocPickerDelegate];
    }
    
    [_currentLocPickerView showInView:self.view withBlur:YES];
}

- (IBAction)changeIndustry:(UIButton *)sender {
    if (!_industryPickerView) {
        NSArray *industryData = @[@"互联网", @"法律", @"金融"];
        _industryPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:industryData delegate:self];
        _industryPickerView = [[PickerView alloc] initWithDelegate:_industryPickerDelegate withDataSource:_industryPickerDelegate];
    }
    
    [_industryPickerView showInView:self.view withBlur:YES];
}

#pragma mark - SingerPickerDelegate
- (void)pickValueDone:(id)sender data:(NSString *)pickedValue {
    if (_industryPickerView == sender) {
        self.industryLabel.text = pickedValue;
    }
}

#pragma mark - DoublePickerDelegate
- (void)pickDoubleValueDone:(id)sender data:(NSArray *)pickedValue {
    if (_nativeLocPickerView == sender) {
        NSString *province = pickedValue[0];
        NSString *city = pickedValue[1];
        
        _nativeLocLabel.text = [NSString stringWithFormat:@"%@ %@", province, city];
    } else if (_currentLocPickerView == sender) {
        NSString *province = pickedValue[0];
        NSString *city = pickedValue[1];
        
        _currentLocLabel.text = [NSString stringWithFormat:@"%@ %@", province, city];
    }
}

@end
