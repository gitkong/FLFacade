//
//  FLFacade.m
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "FLFacade.h"
#import <StoreKit/StoreKit.h>
#import "UIApplication+TopViewController.h"
#import "UINavigationController+Jump.h"

#define APPLICATION [UIApplication sharedApplication]

@interface FLFacade ()<SKStoreProductViewControllerDelegate>

@end

@implementation FLFacade

+ (instancetype)shareManager {
    static FLFacade *facade = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        facade = [[self alloc] init];
    });
    return facade;
}

- (void)openAppWithUrl:(NSString *)urlString options:(NSDictionary<NSString *, id> *)options complete:(void(^)(BOOL success))complete {
    if (!urlString) return;
    NSURL *url = [NSURL URLWithString:urlString];
    if ([APPLICATION canOpenURL:url]) {
        if ([[[UIDevice currentDevice] systemVersion] compare:@"10.0" options:NSNumericSearch] == NSOrderedAscending) {
            BOOL success = [APPLICATION openURL:url];
            if (complete) {
                complete(success);
            }
        }
        else {
            [APPLICATION openURL:url options:options ? options : @{} completionHandler:^(BOOL success) {
                if (complete) {
                    complete(success);
                }
            }];
        }
    }
    else {
        if (complete) {
            complete(NO);
        }
    }
}

- (void)openAppleStoreWithIdentifier:(NSString *)identifier complete:(void(^)(BOOL success))complete {
    SKStoreProductViewController *appStore = [[SKStoreProductViewController alloc] init];
    appStore.delegate = self;
    // 先去跳转再去加载页面，优化体验
    [self presentViewController:appStore animated:YES complete:nil];
    [appStore loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : identifier} completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (complete) {
            complete(!error);
        }
    }];
}

#pragma mark - Push

- (void)popToIndex:(NSInteger)index thenPushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController popToIndex:index thenPushViewController:viewController animated:animated complete:complete];
    }
}

- (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController animated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated complete:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack {
    [self pushViewController:viewController animated:animated needBack:needBack complete:nil];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack complete:(void(^)())complete {
    [self pushViewController:viewController animated:animated needBack:needBack needReload:YES complete:complete];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    [self pushViewController:viewController animated:animated needReload:NO complete:complete];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needReload:(BOOL)needReload complete:(void(^)())complete {
    [self pushViewController:viewController animated:animated needBack:YES needReload:needReload complete:complete];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack needReload:(BOOL)needReload complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController pushViewController:viewController animated:animated needBack:needBack needReload:needReload complete:complete];
    }
}

#pragma mark - Pop

- (void)popViewController {
    [self popViewControllerAnimated:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated {
    [self popToRootViewControllerAnimated:animated complete:nil];
}

- (void)popViewControllerAnimated:(BOOL)animated complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController popViewControllerAnimated:animated complete:complete];
    }
}

- (void)popToRootViewControllerAnimated:(BOOL)animated complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController popToRootViewControllerAnimated:animated complete:complete];
    }
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController popToViewController:viewController animated:animated complete:complete];
    }
}

- (void)popToIndex:(NSInteger)index animated:(BOOL)animated complete:(void(^)())complete {
    if (self.currentNavigationController) {
        [self.currentNavigationController popToIndex:index animated:animated complete:complete];
    }
}

#pragma mark - Present

- (void)presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES];
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self presentViewController:viewController animated:animated complete:nil];
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete {
    if (viewController && self.currentViewController && self.currentViewController != viewController) {
        if (self.currentPresentStackController) {
            [self.currentPresentStackController presentViewController:viewController animated:animated completion:complete];
        }
        else {
            [self.currentViewController presentViewController:viewController animated:animated completion:complete];
        }
    }
}

#pragma mark - Dismiss

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES];
}

- (void)dismissViewControllerAnimated: (BOOL)animated {
    [self dismissToRootViewControllerAnimated:animated completion:nil];
}

- (void)dismissViewControllerAnimated: (BOOL)animated completion: (void (^)())completion {
    if (self.currentViewController) {
        if (self.currentPresentStackController) {
            [self.currentPresentStackController dismissViewControllerAnimated:animated completion:completion];
        }
        else {
            [self.currentViewController dismissViewControllerAnimated:animated completion:completion];
        }
    }
}

- (void)dismissToRootViewControllerAnimated: (BOOL)animated completion: (void (^)())completion {
    if (self.currentViewController && self.currentPresentStackController) {
        [self.currentPresentStackController dismissToRootViewControllerAnimated:animated completion:completion];
    }
}

- (void)dismissToIndex:(NSInteger)index animated: (BOOL)animated completion: (void (^)())completion {
    if (self.currentViewController && self.currentPresentStackController) {
        [self.currentPresentStackController dismissToIndex:index animated:animated completion:completion];
    }
}

- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)animated completion: (void (^)())completion {
    if (viewController && self.currentViewController && self.currentViewController != viewController && self.currentPresentStackController) {
        [self.currentPresentStackController dismissToViewController:viewController animated:animated completion:completion];
    }
}

#pragma mark Embed 

- (void)embedViewController:(UIViewController *)vc {
    [self embedViewController:vc completion:nil];
}

- (void)embedViewController:(UIViewController *)vc completion:(void (^)())completion {
    [self embedViewController:vc animateType:FLFacadeAnimateTypeFade duration:0.25 completion:completion];
}

- (void)embedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    [self embedViewController:vc inParentViewController:self.currentViewController animateType:animateType duration:duration completion:completion];
}

- (void)embedViewController:(UIViewController *)vc inParentViewController:(UIViewController *)parentVC animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    if (vc.parentViewController == parentVC) {
        return;
    }
    
    [parentVC addChildViewController:vc];
    
    [vc willMoveToParentViewController:parentVC];
    vc.view.frame = parentVC.view.bounds;
    [parentVC.view addSubview:vc.view];
    
    if (animateType == FLFacadeAnimateTypeNone) {
        [vc didMoveToParentViewController:parentVC];
    }
    else if([self isFadeAnimate:animateType]) {
        [self fadeAnimateWithView:vc.view animateType:animateType duration:duration isEmbedAnimated:YES completion:^{
            [vc didMoveToParentViewController:parentVC];
        }];
    }
    else {
        [self transitionWithView:parentVC.view animateType:animateType duration:duration isEmbedAnimated:YES completion:^{
            [vc didMoveToParentViewController:parentVC];
        }];
    }
    if (completion) {
        completion();
    }
}

- (void)removeEmbedViewController {
    [self removeEmbedViewControllerCompletion:nil];
}

- (void)removeEmbedViewControllerCompletion:(void (^)())completion {
    [self removeEmbedViewController:self.currentViewController.childViewControllers.lastObject completion:completion];
}

- (void)removeEmbedViewController:(UIViewController *)vc completion:(void (^)())completion {
    [self removeEmbedViewController:vc animateType:FLFacadeAnimateTypeFade duration:0.25 completion:completion];
}

- (void)removeEmbedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    if (animateType == FLFacadeAnimateTypeNone) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    else if([self isFadeAnimate:animateType]) {
        [self fadeAnimateWithView:vc.view animateType:animateType duration:duration isEmbedAnimated:NO completion:^{
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
        }];
    }
    else {
        [self transitionWithView:vc.view animateType:animateType duration:duration isEmbedAnimated:NO completion:^{
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
        }];
    }
    if (completion) {
        completion();
    }
    
}

#pragma mark private method

- (BOOL)isFadeAnimate:(FLFacadeAnimateType)animateType {
    return animateType == FLFacadeAnimateTypeFade || animateType == FLFacadeAnimateTypeFadeFromTop || animateType == FLFacadeAnimateTypeFlipFromBottom || animateType == FLFacadeAnimateTypeFadeFromLeft || animateType == FLFacadeAnimateTypeFadeFromRight;
}

- (void)fadeAnimateWithView:(UIView *)view animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration isEmbedAnimated:(BOOL)embedAnimated completion:(void (^)())completion {
    view.alpha = embedAnimated ? 0.0 : 1.0;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = embedAnimated ? 1.0 : 0.0;
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)transitionWithView:(UIView *)view animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration isEmbedAnimated:(BOOL)embedAnimated completion:(void (^)())completion {
    if (animateType < FLFacadeAnimateTypeFlipFromLeft) {
        return;
    }
    UIViewAnimationOptions options = UIViewAnimationOptionTransitionNone;
    if (animateType == FLFacadeAnimateTypeFlipFromLeft) {
        options = UIViewAnimationOptionTransitionFlipFromLeft;
    }
    else if (animateType == FLFacadeAnimateTypeFlipFromRight) {
        options = UIViewAnimationOptionTransitionFlipFromRight;
    }
    else if (animateType == FLFacadeAnimateTypeFlipFromTop) {
        options = UIViewAnimationOptionTransitionFlipFromTop;
    }
    else if (animateType == FLFacadeAnimateTypeFlipFromBottom) {
        options = UIViewAnimationOptionTransitionFlipFromBottom;
    }
    else if (animateType == FLFacadeAnimateTypeCurlUp) {
        options = UIViewAnimationOptionTransitionCurlUp;
    }
    else if (animateType == FLFacadeAnimateTypeCurlDown) {
        options = UIViewAnimationOptionTransitionCurlDown;
    }
    else if (animateType == FLFacadeAnimateTypeCrossDissolve) {
        options = UIViewAnimationOptionTransitionCrossDissolve;
    }
    if (!embedAnimated) {
        view.alpha = 1.0;
    }
    [UIView transitionWithView:view duration:duration options:options animations:^{
        if (!embedAnimated) {
            view.alpha = 0.0;
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter & Getter

- (UIViewController *)currentViewController {
    return APPLICATION.topViewController;
}

- (UINavigationController *)currentNavigationController {
    return self.currentViewController.navigationController;
}

- (FLPresentStackController *)currentPresentStackController {
    return self.currentViewController.presentStackController;
}

- (UITabBarController *)currentTabBarController {
    return self.currentViewController.tabBarController;
}

@end
