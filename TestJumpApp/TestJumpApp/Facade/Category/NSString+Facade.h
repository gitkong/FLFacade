//
//  NSString+Facade.h
//  Demo
//
//  Created by 孔凡列 on 2017/8/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (Facade)

- (BOOL)isNotBlank;

- (UIImage *)imageFromBase64String;

@end
