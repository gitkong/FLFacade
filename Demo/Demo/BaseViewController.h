//
//  BaseViewController.h
//  Demo
//
//  Created by 孔凡列 on 2017/8/4.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong, readonly) UITableView * tableView;

@property (nonatomic, strong) NSArray <NSString *>* dataSource;

- (void)didSelectRow:(NSInteger)row;

@end
