//
//  UIApplication+TopViewController.m
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "UIApplication+TopViewController.h"
#import "UIViewController+PresentStack.h"

@implementation UIApplication (TopViewController)

- (UIViewController *)topViewController {
//    return [self visibleViewControllerFrom:self.keyWindow.rootViewController];
    // 修复：出现弹出导致keywindow改变，获取控制器有误
    return [self visibleViewControllerFrom:self.delegate.window.rootViewController];
}

- (UIViewController *)visibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVc = (UINavigationController *)vc;
        return [self visibleViewControllerFrom:navVc.visibleViewController];
    }
    else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVc = (UITabBarController *)vc;
        return [self visibleViewControllerFrom:tabVc.selectedViewController];
    }
    else if ([vc isKindOfClass:[FLPresentStackController class]]) {
        FLPresentStackController *presentStackVc = (FLPresentStackController *)vc;
        return [self visibleViewControllerFrom:presentStackVc.visibleViewController];
    }
    else if (vc.presentedViewController) {
        return [self visibleViewControllerFrom:vc.presentedViewController];
    }
    return vc;
}

@end
