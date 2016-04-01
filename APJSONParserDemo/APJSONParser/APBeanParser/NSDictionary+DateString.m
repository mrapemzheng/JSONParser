//
//  NSDictionary+DateString.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/1.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"

@implementation NSDictionary (DateString)

- (NSDictionary *)getDictionaryChangeDateToString:(NSString *)formatString
{
    NSMutableDictionary *mutableDictionary = [self mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatString;
    __block id str;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDate class]] && obj) {
            str = [dateFormatter stringFromDate:obj];
            if (!str) {
                NSLog(@"%s:%@%@", __func__, key, @"时间格式不正确");
                str = [NSNull null];
            }
            [mutableDictionary setObject:str forKey:key];
        } else if([obj isKindOfClass:[NSDictionary class]] && obj) {
            NSDictionary *dict = [(NSDictionary *)obj getDictionaryChangeDateToString:formatString];
            [mutableDictionary setObject:dict forKey:key];
        } else if([obj isKindOfClass:[NSArray class]] && obj) {
            NSArray *array = [(NSArray *)obj getArrayChangeDateToString:formatString];
            [mutableDictionary setObject:array forKey:key];
        }
    }];
    return mutableDictionary;
}

- (NSDictionary *)getDictionaryChangeStringToDate:(NSString *)dateFormatString datetimeFormatString:(NSString *)datetimeFormatString
{
    NSMutableDictionary *mutableDictionary = [self mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = datetimeFormatString;
    __block id date;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //如果字符串是日期格式,并且不为nil
        if ([obj isKindOfClass:[NSString class]] && [mutableDictionary isDateFormat:obj dateFormat:dateFormatString dateTimeFormat:datetimeFormatString] && obj) {
            date = [dateFormatter dateFromString:obj];
            if (!date) {
                date = [NSNull null];
            }
            [mutableDictionary setObject:date forKey:key];
        //如果是NSDictionary
        } else if([obj isKindOfClass:[NSDictionary class]] && obj) {
            NSDictionary *dict = [(NSDictionary *)obj getDictionaryChangeStringToDate:dateFormatString datetimeFormatString:datetimeFormatString];
            [mutableDictionary setObject:dict forKey:key];
        //如果是数组
        } else if([obj isKindOfClass:[NSArray class]] && obj) {
            NSArray *array= [(NSArray *)obj getArrayChangeStringToDate:dateFormatString datetimeFormatString:datetimeFormatString];
            [mutableDictionary setObject:array forKey:key];
        }
    }];
    return mutableDictionary;
}

/**
 *  是否日期/时间格式
 *
 *  @return 是否日期格式/时间
 */
- (BOOL)isDateFormat:(NSString *)dateStr dateFormat:(NSString *)defaultDateFormat dateTimeFormat:(NSString *)datetimeFormat
{
    BOOL b = NO;
    if (dateStr) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = defaultDateFormat;
        NSDate *date = [dateFormat dateFromString:dateStr];
        
        dateFormat.dateFormat = datetimeFormat;
        NSDate *date2 = [dateFormat dateFromString:dateStr];
        
        if (date || date2) {
            b = YES;
        }
    }
    return b;
}

@end
