//
//  UIViewController+NavStack.m
//  live
//
//  Created by 孔凡列 on 2017/7/10.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "UIViewController+NavStack.h"

@implementation UIViewController (NavStack)

- (BOOL)isExistAtNavStack {
    if (self.navigationController && self.navigationController.viewControllers) {
        BOOL isExist = NO;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if (vc == self) {
                isExist = YES;
                break;
            }
        }
        return isExist;
    }
    else {
        return NO;
    }
}

@end
