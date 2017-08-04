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

static CGFloat KDefault_Animate_Duration = 0.25f;

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
            [self systemDismissAnimated:animated completion:completion];
        }
    }
}

- (void)dismissToRootViewControllerAnimated: (BOOL)animated completion: (void (^)())completion {
    if (self.currentViewController) {
        if (self.currentPresentStackController) {
            [self.currentPresentStackController dismissToRootViewControllerAnimated:animated completion:completion];
        }
        else {
            [self systemDismissAnimated:animated completion:completion];
        }
    }
}

- (void)dismissToIndex:(NSInteger)index animated: (BOOL)animated completion: (void (^)())completion {
    if (self.currentViewController) {
        if (self.currentPresentStackController) {
            [self.currentPresentStackController dismissToIndex:index animated:animated completion:completion];
        }
        else {
            [self systemDismissAnimated:animated completion:completion];
        }
    }
}

- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)animated completion: (void (^)())completion {
    if (viewController && self.currentViewController && self.currentViewController != viewController) {
        if (self.currentPresentStackController) {
            [self.currentPresentStackController dismissToViewController:viewController animated:animated completion:completion];
        }
        else {
            [self systemDismissAnimated:animated completion:completion];
        }
    }
}

#pragma mark - Embed 

- (void)embedViewController:(UIViewController *)vc {
    [self embedViewController:vc completion:nil];
}

- (void)embedViewController:(UIViewController *)vc completion:(void (^)())completion {
    [self embedViewController:vc animateType:FLFacadeAnimateTypeFade completion:completion];
}

- (void)embedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion {
    [self embedViewController:vc animateType:animateType duration:KDefault_Animate_Duration completion:completion];
}

- (void)embedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    [self embedViewController:vc inParentViewController:self.currentViewController animateType:animateType duration:duration completion:completion];
}

- (void)embedViewController:(UIViewController *)vc inParentViewController:(UIViewController *)parentVC animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    if (vc.parentViewController == parentVC || [self isEmbedViewController:vc isExitAt:parentVC needJudgePrecision:NO]) {
        return;
    }
    
    [parentVC addChildViewController:vc];
    
    [vc willMoveToParentViewController:parentVC];
    
    [self embedView:vc.view atParentView:parentVC.view animateType:animateType];
    
    if (animateType == FLFacadeAnimateTypeNone) {
        [vc didMoveToParentViewController:parentVC];
    }
    else if([self isFadeAnimate:animateType]) {
        [self fadeAnimateWithView:vc.view atParentView:parentVC.view animateType:animateType duration:duration isEmbedAnimated:YES completion:^{
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

#pragma mark - Remve Embed

- (void)removeEmbedViewController {
    [self removeEmbedViewControllerCompletion:nil];
}

- (void)removeEmbedViewControllerCompletion:(void (^)())completion {
    [self removeEmbedViewController:self.currentViewController.childViewControllers.lastObject completion:completion];
}

- (void)removeEmbedViewControllerWithAnimateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion {
    [self removeEmbedViewControllerWithAnimateType:animateType duration:KDefault_Animate_Duration completion:completion];
}

- (void)removeEmbedViewControllerWithAnimateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    [self removeEmbedViewController:self.currentViewController.childViewControllers.lastObject animateType:animateType duration:duration completion:completion];
}

- (void)removeEmbedViewController:(UIViewController *)vc completion:(void (^)())completion {
    [self removeEmbedViewController:vc animateType:FLFacadeAnimateTypeFade completion:completion];
}

- (void)removeEmbedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion {
    [self removeEmbedViewController:vc animateType:animateType duration:KDefault_Animate_Duration completion:completion];
}

- (void)removeEmbedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion {
    if (!vc || !vc.parentViewController) return;
    if (animateType == FLFacadeAnimateTypeNone) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    else if([self isFadeAnimate:animateType]) {
        [self fadeAnimateWithView:vc.view atParentView:vc.view.superview animateType:animateType duration:duration isEmbedAnimated:NO completion:^{
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

#pragma mark - private method

- (void)systemDismissAnimated:(BOOL)animated completion:(void (^)())completion {
    [self.currentViewController dismissViewControllerAnimated:animated completion:completion];
}

- (BOOL)isEmbedViewController:(UIViewController *)targetVc isExitAt:(UIViewController *)parentVc needJudgePrecision:(BOOL)needJudgePrecision {
    if (!parentVc || !targetVc) {
        return NO;
    }
    BOOL isExist = NO;
    for (UIViewController *vc in parentVc.childViewControllers) {
        if (needJudgePrecision) {
            if (vc == targetVc) {
                isExist = YES;
                break;
            }
        }
        else {
            if ([vc isKindOfClass:[targetVc class]]) {
                isExist = YES;
                break;
            }
        }
    }
    return isExist;
}

- (void)embedView:(UIView *)view atParentView:(UIView *)parentView animateType:(FLFacadeAnimateType)animateType {
    CGFloat width = parentView.bounds.size.width;
    CGFloat height = parentView.bounds.size.height;
    [parentView addSubview:view];
    
    if (animateType == FLFacadeAnimateTypeFadeFromLeft) {
        view.frame = CGRectMake(-width, 0, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromRight) {
        view.frame = CGRectMake(width, 0, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromTop) {
        view.frame = CGRectMake(0, -height, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromBottom) {
        view.frame = CGRectMake(0, height, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeByScaleBig) {
        view.frame = parentView.bounds;
        view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    }
    else if (animateType == FLFacadeAnimateTypeFadeByScaleSmall) {
        view.frame = parentView.bounds;
        view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    }
    else {
        view.frame = parentView.bounds;
    }
}

- (void)removeEmbedView:(UIView *)view atParentView:(UIView *)parentView animateType:(FLFacadeAnimateType)animateType {
    CGFloat width = parentView.bounds.size.width;
    CGFloat height = parentView.bounds.size.height;
    if (animateType == FLFacadeAnimateTypeFadeFromLeft) {
        view.frame = CGRectMake(width, 0, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromRight) {
        view.frame = CGRectMake(-width, 0, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromTop) {
        view.frame = CGRectMake(0, height, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeFromBottom) {
        view.frame = CGRectMake(0, -height, width, height);
    }
    else if (animateType == FLFacadeAnimateTypeFadeByScaleBig) {
        view.transform = CGAffineTransformScale(view.transform, 2.0, 2.0);
    }
    else if (animateType == FLFacadeAnimateTypeFadeByScaleSmall) {
        view.transform = CGAffineTransformScale(view.transform, 0.05, 0.05);
    }
    else {
        view.frame = parentView.bounds;
    }
}

- (BOOL)isFadeAnimate:(FLFacadeAnimateType)animateType {
    return animateType == FLFacadeAnimateTypeFade || animateType == FLFacadeAnimateTypeFadeFromTop || animateType == FLFacadeAnimateTypeFadeFromBottom || animateType == FLFacadeAnimateTypeFadeFromLeft || animateType == FLFacadeAnimateTypeFadeFromRight || animateType == FLFacadeAnimateTypeFadeByScaleSmall || animateType == FLFacadeAnimateTypeFadeByScaleBig;
}

- (void)fadeAnimateWithView:(UIView *)view atParentView:(UIView *)parentView animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration isEmbedAnimated:(BOOL)embedAnimated completion:(void (^)())completion {
    view.alpha = embedAnimated ? 0.0 : 1.0;
    
    [UIView animateWithDuration:duration animations:^{
        view.alpha = embedAnimated ? 1.0 : 0.0;
        if (embedAnimated && [self isFadeAnimate:animateType]) {
            if (animateType == FLFacadeAnimateTypeFadeByScaleBig) {
                view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            else if (animateType == FLFacadeAnimateTypeFadeByScaleSmall) {
                view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
            else {
                view.frame = parentView.bounds;
            }
        }
        else {
            [self removeEmbedView:view atParentView:parentView animateType:animateType];
        }
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
