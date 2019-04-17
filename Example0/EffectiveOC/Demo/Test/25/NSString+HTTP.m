//
//  NSString+HTTP.m
//  Example0
//
//  Created by lmg on 2018/10/17.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "NSString+HTTP.h"
#import <objc/runtime.h>


@interface NSString (HTTP)

@property (nonatomic,strong) NSArray *dataList;

@end

@implementation NSString (HTTP)

static const char *kDataListPropertyKey = "kDataListPropertyKey";

- (NSArray *)dataList
{
    return  objc_getAssociatedObject(self, kDataListPropertyKey);
}

- (void)setDataList:(NSArray *)dataList
{
    objc_setAssociatedObject(self, kDataListPropertyKey, dataList, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)urlDecodedString
{
    return @"urlDecodedString";
}

- (NSString *)urlEncodedString
{
    return @"urlEncodedString";
}

@end
