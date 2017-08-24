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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textView];
}

- (void)setUrl:(NSString *)url {
    _url = url;
    self.label.text = url;
}

- (void)setParams:(NSDictionary *)params {
    _params = params;
    self.textView.text = [NSString stringWithFormat:@"params: %@",params];
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
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 200, self.view.bounds.size.width - 40, self.view.bounds.size.height - 200)];
        _textView.text = @"传过来的参数";
    }
    return _textView;
}

@end
