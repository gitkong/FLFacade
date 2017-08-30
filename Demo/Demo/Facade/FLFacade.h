//
//  FLFacade.h
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//  http://www.jianshu.com/u/fe5700cfb223 欢迎关注

#import <Foundation/Foundation.h>
#import "UIViewController+PresentStack.h"
#define FACADE [FLFacade shareManager]

typedef NS_ENUM(NSUInteger, FLFacadeAnimateType) {
    FLFacadeAnimateTypeNone = 0,
    FLFacadeAnimateTypeFade,
    FLFacadeAnimateTypeFadeFromLeft,
    FLFacadeAnimateTypeFadeFromRight,
    FLFacadeAnimateTypeFadeFromTop,
    FLFacadeAnimateTypeFadeFromBottom,
    FLFacadeAnimateTypeFadeByScaleSmall,
    FLFacadeAnimateTypeFadeByScaleBig,
    FLFacadeAnimateTypeFlipFromLeft,
    FLFacadeAnimateTypeFlipFromRight,
    FLFacadeAnimateTypeFlipFromTop,
    FLFacadeAnimateTypeFlipFromBottom,
    FLFacadeAnimateTypeCurlUp,
    FLFacadeAnimateTypeCurlDown,
    FLFacadeAnimateTypeCrossDissolve
};

@interface FLFacade : NSObject

@property (nonatomic, strong, readonly) UIViewController *currentViewController;

@property (nonatomic, strong, readonly) UINavigationController *currentNavigationController;

@property (nonatomic, strong, readonly) FLPresentStackController *currentPresentStackController;

@property (nonatomic, strong, readonly) UITabBarController *currentTabBarController;

+ (instancetype)shareManager;

#pragma mark - openUrl

/**
 应用内跳转所传参数

 @param url 应用内跳转路径
 @return 跳转所传参数
 */
- (NSDictionary *)paramsByOpenAppWithUrl:(NSString *)url;

/**
 应用内跳转

 @param urlScheme 跳转应用的URL Scheme
 @param params 配置参数
 @param complete 完成回调
 */
- (void)openAppWithUrlScheme:(NSString *)urlScheme params:(NSDictionary<NSString *, id> *)params complete:(void(^)(BOOL success))complete;

/**
 跳转苹果商店

 @param identifier 商品ID
 @param complete 完成回调
 */
- (void)openAppleStoreWithIdentifier:(NSString *)identifier complete:(void(^)(BOOL success))complete;

#pragma mark - Push

/**
 获取栈中已存在的控制器，相同则获取最后一个

 @param vcClass 指定控制器的类名
 @return 返回指定控制器
 */
- (__kindof UIViewController *)viewControllerBy:(Class)vcClass;

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
 Dismiss 移除当前控制器,如果没有PresentStackController，默认就会执行系统的dismiss方法
 */
- (void)dismissViewController;

/**
 Dismiss 移除当前控制器,如果没有PresentStackController，默认就会执行系统的dismiss方法

 @param animated 是否动画
 */
- (void)dismissViewControllerAnimated: (BOOL)animated;

/**
 Dismiss 移除当前控制器,如果没有PresentStackController，默认就会执行系统的dismiss方法

 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissViewControllerAnimated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到根控制器，此时如果没有创建PresentStackController，默认就会执行系统的dismiss方法

 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToRootViewControllerAnimated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到指定下标的位置，此时如果没有创建PresentStackController，默认就会执行系统的dismiss方法

 @param index 指定下标
 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToIndex:(NSInteger)index animated: (BOOL)animated completion: (void (^)())completion;

/**
 Dismiss 移除控制器，回到指定控制器，此时如果没有创建PresentStackController，默认就会执行系统的dismiss方法

 @param viewController 指定控制器
 @param animated 是否动画
 @param completion 完成回调
 */
- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)animated completion: (void (^)())completion;

#pragma mark - Embed

/**
 Embed 控制器，默认动画是FLFacadeAnimateTypeFade 淡入， 默认动画时间0.25s，默认相同类名的控制器不能重复embed

 @param vc 需要Embed的控制器
 */
- (void)embedViewController:(UIViewController *)vc;

/**
 Embed 控制器，默认动画是FLFacadeAnimateTypeFade 淡入， 默认动画时间0.25s，默认相同类名的控制器不能重复embed

 @param vc 需要Embed的控制器
 @param completion 完成回调
 */
- (void)embedViewController:(UIViewController *)vc completion:(void (^)())completion;

/**
 Embed 控制器， 默认动画时间0.25s，默认相同类名的控制器不能重复embed

 @param vc 需要Embed的控制器
 @param animateType 动画类型
 @param completion 完成回调
 */
- (void)embedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion;

/**
 Embed 控制器，默认相同类名的控制器不能重复embed

 @param vc 需要Embed的控制器
 @param animateType 动画类型
 @param duration 动画持续时间
 @param completion 完成回调
 */
- (void)embedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion;

#pragma mark - Remove Embed

/**
 Remove Embed 控制器，默认只会移除childViewControllers最上层一个，默认动画是FLFacadeAnimateTypeFade，默认动画持续时间是0.25s
 */
- (void)removeEmbedViewController;

/**
 Remove Embed 控制器，默认只会移除childViewControllers最上层一个，默认动画是FLFacadeAnimateTypeFade，默认动画持续时间是0.25s

 @param completion 完成回调
 */
- (void)removeEmbedViewControllerCompletion:(void (^)())completion;

/**
 Remove Embed 控制器，默认动画是FLFacadeAnimateTypeFade，默认动画持续时间是0.25s

 @param vc 需要remove的控制器，此时控制器必须是childViewController，否者不执行任何操作
 @param completion 完成回调
 */
- (void)removeEmbedViewController:(UIViewController *)vc completion:(void (^)())completion;

/**
 Remove Embed 控制器，默认动画持续时间是0.25s

 @param animateType 动画类型
 @param completion 完成回调
 */
- (void)removeEmbedViewControllerWithAnimateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion;

/**
 Remove 当前 Embed 控制器

 @param animateType 动画类型
 @param duration 动画执行时间
 @param completion 完成回调
 */
- (void)removeEmbedViewControllerWithAnimateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion;

/**
 Remove 当前 Embed 控制器

 @param vc 需要remove的控制器，此时控制器必须是childViewController，否者不执行任何操作
 @param animateType 动画类型
 @param completion 完成回调
 */
- (void)removeEmbedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType completion:(void (^)())completion;

/**
 Remove 当前 Embed 控制器

 @param vc 需要remove的控制器，此时控制器必须是childViewController，否者不执行任何操作
 @param animateType 动画类型
 @param duration 动画执行时间
 @param completion 完成回调
 */
- (void)removeEmbedViewController:(UIViewController *)vc animateType:(FLFacadeAnimateType)animateType duration:(NSTimeInterval)duration completion:(void (^)())completion;

@end
