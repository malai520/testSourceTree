//
//  UIView+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "UIView+Utils.h"
#import "MBProgressHUD.h"

#define ACTIVITYTAG 9999

@implementation UIView (Utils)

-(CGFloat)height
{
    return self.frame.size.height;
}


- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}


-(CGFloat)width
{
    return self.frame.size.width;
}


- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}


-(CGFloat)top
{
    return self.frame.origin.y;
}


- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}


-(CGFloat)left
{
    return self.frame.origin.x;
}


- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}


-(CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}


-(CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

#pragma mark -- UILabel

-(UILabel *)addLabelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)color isBold:(BOOL)bold
{
    UIFont *font = bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
    
    return [self addLabelWithText:text font:font textColor:color];
}

-(UILabel *)addLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color
{
    UILabel *label=[[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = font;
    label.text = text;
    [self addSubview:label];
    
    return label;
}


#pragma mark -- UITextField

-(UITextField *)addTextFieldWithDelegate:(id)delegate fontSize:(CGFloat)fontSize
{
    UITextField *textField = [[UITextField alloc]init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.delegate = delegate;
    textField.borderStyle = UITextBorderStyleNone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    [self addSubview:textField];
    
    return textField;
}

#pragma mark -- UIButton

-(UIButton *)addButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}

#pragma mark -- UITextView

-(UITextView *)addTextViewWithDelegate:(id)delegate fontSize:(CGFloat)fontSize
{
    UITextView *textView = [[UITextView alloc]init];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.delegate = delegate;
    textView.font=[UIFont systemFontOfSize:fontSize];
    textView.clearsContextBeforeDrawing = YES;
    textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textView];
    
    return textView;
}

#pragma mark -- 多view水平分布
- (void) distributeSpacingHorizontallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.centerY.equalTo(((UIView*)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
    }];
    
}

#pragma mark -- 多view垂直分布
- (void) distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    
    UIView *v0 = spaces[0];
    
    __weak __typeof(&*self)ws = self;
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom);
    }];
}

#pragma mark - 显示加载

- (void)showActivityView:(NSString *)labelText
{
    UIView *view = [self viewWithTag:ACTIVITYTAG];
    if (view) {
        [view removeFromSuperview];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = ACTIVITYTAG;
    hud.labelText = labelText;
    [self addSubview:hud];
    [hud show:YES];
}

- (void)hiddenActivityView
{
    
    MBProgressHUD *view =(MBProgressHUD *) [self viewWithTag:ACTIVITYTAG];
    [view hide:YES];
    
}

- (void)showActivityView:(NSString *)labelText hideAfterDelay:(NSTimeInterval)delay
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = ACTIVITYTAG;
    hud.labelText = labelText;
    hud.mode = MBProgressHUDModeText;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    
}

@end
