//
//  ViewControllerA.m
//  Demo
//
//  Created by 孔凡列 on 2017/7/13.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "ViewControllerA.h"
#import "FLFacade.h"
#import "ViewControllerB.h"
@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = NSStringFromClass(self.class);
    label.center = self.view.center;
    [label sizeToFit];
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewControllerB *vc = [[ViewControllerB alloc] init];
    vc.isFromPrsent = self.isFromPrsent;
//    if (self.isFromPrsent) {
//        [FACADE presentViewController:vc];
//    }
//    else {
//        [FACADE pushViewController:vc];
//    }
    [FACADE removeEmbedViewController];
}

@end
