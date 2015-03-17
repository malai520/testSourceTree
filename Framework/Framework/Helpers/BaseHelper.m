//
//  BaseHelper.m
//  Framework
//
//  Created by gejiangs on 15/2/9.
//  Copyright (c) 2015年 guojiang. All rights reserved.
//

#import "BaseHelper.h"


@implementation BaseHelper

-(id)init
{
    if (self = [super init]) {
        self.requestOperator = [[BaseRequestOperator alloc] init];
    }
    return self;
}

@end
