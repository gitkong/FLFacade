//
//  UIImage+Facade.m
//  Demo
//
//  Created by 孔凡列 on 2017/8/25.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UIImage+Facade.h"

@implementation UIImage (Facade)

- (NSString *)PNGBase64String {
    if (self) {
        NSData *data = UIImagePNGRepresentation(self);
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return nil;
}

- (NSString *)JPEGBase64StringWithCompressionQuality:(CGFloat)compressionQuality {
    if (self) {
        NSData *data = UIImageJPEGRepresentation(self, compressionQuality);
        return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return nil;
}

@end
