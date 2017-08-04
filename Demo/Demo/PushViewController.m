//
//  PushViewController.m
//  Demo
//
//  Created by 孔凡列 on 2017/7/13.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "PushViewController.h"
#import "ViewControllerA.h"
#import "FLFacade.h"
@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"正常跳转", @"同名控制器-跳转返回", @"同名控制器-跳转不返回"];
}

- (void)didSelectRow:(NSInteger)row {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    vc.isFromPrsent = NO;
    if (row == 0) {
        vc.isNormalPush = YES;
    }
    else if (row == 1) {
        vc.isNeedPopBack = YES;
        
    }
    else if (row == 2) {
        
    }
    [FACADE pushViewController:vc];
}


@end
