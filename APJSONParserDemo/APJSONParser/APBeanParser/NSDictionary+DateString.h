//
//  NSDictionary+DateString.h
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/1.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSDictionary 关于日期转化的
 */

@interface NSDictionary (DateString)

/**
 *  更改NSDcitionary中所有的NSDate转化为NSString
 *
 *  @param formatString 日期格式字符串
 *
 *  @return 更改NSDcitionary中所有的NSDate转化为NSString后的NSDictionary
 */
- (NSDictionary *)getDictionaryChangeDateToString:(NSString *)formatString;

/**
 *  更改NSDictionary中所有的指定日期格式的
 *
 *  @param dateFormatString     日期格式
 *  @param datetimeFormatString 时间格式
 *
 *  @return  更改NSDictionary中所有的指定日期格式的后的NSDictionary
 */
- (NSDictionary *)getDictionaryChangeStringToDate:(NSString *)dateFormatString datetimeFormatString:(NSString *)datetimeFormatString;

@end
