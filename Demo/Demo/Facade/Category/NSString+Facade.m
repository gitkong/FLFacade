//
//  NSString+Facade.m
//  Demo
//
//  Created by 孔凡列 on 2017/8/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "NSString+Facade.h"

@implementation NSString (Facade)

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (UIImage *)imageFromBase64String {
    if (self.isNotBlank) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        NSData  *data   = [[NSData alloc] initWithBase64Encoding:self];
#pragma clang diagnostic pop
        return [UIImage imageWithData:data];
    }
    return nil;
}

@end
