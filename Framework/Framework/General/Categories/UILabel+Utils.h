//
//  UIView+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

-(void)addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
-(void)addAttributesText:(NSString *)text color:(UIColor *)color fontSize:(int)fontSize;
-(void)addAttributesText:(NSString *)text color:(UIColor *)color;
-(void)addAttributesText:(NSString *)text font:(UIFont *)font;
-(void)addAttributesText:(NSString *)text fontSize:(int)fontSize;

@end
