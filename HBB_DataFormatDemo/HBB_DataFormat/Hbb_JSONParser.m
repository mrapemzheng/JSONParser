//
//  Hbb_JSONParser.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "Hbb_JSONParser.h"
#import "BeanParser.h"
#import "NSArray+DateString.h"
#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"

@implementation Hbb_JSONParser

- (instancetype)init
{
    if (self = [super init]) {
        self.datetimeFormat = @"yyyy-MM-dd HH:mm:ss";
        self.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

+ (instancetype)shared
{
    static Hbb_JSONParser *hbb_JSONParser;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^(void){
        hbb_JSONParser = [[Hbb_JSONParser alloc] init];
    });
    return hbb_JSONParser;
}

- (id)jsonStringToBean:(NSString *)jsonString cls:(Class)cls
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSDictionary *dict = [self jsonStringToDictionary:jsonString];
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    id bean = [[BeanParser shared] parseToBean:dict toClassArray:clsArray];
    return bean;
}

- (NSArray *)jsonStringToBeanArray:(NSString *)jsonString cls:(Class)cls
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSArray *beanArray = [[BeanParser shared] parseToBeanArr:dictArray toClassArray:clsArray];
    
    return beanArray;
}

- (NSString *)beanToJsonString:(NSObject *)bean
{
    NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSString *jsonString = [[BeanParser shared] beanToString:bean classArray:clsArray];
    return jsonString;
}
- (NSString *)beanArrayToJsonString:(NSArray *)beanArray cls:(Class)cls
{
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSString *string = [[BeanParser shared] beanArrToString:beanArray classArray:clsArray];
    return string;
}

- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    dict = [dict getDictionaryChangeStringToDate:self.dateFormat datetimeFormatString:self.datetimeFormat];
    return dict;
}

- (NSArray *)jsonStringToDictionaryArray:(NSString *)jsonString
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    arr = [arr getArrayChangeStringToDate:self.dateFormat datetimeFormatString:self.datetimeFormat];
    return arr;
}

- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字典不能为空"];
    NSAssert(dictionary, log);
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSString *string = [[BeanParser shared] dictionaryToString:dictionary];
    return string;
}

- (NSString *)dictionaryArrayToJsonString:(NSArray *)dictionaryArray
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字典数组不能为空"];
    NSAssert(dictionaryArray, log);
    dictionaryArray = [dictionaryArray getArrayChangeDateToString:self.datetimeFormat];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionaryArray options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}


- (NSDictionary *)beanToDictionary:(NSObject *)bean
{
    NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSDictionary *dictionary = [[BeanParser shared] beanToDictionary:bean classArray:clsArray];
    return dictionary;
}

- (id)dictionaryToBean:(NSDictionary *)dictionary cls:(Class)cls
{
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    id bean = [[BeanParser shared] parseToBean:dictionary toClassArray:clsArray];
    return bean;
}

- (NSArray *)beanArrayToDictionaryArray:(NSArray *)beanArray
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSDictionary *dict;
    for (id bean in beanArray) {
        dict = [self beanToDictionary:bean];
        [mutableArray addObject:dict];
    }
    return mutableArray;
}

- (NSArray *)dictionaryArrayToBeanArray:(NSArray *)dictionaryArray cls:(Class)cls
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSObject *obj;
    for (NSDictionary *dict in dictionaryArray) {
        obj = [self dictionaryToBean:dict cls:cls];
        [mutableArray addObject:obj];
    }
    return mutableArray;
}

#pragma mark - JSONModel Parse methods

- (NSArray *)JSONModelDictionaryArrayToBeanArray:(NSArray *)array cls:(Class)cls
{
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSArray *beanArray = [[BeanParser shared] JSONModelParseToBeanArray:array class:cls];
    return beanArray;
}

- (NSArray *)JSONModelStringToBeanArray:(NSString *)string cls:(Class)cls
{
    [BeanParser shared].datetimeFormat = self.datetimeFormat;
    [BeanParser shared].dateFormat = self.dateFormat;
    NSArray *beanArray = [[BeanParser shared] JSONModelStringToBeanArray:string class:cls];
    return beanArray;
}

- (id)JSONModelDictionaryToBean:(NSDictionary *)dictionary cls:(Class)cls
{
    id bean = [[cls alloc] initWithDictionary:dictionary error:nil];
    return bean;
}

- (id)JSONModelStringToBean:(NSString *)string cls:(Class)cls
{
    id bean = [[cls alloc] initWithString:string error:nil];
    return bean;
}

#pragma mark - private methods

/**
 *  获取类型的继承数组
 *
 *  @param cls         类型
 *  @param exceptClass 排除类型
 *
 *  @return 类型的继承数组
 */
- (NSArray *)getClassArrayWithClass:(Class)cls exceptClass:(Class)exceptClass
{
    //获取对象类型数组
    NSMutableArray *mutableArray = [NSMutableArray array];
    Class superCls = cls;
    while (![NSStringFromClass(superCls) isEqualToString:NSStringFromClass(exceptClass)]) {
        [mutableArray addObject:superCls];
        superCls = [superCls superclass];
    }
    return mutableArray;
}

@end
