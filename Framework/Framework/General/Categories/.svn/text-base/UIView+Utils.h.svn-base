//
//  UIView+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

#pragma mark -- View 属性
@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property (readonly) CGFloat bottom;
@property (readonly) CGFloat right;


#pragma mark -- View 添加UILabel,UITextField。。。。。
-(UILabel *)addLabelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)color isBold:(BOOL)bold;
-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;

-(UITextField *)addTextFieldWithDelegate:(id)delegate fontSize:(CGFloat)fontSize;

-(UIButton *)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

-(UITextView *)addTextViewWithDelegate:(id)delegate fontSize:(CGFloat)fontSize;

#pragma mark -- AutoLayout 多view平均排列
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

#pragma mark - 显示加载
- (void)showActivityView:(NSString *)labelText;
- (void)hiddenActivityView;
- (void)showActivityView:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay;

@end
