//
//  Hbb_XMLParser.h
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  货宝宝XML转化
 *
 *  @author apem
 */

@interface Hbb_XMLParser : NSObject

/**
 *  单例
 *
 *  @return 货宝宝XML转化对象
 */
+ (instancetype)shared;

/**
 *  XML字符串转化为字典
 *
 *  @param xmlString XML字符串
 *
 *  @return 字典
 */
- (NSDictionary *)xmlStringToDictionary:(NSString *)xmlString;

/**
 *  字典转化为XML字符串
 *
 *  @param dictionary 字典
 *
 *  @return XML字符串
 */
- (NSString *)dictionaryToXmlString:(NSDictionary *)dictionary;

/**
 *  XML字符串转化为模型对象
 *
 *  @param xmlString XML字符串
 *  @param cls       模型对象类型
 *
 *  @return 模型对象
 */
- (id)xmlStringToBean:(NSString *)xmlString cls:(Class)cls;

/**
 *  模型对象转化为XML字符串
 *
 *  @param bean 模型对象
 *
 *  @return XML字符串
 */
- (NSString *)beanToXmlString:(NSObject *)bean;



@end
