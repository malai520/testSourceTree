//
//  UIImage+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-21.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

- (UIImage *)scaleToSize:(CGSize)newsize;

- (UIImage *)imageWithOverlayColor:(UIColor *)color;

@end
