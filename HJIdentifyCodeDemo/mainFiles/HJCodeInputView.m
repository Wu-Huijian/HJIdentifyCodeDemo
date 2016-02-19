//
//  HJCodeInputView.m
//  HJIdentifyCodeDemo
//
//  Created by WHJ on 16/2/18.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "HJCodeInputView.h"

@interface HJCodeInputView ()<UITextFieldDelegate>
@property (nonatomic, strong)NSMutableArray *labelMArr;
@end


@implementation HJCodeInputView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //初始化
        [self initW];
        
        [self setupUI];
    }
    return self;
}



-(void)initW{
    self.tintColor = [UIColor clearColor];//隐藏光标
    self.textColor = [UIColor clearColor];//隐藏文本
    self.delegate = self;
    
    //初始化属性
    self.labelMArr = [NSMutableArray arrayWithCapacity:6];
    self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.gapWidth = 2;
    self.codeBackgroundColor = [UIColor whiteColor];
}

-(void)setupUI{
    
    for (int i=0; i<6; i++) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        [self.labelMArr addObject:label];
    }
}


-(void)layoutSubviews{
    CGFloat allWidth = self.frame.size.width;
    CGFloat height = self.frame.size.height - self.insets.top-self.insets.bottom;
    CGFloat lblWidth = (allWidth-5*self.gapWidth-self.insets.left-self.insets.right)/6;
    
    for (int i=0; i<6; i++) {
        UILabel *label = self.labelMArr[i];
        label.frame = CGRectMake(self.gapWidth*i+lblWidth*i+self.insets.left,self.insets.top, lblWidth, height);
        label.backgroundColor = self.codeBackgroundColor;
        label.textColor = self.codeColor;
        label.font = self.codeFont;
        label.textAlignment = NSTextAlignmentCenter;
    }
}

//更新显示code
-(void)updateData:(NSString *)codeStr{
    self.codeMArr = [[NSMutableArray alloc]init];
    for(int i=0;i<codeStr.length;i++){
        NSRange range = NSMakeRange(i, 1);
        NSString *str = [codeStr substringWithRange:range];
        [self.codeMArr addObject:str];
    }
    
    for(int i=0;i<self.labelMArr.count;i++){
        UILabel *label =  self.labelMArr[i];
        if (i<self.codeMArr.count && self.codeMArr[i]!=nil) {
            
            label.text = self.securityText?@"●":self.codeMArr[i];
        }else{
            label.text = @"";
        }
    }
    
    
    if (codeStr.length>0) {//正在输入
        if ([self.codeInputViewDelegate respondsToSelector:@selector(codeIsInputing)]) {
            [self.codeInputViewDelegate codeIsInputing];
        }
    }
    
    if (self.codeMArr.count==6) {//输入完成
        if ([self.codeInputViewDelegate respondsToSelector:@selector(codeInputFinished:)]) {
            [self.codeInputViewDelegate codeInputFinished:codeStr];
        }
    }
}



//清除code
-(void)clearIdentifyingCode{
    [self updateData:nil];
    self.text = @"";
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (toBeString.length > 6) {
        return NO;
    }

    [self updateData:toBeString];
    return YES;
}



@end
