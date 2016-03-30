//
//  BeanParser.h
//  KgOrderSys
//
//  Created by apem on 14-10-26.
//  Copyright (c) 2014年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

/**
 *  模型转化 工具类
 *
 *  @author apem
 */

@interface BeanParser : NSObject

@property (nonatomic, strong) NSString *datetimeFormat;         //时间转化格式
@property (nonatomic, strong) NSString *dateFormat;             //日期转化格式

//单例
+ (instancetype)shared;

/**
 *  初始化配置
 */
- (void)initConfig;

//NSDictionary为指定类
//dict 转 bean
- (id)parseToBean:(NSDictionary *)dict toClassArray:(NSArray * )clsArr;

//dict array 转 bean array
- (NSArray *)parseToBeanArr:(NSArray *)arr toClassArray:(NSArray * )clsArr;

//bean转NSDictionary
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSDictionary *)beanToDictionary:(NSObject *)bean classArray:(NSArray *)clsArr;
//对象转字符串
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSString *)beanToString:(NSObject *)bean classArray:(NSArray *)clsArr;

//字典转化为字符串
- (NSString *)dictionaryToString:(NSDictionary *)dict;

//实体类数组转字符串
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSString *)beanArrToString:(NSArray *)array classArray:(NSArray *)clsArr;

//复制源BEAN中不为空的值给目标BEAN
//参数: 1.源对象 2.目标对象 3.类数组 (把这个类的所有父类的都放在 数组里)
- (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj classArray:(NSArray *)clsArr;

#pragma mark - JSONModel Parsing

//数组转实体类数组 连带级联
- (NSArray *)JSONModelParseToBeanArray:(NSArray *)arr class:(Class)cls;

//字符串转实体类数组 连带级联
- (NSArray *)JSONModelStringToBeanArray:(NSString *)str class:(Class)cls;

#pragma mark - NSString && NSDate parse methods

// 转化时间戳 固定格式：/Date(1394259720000)/
- (NSDate *)changePHPToNSDate:(NSString *)date withFormatter:(NSString *)format;

//时间格式化为字符串
- (NSString *)dateToString:(NSDate *)date withFormatter:(NSString *)format;

//默认日期转换字符串
- (NSString *)dateToDefaultString:(NSDate *)date;

//默认日期时间转换字符串
- (NSString *)datetimeToDefaultString:(NSDate *)date;

//字符串转日期
- (NSDate *)stringToDate:(NSString *)string withFormatter:(NSString *)format;

//默认字符串转日期
- (NSDate *)stringToDefaultDate:(NSString *)string;

//默认字符串转日期时间
- (NSDate *)stringToDefaultDatetime:(NSString *)string;

//获取NSDateComponents, 通过他可以获取年月日时分秒
- (NSDateComponents *)getNSDateComponentsWithDate:(NSDate *)date;

//判断是否不为空
//支持 NSString, NSDate
- (BOOL)isNotBlank:(NSObject *)obj;

#pragma mark - 反射相关

// 利用反射取得NSObject的属性，并存入到数组中
- (NSArray *)getPropertyList:(NSArray *)clsArr;

@end
