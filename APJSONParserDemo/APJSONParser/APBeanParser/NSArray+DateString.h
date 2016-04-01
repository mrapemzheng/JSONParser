//
//  NSArray+DateString.h
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/3.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DateString)

/**
 *  更改NSArray中所有的NSDate转化为NSString
 *
 *  @param formatString 字符串转化格式
 *
 *  @return 更改NSArray中所有的NSDate转化为NSString后的NSArray
 */
- (NSArray *)getArrayChangeDateToString:(NSString *)formatString;

/**
 *  更改NSArray中所有的时间格式/日期格式的NSString为NSDate
 *
 *  @param dateFormatString     日期格式
 *  @param datetimeFormatString 时间格式
 *
 *  @return 更改NSArray中所有的时间格式/日期格式的NSString为NSDate
 */
- (NSArray *)getArrayChangeStringToDate:(NSString *)dateFormatString datetimeFormatString:(NSString *)datetimeFormatString;

@end
