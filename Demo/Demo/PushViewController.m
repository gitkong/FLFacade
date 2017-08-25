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
#import "UIImage+Facade.h"
@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"正常跳转", @"同名控制器-跳转返回-重新加载", @"同名控制器-跳转返回-不重新加载",@"同名控制器-跳转不返回"];
    NSLog(@"我是否重新加载了,%zd",self.isNewVc);
    self.navigationItem.title = @"gitKong";
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithTitle:@"url" style:UIBarButtonItemStyleDone target:self action:@selector(urlParams)],
                                                [[UIBarButtonItem alloc] initWithTitle:@"options" style:UIBarButtonItemStyleDone target:self action:@selector(optionsParams)]
                                                ];
}

- (void)urlParams {
    //params?param1=111&param2=222
//    [FACADE openAppWithUrlScheme:@"TestJump://name=gitKong&content=hello world" params:nil complete:^(BOOL success) {
//        
//    }];
    
    UIImage *image = [UIImage imageNamed:@"爵 续费0001"];
    NSString *imageStr = image.PNGBase64String;
    
    [FACADE openAppWithUrlScheme:@"TestJump://name=gitKong&content=hello world" params:@{@"name" : @"lie", @"msg" : @"我是内容", @"imageStr" : imageStr} complete:^(BOOL success) {
        
    }];
}

- (void)optionsParams {
    
//    NSLog(@"%@",[FACADE paramsByOpenAppWithUrl:@"TestJump://name=凡大叔&lover=小洁猪&content=loveforever&"]);
    
    [FACADE openAppWithUrlScheme:@"TestJump://openurl" params:@{@"name" : @"gitKong", @"msg" : @"我也是内容", @"" : @"xxx"} complete:^(BOOL success) {
        
    }];
    
}

- (void)didSelectRow:(NSInteger)row {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    vc.isFromPrsent = NO;
    if (row == 0) {
        vc.isNormalPush = YES;
        vc.isNeedPopBack = NO;
    }
    else if (row == 1) {
        vc.isNeedPopBack = YES;
        vc.isNeedReload = YES;
    }
    else if (row == 2) {
        vc.isNeedPopBack = YES;
    }
    else if (row == 2) {
        vc.isNeedPopBack = NO;
    }
    [FACADE pushViewController:vc];
}


@end
