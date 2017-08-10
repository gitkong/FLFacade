//
//  UINavigationController+Jump.m
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "UINavigationController+Jump.h"
#import "UIViewController+NavStack.h"

@implementation UINavigationController (Jump)

#pragma mark - Push

- (void)popToIndex:(NSInteger)index thenPushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    [self popToIndex:index thenPushViewController:viewController needBack:NO needReload:NO animated:animated complete:complete];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack needReload:(BOOL)needReload complete:(void(^)())complete {
    if (viewController == nil || viewController == self.topViewController) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    if (needBack) {
        __block BOOL isJump = NO;
        [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([obj isKindOfClass:[viewController class]]) {
                NSInteger index = idx;
                if (needReload) {
                    if (index > 1) {
                        index--;
                    }
                }
                [strongSelf popToIndex:index thenPushViewController:viewController needBack:needBack needReload:needReload animated:animated complete:complete];
                isJump = YES;
                *stop = YES;
            }
        }];
        if (!isJump) {
            [self normalPushViewController:viewController animated:animated complete:complete];
        }
    }
    else {
        [self normalPushViewController:viewController animated:animated complete:complete];
    }
}

#pragma mark - Pop

- (void)popViewControllerAnimated:(BOOL)animated complete:(void(^)())complete {
    if (self.viewControllers.count < 2) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self dispatch_afterViewControllerTransitionComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf popViewControllerAnimated:animated];
    }];
    if (complete) {
        complete();
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated complete:(void(^)())complete {
    __weak typeof(self) weakSelf = self;
    [self dispatch_afterViewControllerTransitionComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf popToRootViewControllerAnimated:animated];
    }];
    if (complete) {
        complete();
    }
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    if (!viewController || self.viewControllers.count < 2 || !viewController.isExistAtNavStack) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self dispatch_afterViewControllerTransitionComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
         [strongSelf popToViewController:viewController animated:animated];
    }];
    if (complete) {
        complete();
    }
}

- (void)popToIndex:(NSInteger)index animated:(BOOL)animated complete:(void(^)())complete {
    if (self.viewControllers.count < 1 || index >= self.viewControllers.count) {
        return;
    }
    UIViewController *vc = self.viewControllers[index];
    [self popToViewController:vc animated:animated complete:complete];
}

#pragma mark - Private Method

- (void)popToIndex:(NSInteger)index thenPushViewController:(UIViewController *)viewController needBack:(BOOL)needBack needReload:(BOOL)needReload animated:(BOOL)animated complete:(void(^)())complete {
    NSArray *sourceViewControllers = self.viewControllers;
    if (index >= sourceViewControllers.count || viewController == nil || self.topViewController == viewController) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self dispatch_afterViewControllerTransitionComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray<UIViewController *> *arrM = [NSMutableArray arrayWithArray:sourceViewControllers];
        [sourceViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx > index) {
                [arrM removeObject:obj];
            }
        }];
        if (needBack) {
            if (needReload) {
                // 数据会刷新效果待优化
                [strongSelf setViewControllers:arrM animated:animated];
                [arrM addObject:viewController];
                [strongSelf setViewControllers:arrM animated:NO];
                if (index == 0) {
                    [arrM removeObjectAtIndex:index];
                    [strongSelf setViewControllers:arrM animated:NO];
                }
            }
            else {
                [strongSelf setViewControllers:arrM animated:animated];
            }
        }
        else {
            [arrM addObject:viewController];
            [strongSelf setViewControllers:arrM animated:animated];
        }
    }];
    if (complete) {
        complete();
    }
}

- (void)normalPushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    __weak typeof(self) weakSelf = self;
    [self dispatch_afterViewControllerTransitionComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf pushViewController:viewController animated:animated];
    }];
    if (complete) {
        complete();
    }
}

- (void)dispatch_afterViewControllerTransitionComplete:(void(^)())complete {
    NSNumber *isViewControllerTransiting = (NSNumber *)[self valueForKey:@"interactiveTransition"];
    if (isViewControllerTransiting && isViewControllerTransiting.boolValue) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (complete) {
                complete();
            }
        });
        return;
    }
    if (complete) {
        complete();
    }
}

@end
