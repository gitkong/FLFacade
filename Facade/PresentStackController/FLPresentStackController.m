//
//  FLPresentStackController.m
//  TestPush
//
//  Created by 孔凡列 on 2017/7/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "FLPresentStackController.h"
#import "UIViewController+PresentStack.h"

@interface FLPresentStackController ()

@property (nonatomic, strong) NSMutableArray<UIViewController *> *statckControllers;

@end

@implementation FLPresentStackController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        self.statckControllers = [NSMutableArray array];
        if (rootViewController) {
            rootViewController.presentStackController = self;
            [self.statckControllers addObject:rootViewController];
            self.view.backgroundColor = rootViewController.view.backgroundColor;
            [self.view addSubview:rootViewController.view];
        }
    }
    return self;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion {
    if (self.statckControllers && viewControllerToPresent) {
        viewControllerToPresent.presentStackController = self;
        [self.topViewController presentViewController:viewControllerToPresent animated:flag completion:nil];
        [self.statckControllers addObject:viewControllerToPresent];
        if (completion) {
            completion();
        }
    }
}

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion {
    [self dismissToIndex:self.statckControllers.count - 2 animated:flag completion:completion];
}

- (void)dismissToRootViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion {
    [self dismissToIndex:0 animated:flag completion:completion];
}

- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)flag completion: (void (^)(void))completion {
    [self dismissToIndex:viewController.indexAtPresentStack animated:flag completion:completion];
}

- (void)dismissToIndex:(NSInteger)index animated: (BOOL)flag completion: (void (^)(void))completion {
    if (self.statckControllers && self.statckControllers.count && index >= 0 && index < self.statckControllers.count)  {
        NSInteger nextIndex = index + 1;
        if (nextIndex >= self.statckControllers.count) {
            return;
        }
        UIView *contentView = self.topViewController.presentContentView;
        UIViewController *currentViewController = self.statckControllers[index];
        UIViewController *nextViewController = self.statckControllers[nextIndex];
        if (contentView) {
            [nextViewController.view addSubview:contentView];
            [nextViewController.view bringSubviewToFront:contentView];
        }
        [currentViewController dismissViewControllerAnimated:flag completion:^{
            [contentView removeFromSuperview];
        }];
        NSArray<UIViewController *> *tempArr = [NSArray arrayWithArray:self.statckControllers];
        [tempArr enumerateObjectsUsingBlock:^(UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx > index) {
                self.topViewController.presentStackController = nil;
                [self.statckControllers removeObject:vc];
            }
        }];
        if (completion) {
            completion();
        }
    }
}

#pragma mark - Setter & Getter

- (NSArray<UIViewController *> *)viewControllers {
    return self.statckControllers.copy;
}

- (UIViewController *)topViewController {
    if (self.statckControllers && self.statckControllers.count) {
        return self.statckControllers.lastObject;
    }
    return nil;
}

- (UIViewController *)visibleViewController {
    return self.topViewController;
}

@end
