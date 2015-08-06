//
//  BasicProfileViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/16.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommonDefs.h"
#import "CommonTypes.h"
#import "AppModel.h"
#import "CameraUtil.h"
#import "AvatarUtil.h"
#import "BasicProfileViewController.h"
#import "ImageCropperViewController.h"
#import "SingerPickerViewDelegate.h"
#import "DatePicker.h"
#import "UniversityInfoViewController.h"

@interface BasicProfileViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageCropperDelegate, SingerPickerDelegate, DatePickerDelegate> {
    SingerPickerViewDelegate *_genderPickerDelegate;
    SingerPickerViewDelegate *_degreePickerDelegate;
    PickerView *_genderPickerView;
    PickerView *_degreePickerView;
    DatePicker *_datePicker;
    
    DegreeType _highestDegree;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestDegreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *graduateTimeLabel;


- (IBAction)nextBtnClick:(UIBarButtonItem *)sender;

@end

@implementation BasicProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
    
    //设置头像图片
    [self initAvatar];
    
    //更改头像图片
    [self.avatarImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *avatarGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEditAvatar)];
    [self.avatarImageView addGestureRecognizer:avatarGesture];
    
    //更改性别
    [self.genderLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *genderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeGender)];
    [self.genderLabel addGestureRecognizer:genderGesture];
    
    //更改最高学历
    [self.highestDegreeLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *degreeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHighestDegree)];
    [self.highestDegreeLabel addGestureRecognizer:degreeGesture];
    
    //更改毕业时间
    [self.graduateTimeLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *graduateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeGraduate)];
    [self.graduateTimeLabel addGestureRecognizer:graduateGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view
- (void)initAvatar {
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"]];
    [self.avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    // 设置layer对象的圆角半径。将方形图像变成圆形图像，半径应设置为UIImageView宽度的一半。
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    // 必须将clipsToBounds属性设置为YES，layer才能生效。
    self.avatarImageView.clipsToBounds = YES;
    
    //设置边框的宽度和边框颜色
    self.avatarImageView.layer.borderWidth = 3.0f;
    self.avatarImageView.layer.borderColor = [UIColor grayColor].CGColor;
}

#pragma mark - action
- (IBAction)nextBtnClick:(UIBarButtonItem *)sender {
    [_nameField resignFirstResponder];
    
    if ([_nameField.text length] == 0) {
        _nameField.backgroundColor = [UIColor redColor];
        return;
    } else if ([_genderLabel.text length] == 0) {
        _genderLabel.backgroundColor = [UIColor redColor];
        return;
    } else if ([_highestDegreeLabel.text length] == 0) {
        _highestDegreeLabel.backgroundColor = [UIColor redColor];
        return;
    } else if ([_graduateTimeLabel.text length] == 0) {
        _graduateTimeLabel.backgroundColor = [UIColor redColor];
        return;
    }
    
    UniversityInfoViewController *universityController = [ControllerManager viewControllerInSettingStoryboard:@"UniversityInfoViewController"];
    universityController.highestDegree = _highestDegree;
    universityController.currentDegree = _highestDegree;
    
    [self.navigationController pushViewController:universityController animated:YES];
}

- (void)chooseEditAvatar {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

- (void)changeGender {
    [_nameField resignFirstResponder];
    
    if (!_genderPickerView) {
        NSArray *genderData = @[[GenderInfo genderName:Male], [GenderInfo genderName:Female]];

        _genderPickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:genderData delegate:self];
        _genderPickerView = [[PickerView alloc]initWithDelegate:_genderPickerDelegate withDataSource:_genderPickerDelegate];
    }
    
    [_genderPickerView showInView:self.view withBlur:YES];
}

- (void)changeHighestDegree {
    [_nameField resignFirstResponder];
    
    if (!_degreePickerView) {
        NSArray *degreeData = @[[DegreeInfo degreeName:Bachelor], [DegreeInfo degreeName:Master], [DegreeInfo degreeName:Doctor]];
        _degreePickerDelegate = [[SingerPickerViewDelegate alloc] initWithData:degreeData delegate:self];
        _degreePickerView = [[PickerView alloc]initWithDelegate:_degreePickerDelegate withDataSource:_degreePickerDelegate];
    }
    
    [_degreePickerView showInView:self.view withBlur:YES];
}

- (void)changeGraduate {
    [_nameField resignFirstResponder];
    
    if (!_datePicker) {
        _datePicker = [[DatePicker alloc] initWithDelegate:self];
    }
    
    NSDate *date = [NSDate date];
    [_datePicker setDate:date withMode:UIDatePickerModeDate];
    [_datePicker showInView:self.view withBlur:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([CameraUtil isCameraAvailable] && [CameraUtil isCameraSupportTakingPhoto]) {
            UIImagePickerController *cameraController = [[UIImagePickerController alloc] init];
            cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            //设置为前置摄像头
            if ([CameraUtil isFrontCameraAvailable]) {
                cameraController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            
            //指定拍照类型为照片
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            cameraController.mediaTypes = mediaTypes;
            
            cameraController.delegate = self;
            
            [self presentViewController:cameraController animated:YES completion:^{
                //camera presented
            }];
        } else {
            NSLog(@"Camera is not available.");
        }
    } else if (buttonIndex == 1) {
        //从相册中选取
        if ([CameraUtil isPhotoLibraryAvailable]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //指定选取的类型为照片
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            picker.mediaTypes = mediaTypes;
            
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:^{
                //image picker presented
            }];
        } else {
            NSLog(@"Photo library is not available.");
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *selectedImg = info[UIImagePickerControllerOriginalImage];
        selectedImg = [AvatarUtil imageScalingToMaxSize:selectedImg];
        
        ImageCropperViewController *imageCropperController = [[ImageCropperViewController alloc] initWithImage:selectedImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3];
        imageCropperController.delegate = self;
        
        [self presentViewController:imageCropperController animated:YES completion:^{
            //image copper presented
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        //do nothing for cancel image picker
    }];
}

#pragma mark - ImageCropperDelegate
- (void)imageCropper:(ImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    NSData *imgData = UIImagePNGRepresentation(editedImage);
    
    if (imgData) {
        //TODO: upload image
        [self.avatarImageView setImage:editedImage];
    }
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // copped image
    }];
}

- (void)imageCropperDidCancel:(ImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        //cancel image 
    }];
}

#pragma mark - SingerPickerDelegate
- (void)pickValueDone:(id)sender data:(NSString *)pickedValue {
    if (_genderPickerView == sender) {
        self.genderLabel.text = pickedValue;
    } else if (_degreePickerView == sender) {
        _highestDegree = [DegreeInfo degree:pickedValue];
        self.highestDegreeLabel.text = pickedValue;
    }
}

#pragma mark - DatePickerDelegate
- (void)onDatePickDone:(id)sender date:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.locale = locale;
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    self.graduateTimeLabel.text = dateString;
}

@end
