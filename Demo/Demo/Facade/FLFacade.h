//
//  FLFacade.h
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+PresentStack.h"
#define FACADE [FLFacade shareManager]

@interface FLFacade : NSObject

@property (nonatomic, strong, readonly) UIViewController *currentViewController;

@property (nonatomic, strong, readonly) UINavigationController *currentNavigationController;

@property (nonatomic, strong, readonly) FLPresentStackController *currentPresentStackController;

@property (nonatomic, strong, readonly) UITabBarController *currentTabBarController;

+ (instancetype)shareManager;

#pragma mark - openUrl

/**
 应用内跳转

 @param urlString 跳转链接
 @param options 配置参数
 @param complete 完成回调
 */
- (void)openAppWithUrl:(NSString *)urlString options:(NSDictionary<NSString *, id> *)options complete:(void(^)(BOOL success))complete;

/**
 跳转苹果商店

 @param identifier 商品ID
 @param complete 完成回调
 */
- (void)openAppleStoreWithIdentifier:(NSString *)identifier complete:(void(^)(BOOL success))complete;

#pragma mark - Push

/**
 Pop 到指定index 然后Push 跳转到指定控制器

 @param index 对应viewControllers的下标
 @param viewController 指定push 的控制器
 @param animated 是否动画
 @param complete 完成回调
 */
- (void)popToIndex:(NSInteger)index thenPushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

/**
 Push 到指定控制器，此时如果栈中有跟指定控制器相同类,则不会跳转新的，而是pop回去指定控制器，此时指定控制器不会重新加载，默认有动画效果

 @param viewController 指定控制器
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 Push到指定控制器，此时如果栈中有跟指定控制器相同类,则不会跳转新的，而是pop回去指定控制器，此时指定控制器不会重新加载

 @param viewController 指定控制器
 @param animated 是否动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 Push到指定控制器

 @param viewController 指定控制器
 @param animated 是否动画
 @param needBack 是否需要回到栈中有的控制器（同类名），YES 就默认pop回去然后重新加载当前控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack;

/**
 Push到指定控制器

 @param viewController 指定控制器
 @param animated 是否动画
 @param needBack 是否需要回到栈中有的控制器（同类名），YES 就默认pop回去然后重新加载当前控制器
 @param complete 完成回调
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack complete:(void(^)())complete;

/**
 Push到指定控制器，此时如果栈中有跟指定控制器相同类,则不会跳转新的，而是pop回去指定控制器，此时指定控制器不会重新加载

 @param viewController 指定控制器
 @param animated 是否动画
 @param complete 完成回调
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

/**
 Push到指定控制器，此时如果栈中有跟指定控制器相同类,则不会跳转新的，而是pop回去指定控制器，可设置是否需要重新加载

 @param viewController 指定控制器
 @param animated 是否动画
 @param needReload 是否需要重新加载当前控制器
 @param complete 完成回调
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needReload:(BOOL)needReload complete:(void(^)())complete;

/**
 Push到指定控制器

 @param viewController 指定控制器
 @param animated 是否动画
 @param needBack 是否需要pop回去，YES则栈中有跟指定控制器相同类,则不会跳转新的，而是pop回去指定控制器
 @param needReload 是否需要重新加载控制器
 @param complete 完成回调
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated needBack:(BOOL)needBack needReload:(BOOL)needReload complete:(void(^)())complete;

#pragma mark - Pop

/**
 Pop 回到上一个控制器
 */
- (void)popViewController;

/**
 Pop 回到上一个控制器

 @param animated 是否动画
 */
- (void)popViewControllerAnimated:(BOOL)animated;

/**
 Pop 回到上一个控制器

 @param animated 是否动画
 @param complete 完成回调
 */
- (void)popViewControllerAnimated:(BOOL)animated complete:(void(^)())complete;

/**
 Pop 回到根控制器

 @param animated 是否动画
 @param complete 完成回调
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated complete:(void(^)())complete;

/**
 Pop 回到指定控制器，如果指定控制器不存在在栈中，则不执行任何操作

 @param viewController 指定控制器
 @param animated 是否动画
 @param complete 完成回调
 */
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

/**
 Pop 回到指定下标，如果指定下标不合法，则不执行任何操作

 @param index 指定下标
 @param animated 是否动画
 @param complete 完成回调
 */
- (void)popToIndex:(NSInteger)index animated:(BOOL)animated complete:(void(^)())complete;

#pragma mark - Present

/**
 Present 到指定控制器，如果没有创建PresentStackController，则默认使用系统Present，只能对应使用dismissViewController，dismiss当前控制器，无法dismiss多层控制器

 @param viewController 指定控制器
 */
- (void)presentViewController:(UIViewController *)viewController;

/**
 Present 到指定控制器，如果没有创建PresentStackController，则默认使用系统Present，只能对应使用dismissViewController，dismiss当前控制器，无法dismiss多层控制器

 @param viewController 指定控制器
 @param animated 是否动画
 */
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 Present 到指定控制器，如果没有创建PresentStackController，则默认使用系统Present，只能对应使用dismissViewController，dismiss当前控制器，无法dismiss多层控制器

 @param viewController 指定控制器
 @param animated 是否动画
 @param complete 完成回调
 */
- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)())complete;

#pragma mark - Dismiss

/**
 Dismiss 移除当前控制器
 */
- (void)dismissViewController;

/**
 Dismiss 移除当前控制器

 @param animated 是否动画
 */
- (void)dismissViewControllerAnimated: (BOOL)animated;

/**
 Dismiss 移除当前控制器

 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissViewControllerAnimated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到根控制器，此时如果没有创建PresentStackController，那么不执行任何操作

 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToRootViewControllerAnimated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到指定下标的位置，此时如果没有创建PresentStackController，那么不执行任何操作

 @param index 指定下标
 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToIndex:(NSInteger)index animated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到指定控制器，此时如果没有创建PresentStackController，那么不执行任何操作

 @param viewController 指定控制器
 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)animated completion: (void (^)())completion;

@end
