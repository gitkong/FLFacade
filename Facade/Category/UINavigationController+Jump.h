//
//  UINavigationController+Jump.h
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Jump)

#pragma mark - Push

- (void)popToIndex:(NSInteger)index thenPushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack needReload:(BOOL)needReload complete:(void(^)())complete;

#pragma mark - Pop

- (void)popViewControllerAnimated:(BOOL)animated complete:(void(^)())complete;

- (void)popToRootViewControllerAnimated:(BOOL)animated complete:(void(^)())complete;

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

- (void)popToIndex:(NSInteger)index animated:(BOOL)animated complete:(void(^)())complete;

@end
