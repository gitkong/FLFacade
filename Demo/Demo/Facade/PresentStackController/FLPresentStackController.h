//
//  FLPresentStackController.h
//  TestPush
//
//  Created by 孔凡列 on 2017/7/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLPresentStackController : UIViewController

@property(nonatomic, strong, readonly) UIViewController *visibleViewController;

@property (nonatomic, strong, readonly) NSArray<UIViewController *> *viewControllers;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;

- (void)dismissToRootViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;

- (void)dismissToIndex:(NSInteger)index animated: (BOOL)flag completion: (void (^)(void))completion;

- (void)dismissToViewController:(UIViewController *)viewController animated: (BOOL)flag completion: (void (^)(void))completion;

@end
