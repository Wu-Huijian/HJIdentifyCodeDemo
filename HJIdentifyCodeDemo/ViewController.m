//
//  ViewController.m
//  HJIdentifyCodeDemo
//
//  Created by WHJ on 16/2/18.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJCodeInputView.h"
@interface ViewController ()<HJCodeInputViewDelegate>{
    HJCodeInputView *codeView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证码";
    self.view.backgroundColor = [UIColor grayColor];
    CGFloat margin = 40;
    codeView = [[HJCodeInputView alloc]initWithFrame:CGRectMake(margin, 200,self.view.frame.size.width-2*margin, 64)];
    codeView.layer.cornerRadius = 5.f;
    codeView.layer.masksToBounds = YES;
    codeView.keyboardType = UIKeyboardTypeNumberPad;
    codeView.codeColor = [UIColor blackColor];
    codeView.securityText = YES;//隐藏字符
    codeView.codeBackgroundColor = [UIColor yellowColor];
    codeView.codeFont = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:codeView];
    codeView.codeInputViewDelegate = self;
   
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (codeView!=nil) {
        [codeView clearIdentifyingCode];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - HJCodeInputViewDelegate
-(void)codeInputFinished:(NSString *)codeStr{
    //TODO:对比正确验证码
    if (![codeStr isEqualToString:@"111111"]) {
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        tipLabel.backgroundColor = [UIColor blackColor];
        tipLabel.alpha = 0.3;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"验证码错误";
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.center = self.view.center;
        [self.view.window addSubview:tipLabel];
        [tipLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1];
    }else{
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor greenColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
