//
//  NSArray+DateString.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/3.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "NSArray+DateString.h"
#import "NSDictionary+DateString.h"

@implementation NSArray (DateString)

- (NSArray *)getArrayChangeDateToString:(NSString *)formatString
{
    NSMutableArray *mutableArray = [self mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatString;
    __block id str;
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDate class]] && obj) {
            str = [dateFormatter stringFromDate:obj];
            if (!str) {
                NSLog(@"%s:%@index=%lu,%@", __func__, mutableArray, (long)idx, @"时间格式不正确");
                str = [NSNull null];
            }
            [mutableArray replaceObjectAtIndex:idx withObject:str];
        } else if([obj isKindOfClass:[NSDictionary class]] && obj) {
            NSDictionary *dict = [(NSDictionary *)obj getDictionaryChangeDateToString:formatString];
            [mutableArray replaceObjectAtIndex:idx withObject:dict];
        } else if([obj isKindOfClass:[NSArray class]] && obj) {
            NSArray *array = [(NSArray *)obj getArrayChangeDateToString:formatString];
            [mutableArray replaceObjectAtIndex:idx withObject:array];
        }
    }];
    return mutableArray;
}

- (NSArray *)getArrayChangeStringToDate:(NSString *)dateFormatString datetimeFormatString:(NSString *)datetimeFormatString
{
    NSMutableArray *mutableArray = [self mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = datetimeFormatString;
    __block id date;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]] && obj && [self isDateFormat:obj dateFormat:dateFormatString dateTimeFormat:datetimeFormatString]) {
            date = [dateFormatter dateFromString:obj];
            if (!date) {
                date = [NSNull null];
            }
            [mutableArray replaceObjectAtIndex:idx withObject:date];
        } else if([obj isKindOfClass:[NSDictionary class]] && obj) {
            NSDictionary *dict = [(NSDictionary *)obj getDictionaryChangeStringToDate:dateFormatString datetimeFormatString:datetimeFormatString];
            [mutableArray replaceObjectAtIndex:idx withObject:dict];
        } else if([obj isKindOfClass:[NSArray class]] && obj) {
            NSArray *array = [(NSArray *)obj getArrayChangeStringToDate:dateFormatString datetimeFormatString:datetimeFormatString];
            [mutableArray replaceObjectAtIndex:idx withObject:array];
        }
    }];
    return mutableArray;
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
