//
//  ViewControllerC.m
//  Demo
//
//  Created by 孔凡列 on 2017/8/11.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewControllerC.h"
#import "FLFacade.h"
#import "ViewControllerA.h"
@interface ViewControllerC ()

@end

@implementation ViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"VC-C";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    [FACADE pushViewController:vc animated:YES needReload:YES complete:nil];
}

@end
