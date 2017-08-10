//
//  ViewControllerB.m
//  Demo
//
//  Created by 孔凡列 on 2017/7/13.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "ViewControllerB.h"
#import "FLFacade.h"
#import "PushViewController.h"
@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点我回到第一个界面";
    label.center = self.view.center;
    [label sizeToFit];
    // 最后present的conntroller中的子控件需要添加到presentContentView
    [self.presentContentView addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isFromPrsent) {
        [FACADE dismissToRootViewControllerAnimated:YES completion:nil];
    }
    else {
        [FACADE popToRootViewControllerAnimated:YES complete:nil];
    }
}

@end
