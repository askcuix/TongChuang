//
//  MatchFriendsViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/8/3.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "MatchFriendsViewController.h"
#import "ControllerManager.h"
#import "RecommendListViewController.h"

@interface MatchFriendsViewController () {
    NSTimer *spinTimer;
}

@property (weak, nonatomic) IBOutlet UIImageView *radarImgView;

@end

@implementation MatchFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self spinImage:self.radarImgView];
    
    spinTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(findResultDone) userInfo:nil repeats:NO];
}

- (void)spinImage:(UIImageView *)imageView {
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕，顺时针旋转
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = YES;
    
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [imageView.layer addAnimation:animation forKey:nil ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (void)findResultDone {
    [self.radarImgView.layer removeAllAnimations];
    
    [spinTimer invalidate];
    
    RecommendListViewController *recommendController = [ControllerManager viewControllerInSettingStoryboard:@"RecommendListViewController"];
    [self.navigationController pushViewController:recommendController animated:YES];
}

@end
