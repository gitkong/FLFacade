//
//  ViewController.m
//  TestJumpApp
//
//  Created by 孔凡列 on 2017/8/24.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.imageView];
    
    NSLog(@"%@",NSStringFromRange([@"a=v&c=d&d=e==" rangeOfString:@"="]));
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    self.label.text = url;
}

- (void)setParams:(NSDictionary *)params {
    _params = params;
    self.textView.text = [NSString stringWithFormat:@"params: %@",params];
    NSString *dataStr = params[@"imageStr"];
    NSData  *data   = [[NSData alloc] initWithBase64Encoding:dataStr];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        self.image = image;
    }
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 40, 300)];
        _textView.text = @"传过来的参数";
    }
    return _textView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 500, 100, 100)];
    }
    return _imageView;
}

@end
