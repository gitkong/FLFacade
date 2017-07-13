//
//  UIViewController+PresentStack.h
//  TestPush
//
//  Created by 孔凡列 on 2017/7/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLPresentStackController.h"

@interface UIViewController (PresentStack)

/**
 类似UINavigationController，用作present和dismiss
 */
@property (nonatomic, strong) FLPresentStackController *presentStackController;

/**
 用作优化交互，最后present的控制器中的控件需要添加到presentContentView中
 */
@property (nonatomic, strong, readonly) UIView *presentContentView;

/**
 判断当前控制器是否在presentStackController管理的栈中

 @return YES表示存在
 */
- (BOOL)isExistAtPresentStack;

/**
 返回当前控制器在presentStackController管理的栈中的位置

 @return -1表示不存在
 */
- (NSInteger)indexAtPresentStack;

@end
