//
//  EmbedViewController.m
//  Demo
//
//  Created by 孔凡列 on 2017/8/4.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "EmbedViewController.h"
#import "ViewControllerA.h"
#import "FLFacade.h"

@interface EmbedViewController ()

@end

@implementation EmbedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.navigationItem.title = @"gitKong";
    self.dataSource = @[@"Embed None",
                        @"Embed Fade",
                        @"Embed FadeFromLeft",
                        @"Embed FadeFromRight",
                        @"Embed FadeFromTop",
                        @"Embed FadeFromBottom",
                        @"Embed FadeByScaleSmall",
                        @"Embed FadeByScaleBig",
                        @"Embed FlipFromLeft",
                        @"Embed FlipFromRight",
                        @"Embed FlipFromTop",
                        @"Embed FlipFromBottom",
                        @"Embed CurlUp",
                        @"Embed CurlDown",
                        @"Embed CrossDissolve"
                        ];
}

- (void)didSelectRow:(NSInteger)row {
    ViewControllerA *vc = [[ViewControllerA alloc] init];
    vc.isEmbed = YES;
    [FACADE embedViewController:vc animateType:row duration:1.25 completion:nil];
    
}

@end
