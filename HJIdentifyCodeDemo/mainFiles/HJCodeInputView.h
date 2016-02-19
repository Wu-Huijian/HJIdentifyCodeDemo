//
//  HJCodeInputView.h
//  HJIdentifyCodeDemo
//
//  Created by WHJ on 16/2/18.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HJCodeInputViewDelegate <NSObject>
@required
-(void)codeInputFinished:(NSString *)codeStr;

@optional
-(void)codeIsInputing;
@end

@interface HJCodeInputView : UITextField

@property (nonatomic ,strong)NSMutableArray *codeMArr;
@property (nonatomic ,assign)CGFloat gapWidth;//code间隔
@property (nonatomic ,assign)UIEdgeInsets insets;//内边距
@property (nonatomic ,strong)UIColor *codeColor;//验证码颜色
@property (nonatomic ,strong)UIFont *codeFont;//验证码字体
@property (nonatomic ,strong)UIColor *codeBackgroundColor;//验证码背景色
@property (nonatomic, assign) BOOL securityText;

@property (nonatomic ,weak)id<HJCodeInputViewDelegate> codeInputViewDelegate;

//清空验证码
-(void)clearIdentifyingCode;
@end
