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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"gitKong";
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点我跳转";
    label.textColor = [UIColor redColor];
    label.center = self.view.center;
    [label sizeToFit];
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    vc.isFromPrsent = NO;
    [FACADE pushViewController:vc];
}

@end
