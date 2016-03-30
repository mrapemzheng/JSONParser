//
//  Hbb_JSONParser.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "Hbb_JSONParser.h"
#import "APBeanParser.h"
#import "NSArray+DateString.h"
#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"

@interface Hbb_JSONParser ()

@property (nonatomic, strong) APBeanParser *apBeanParser;

@end

@implementation Hbb_JSONParser

- (void)setDateFormat:(NSString *)dateFormat
{
    _dateFormat = dateFormat;
    self.apBeanParser.dateFormat = _dateFormat;
}

- (void)setDatetimeFormat:(NSString *)datetimeFormat
{
    _datetimeFormat = datetimeFormat;
    self.apBeanParser.datetimeFormat = _datetimeFormat;
}

- (void)setNullParseType:(Hbb_JSONParserNullParseType)nullParseType
{
    _nullParseType = nullParseType;
    self.apBeanParser.nullParseType = (NullParseType)_nullParseType;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.datetimeFormat = @"yyyy-MM-dd HH:mm:ss";
        self.dateFormat = @"yyyy-MM-dd";
        self.nullParseType = Hbb_JSONParserNullParseTypeDefautNull;
        
        self.apBeanParser = [[APBeanParser alloc] init];
        self.apBeanParser.dateFormat = self.dateFormat;
        self.apBeanParser.datetimeFormat = self.datetimeFormat;
        self.apBeanParser.nullParseType = (NullParseType)self.nullParseType;
    }
    return self;
}

//+ (instancetype)shared
//{
//    static Hbb_JSONParser *hbb_JSONParser;
//    static dispatch_once_t once_t;
//    dispatch_once(&once_t, ^(void){
//        hbb_JSONParser = [[Hbb_JSONParser alloc] init];
//    });
//    return hbb_JSONParser;
//}

- (id)jsonStringToBean:(NSString *)jsonString cls:(Class)cls
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSDictionary *dict = [self jsonStringToDictionary:jsonString];
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    id bean = [self.apBeanParser parseToBean:dict toClassArray:clsArray];
    return bean;
}

- (NSArray *)jsonStringToBeanArray:(NSString *)jsonString cls:(Class)cls
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    NSArray *beanArray = [self.apBeanParser parseToBeanArr:dictArray toClassArray:clsArray];
    
    return beanArray;
}

- (NSString *)beanToJsonString:(NSObject *)bean
{
    NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    NSString *jsonString = [self.apBeanParser beanToString:bean classArray:clsArray];
    return jsonString;
}
- (NSString *)beanArrayToJsonString:(NSArray *)beanArray cls:(Class)cls
{
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    NSString *string = [self.apBeanParser beanArrToString:beanArray classArray:clsArray];
    return string;
}

- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    dict = [dict getDictionaryChangeStringToDate:self.dateFormat datetimeFormatString:self.datetimeFormat];
    return dict;
}

- (NSArray *)jsonStringToDictionaryArray:(NSString *)jsonString
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字符串不能为空"];
    NSAssert(jsonString, log);
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    arr = [arr getArrayChangeStringToDate:self.dateFormat datetimeFormatString:self.datetimeFormat];
    return arr;
}

- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"字典不能为空"];
    NSAssert(dictionary, log);
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    NSString *string = [self.apBeanParser dictionaryToString:dictionary];
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
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"模型对象不能为空"];
    NSAssert(bean, log);
    NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    NSDictionary *dictionary = [self.apBeanParser beanToDictionary:bean classArray:clsArray];
    return dictionary;
}

- (id)dictionaryToBean:(NSDictionary *)dictionary cls:(Class)cls
{
    NSString *log = [NSString stringWithFormat:@"%s:%@", __func__, @"模型对象不能为空"];
    NSAssert(dictionary, log);
    
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
//    self.apBeanParser.datetimeFormat = self.datetimeFormat;
//    self.apBeanParser.dateFormat = self.dateFormat;
    
    id bean;
    if (dictionary) {
       bean = [self.apBeanParser parseToBean:dictionary toClassArray:clsArray];
    }
    
    return bean;
}

- (NSArray *)beanArrayToDictionaryArray:(NSArray *)beanArray
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSDictionary *dict;
    for (id bean in beanArray) {
        dict = [self beanToDictionary:bean];
        if(dict) {
            [mutableArray addObject:dict];
        }
        
    }
    return mutableArray;
}

- (NSArray *)dictionaryArrayToBeanArray:(NSArray *)dictionaryArray cls:(Class)cls
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSObject *obj;
    for (NSDictionary *dict in dictionaryArray) {
        obj = [self dictionaryToBean:dict cls:cls];
        if (obj) {
            [mutableArray addObject:obj];
        }
    }
    return mutableArray;
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
