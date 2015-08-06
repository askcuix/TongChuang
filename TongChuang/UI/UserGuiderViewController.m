//
//  UserGuiderViewController.m
//  TongChuang
//
//  Created by cuixiang on 15/7/13.
//  Copyright (c) 2015年 Chris. All rights reserved.
//

#import "UserGuiderViewController.h"

@interface UserGuiderViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation UserGuiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initGuide];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view
- (void)initGuide {
    CGSize scrollViewSize = _scrollView.bounds.size;
    _scrollView.contentSize = CGSizeMake(scrollViewSize.width * 3, scrollViewSize.height);
    _scrollView.pagingEnabled = YES; //if not enable will display as as single image
    
    for (int i = 0; i < 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"guide_%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        
        [_scrollView addSubview:imageView];
        
        if (i == 2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"进入" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            CGFloat xoffsex = 2*scrollViewSize.width + (scrollViewSize.width - 213)/2;
            CGFloat yoffsex = scrollViewSize.height - 180;
            button.frame = CGRectMake(xoffsex, yoffsex, 213, 71);
            
            [button setTintColor:[UIColor whiteColor]];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0]];
            button.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
            button.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
            button.layer.borderWidth =.5;
            button.layer.cornerRadius = 15;
            
            [_scrollView addSubview:button];
        }
    }
    
}

#pragma mark - action
- (void)enterBtnClick {
    if (_delegate && [_delegate respondsToSelector:@selector(userGuideCompleted)]) {
        [_delegate userGuideCompleted];
    }
}

@end
