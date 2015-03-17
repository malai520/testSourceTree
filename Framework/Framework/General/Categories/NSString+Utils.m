//
//  NSString+Utils.m
//  SanLianOrdering
//
//  Created by guojiang on 14-10-10.
//  Copyright (c) 2014年 DaCheng. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

//字符串去空格
-(NSString *)stringTrimWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark --长度宽度相关方法

//方法功能：根据字体大小与限宽，计算高度
-(CGFloat)getHeightWithFontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    return [self getHeightWithFont:[UIFont systemFontOfSize:fontSize] maxWidth:maxWidth];
}

-(CGFloat)getHeightWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                           attributes:attribute context:nil].size.height;
}

//方法功能：根据字体大小与限高，计算宽度
-(CGFloat)getWidthWithFontSize:(CGFloat)fontSize maxHeight:(CGFloat)maxHeight
{
    return [self getWidthWithFont:[UIFont systemFontOfSize:fontSize] maxHeight:maxHeight];
}

-(CGFloat)getWidthWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight)
                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                           attributes:attribute context:nil].size.width;
}


#pragma mark --时间相关方法
// 方法功能：时间戳
+ (NSString *)getTimeStamp{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}
// 获取格式化时间时间戳
- (NSString *)getTimeStampString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:self];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}
//取得格式化时间
-(NSString *)getDateTimeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateTimeStr = [dateFormatter stringFromDate:date];
    return dateTimeStr;
}
//取得日期
-(NSString *)getDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:self.longLongValue];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

#pragma mark --手机号码隐藏处理(加星号处理)
-(NSString *)securePhoneNumber{
    
    NSString *regular=@"(?<=\\d{3})\\d(?=\\d{4})";
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regular options:0 error:nil];
    
    NSString *content=self;
    content  = [regularExpression stringByReplacingMatchesInString:content options:0 range:NSMakeRange(0, content.length) withTemplate:@"*"];
    
    return content;
}

#pragma mark --dictionaryToJson
+(NSString *)dictionaryToJsonStr:(NSDictionary *)dic
{
    if (dic==nil) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //NSLog(@"JSON String = %@", jsonString);
    return jsonString;
}

@end
