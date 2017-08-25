//
//  UIImage+Facade.h
//  Demo
//
//  Created by 孔凡列 on 2017/8/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//  http://www.jianshu.com/u/fe5700cfb223 欢迎关注

#import <UIKit/UIKit.h>

/**
 app 跳转传图片参数，可用此分类转换
 */
@interface UIImage (Facade)

- (NSString *)PNGBase64String;

- (NSString *)JPEGBase64StringWithCompressionQuality:(CGFloat)compressionQuality;

@end
