//
//  UIView+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

-(void)addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text font:font];
}

-(void)addAttributesText:(NSString *)text color:(UIColor *)color fontSize:(int)fontSize
{
    [self addAttributesText:text color:color];
    [self addAttributesText:text fontSize:fontSize];
}

-(void)addAttributesText:(NSString *)text color:(UIColor *)color
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSForegroundColorAttributeName:color} range:range];
        self.attributedText = mat;
    }
}

-(void)addAttributesText:(NSString *)text fontSize:(int)fontSize
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:range];
        self.attributedText = mat;
    }
}

-(void)addAttributesText:(NSString *)text font:(UIFont *)font
{
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if(range.location != NSNotFound)
    {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSFontAttributeName:font} range:range];
        self.attributedText = mat;
    }
}


@end
