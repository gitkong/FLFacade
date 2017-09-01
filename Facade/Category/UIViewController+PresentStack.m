//
//  UIViewController+PresentStack.m
//  TestPush
//
//  Created by 孔凡列 on 2017/7/11.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "UIViewController+PresentStack.h"
#import <objc/runtime.h>

static char *KPresentStackControllerKey = "KPresentStackControllerKey";
static char *KPresentStackControllerContentViewKey = "KPresentStackControllerContentViewKey";

@implementation UIViewController (PresentStack)

@dynamic presentContentView;

- (BOOL)isExistAtPresentStack {
    if (self.presentStackController && self.presentStackController.viewControllers) {
        BOOL isExist = NO;
        for (UIViewController *vc in self.presentStackController.viewControllers) {
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

- (NSInteger)indexAtPresentStack {
    __block NSInteger index = -1;
    if (self.presentStackController && self.presentStackController.viewControllers) {
        [self.presentStackController.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
            if (vc == self) {
                index = idx;
                *stop = YES;
            }
        }];
    }
    return index;
}

- (void)setPresentStackController:(FLPresentStackController *)presentStackController {
    objc_setAssociatedObject(self, &KPresentStackControllerKey, presentStackController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FLPresentStackController *)presentStackController {
    return objc_getAssociatedObject(self, &KPresentStackControllerKey);
}

- (UIView *)presentContentView {
    UIView *view = objc_getAssociatedObject(self, &KPresentStackControllerContentViewKey);
    if (!view) {
        view =  [[UIView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = self.view.backgroundColor;
        [self.view addSubview:view];
        objc_setAssociatedObject(self, &KPresentStackControllerContentViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return view;
}
@end
