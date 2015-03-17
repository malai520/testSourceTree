//
//  NSString+Utils.h
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

#pragma mark --字符相关方法
- (NSString *)stringTrimWhitespace;//字符串去空格

#pragma mark --长度宽度相关方法
-(CGFloat)getHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
-(CGFloat)getHeightWithFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;

-(CGFloat)getWidthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;
-(CGFloat)getWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight;


#pragma mark --时间相关方法
+ (NSString *)getTimeStamp; // 获取时间戳
- (NSString *)getTimeStampString; // 获取格式化时间时间戳
- (NSString *)getDateTimeString;//取得格式化时间
- (NSString *)getDateString;//取得日期

#pragma mark --手机号码隐藏处理(加星号处理)
-(NSString *)securePhoneNumber;

#pragma mark --dictionaryToJson
+(NSString *)dictionaryToJsonStr:(NSDictionary *)dic;
@end
