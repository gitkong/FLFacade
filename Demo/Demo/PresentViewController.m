//
//  PresentViewController.m
//  Demo
//
//  Created by 孔凡列 on 2017/7/13.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "PresentViewController.h"
#import "FLFacade.h"
#import "ViewControllerA.h"
@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"系统控制，只能单层dismiss", @"PresentStack控制，可多层任意dismiss"];
}

- (void)didSelectRow:(NSInteger)row {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    vc.isFromPrsent = YES;
    if (row == 0) {
        // 不使用PresentStatcController，就跟下面做法一样
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        [FACADE presentViewController:vc];
    }
}

@end
