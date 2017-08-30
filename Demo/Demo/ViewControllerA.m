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
#import "PushViewController.h"
@interface ViewControllerA ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"VC-A";
    if (self.isEmbed) {
        [self.view addSubview:self.tableView];
    }
    else {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"点我去第二个界面";
        label.center = self.view.center;
        [label sizeToFit];
        [self.view addSubview:label];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 200, 30)];
        btn.backgroundColor = [UIColor brownColor];
        [btn setTitle:@"回到第一个界面" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)back {
    if (self.isFromPrsent) {
        [FACADE dismissViewController];
    }
    else {
        [FACADE popViewController];
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewControllerB *vc = [[ViewControllerB alloc] init];
    vc.isFromPrsent = self.isFromPrsent;
    if (self.isEmbed) {
        [FACADE removeEmbedViewControllerWithAnimateType:FLFacadeAnimateTypeFade duration:1.25 completion:nil];
    }
    else {
        if (self.isFromPrsent) {
            [FACADE presentViewController:vc];
        }
        else {
            if (self.isNormalPush) {
                vc.isNeedPopBack = YES;
                [FACADE pushViewController:vc];
            }
            else {
                PushViewController *pushVc = [FACADE viewControllerBy:[PushViewController class]];
                if (!pushVc) {
                    pushVc = [[PushViewController alloc] init];
                }
                pushVc.isNewVc = YES;
                
                [FACADE pushViewController:pushVc animated:YES needBack:self.isNeedPopBack needReload:self.isNeedReload complete:nil];
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.dataSource) {
        return 0;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.dataSource) {
        return;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataSource[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [FACADE removeEmbedViewControllerWithAnimateType:indexPath.row duration:1.25 completion:nil];
}

#pragma mark - Setter & Getter


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 60, 0);
    }
    return _tableView;
}


- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[@"Remove None",
                        @"Remove Fade",
                        @"Remove FadeFromLeft",
                        @"Remove FadeFromRight",
                        @"Remove FadeFromTop",
                        @"Remove FadeFromBottom",
                        @"Remove FadeByScaleSmall",
                        @"Remove FadeByScaleBig",
                        @"Remove FlipFromLeft",
                        @"Remove FlipFromRight",
                        @"Remove FlipFromTop",
                        @"Remove FlipFromBottom",
                        @"Remove CurlUp",
                        @"Remove CurlDown",
                        @"Remove CrossDissolve"
                        ];
    }
    return _dataSource;
}

@end
