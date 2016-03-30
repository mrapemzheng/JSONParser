//
//  BeanParser.m
//  KgOrderSys
//
//  Created by apem on 14-10-26.
//  Copyright (c) 2014年 CHENG DE LUO. All rights reserved.
//

#import "BeanParser.h"
#import <objc/runtime.h>
#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"

/**
 * JSON 转化注意问题
 * 1. 转化时只识别 NSDictionary 和 普通对象数组
 * 2. NSDictionary值不能为nil(空引用)
 * 3. JSON转化不支持NSDate, NSDate要事先转化为NSString
 *
 */

//KVC

#define D_DefaultDateTimeFormat @"yyyy-MM-dd HH:mm:ss"
#define D_DefaultDateFormat @"yyyy-MM-dd"

static BeanParser *beanParser;

@interface BeanParser ()

@property (nonatomic, strong) NSArray *allowedJSONTypes;
@property (nonatomic, strong) NSArray *allowedPrimitiveTypes;

@end

@implementation BeanParser

//单例
+ (instancetype)shared
{
    if (beanParser == nil) {
        beanParser = [[BeanParser alloc] init];
    }
    return beanParser;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    self.dateFormat = D_DefaultDateFormat;
    self.datetimeFormat = D_DefaultDateTimeFormat;
    
    self.allowedJSONTypes = @[
                         [NSString class], [NSNumber class], [NSDate class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], //immutable JSON classes
                         [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class] //mutable JSON classes
                         ];
    
    self.allowedPrimitiveTypes = @[
                              @"BOOL", @"float", @"int", @"long", @"double", @"short",
                              //and some famous aliases
                              @"NSInteger", @"NSUInteger",
                              @"Block"
                              ];

}

//dict 转 bean
- (id)parseToBean:(NSDictionary *)dict toClassArray:(NSArray * )clsArr
{
    NSString *log = [NSString stringWithFormat:@"%s:字典不能为空", __func__];
    NSAssert(dict, log);
    Class cls = [clsArr firstObject];
    id obj = [[cls alloc] init];
    unsigned int outCount;
    for (NSInteger i = 0; i < clsArr.count; i ++) {
        Class curCls = [clsArr objectAtIndex:i];
        objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
        for (unsigned int i = 0; i < outCount; i ++) {
            objc_property_t myProperty = properties[i];
            NSString *propertyName = [NSString stringWithUTF8String:property_getName(myProperty)];
            
            const char *attr = property_getAttributes(myProperty);
            NSString *nsAttr = [[NSString alloc] initWithUTF8String:attr];
            //如果是常规类型
            if ([self isAllowedJSONTypes:nsAttr] || ![nsAttr containsString:@"@"]) {
                if(![[dict objectForKey:propertyName] isKindOfClass:[NSNull class]]) {
                    //字符串
                    if([[dict objectForKey:propertyName] isKindOfClass:[NSString class]]) {
                        //PHP时间
                        if ([self isPHPNSDate:[dict objectForKey:propertyName]]) {
                            NSDate *date = [self changePHPToNSDate:[dict objectForKey:propertyName] withFormatter:self.datetimeFormat];
                            [obj setValue:date forKey:propertyName];
                        //日期格式
                        }else if([self isDateFormat:[dict objectForKey:propertyName]]) {
                            NSDate *date = [self stringToDefaultDatetime:[dict objectForKey:propertyName]];
                            [obj setValue:date forKey:propertyName];
                        //不为空字符串
                        } else if([dict objectForKey:propertyName]){
                            [obj setValue:[dict objectForKey:propertyName] forKey:propertyName];
                        }
                    //不为空其他类型
                    } else if([dict objectForKey:propertyName]) {
                        [obj setValue:[dict objectForKey:propertyName] forKey:propertyName];
                    }
                }
            //自定义对象类型,并且不是基本类型
            } else if([nsAttr containsString:@"@"]) {
                NSDictionary *attrDict = [dict objectForKey:propertyName];
                Class attrObjCls = [self getClassWithPropertyAttribute:nsAttr];
                NSArray *clsArray = [self getClassArrayWithClass:attrObjCls exceptClass:[NSObject class]];
                //如果字典不为空
                if(attrDict) {
                    id attrBean = [self parseToBean:attrDict toClassArray:clsArray];
                    //如果转化后的对象不为空
                    if (attrBean) {
                        [obj setValue:attrBean forKey:propertyName];
                    } else {
                        [obj setValue:[NSNull null] forKey:propertyName];
                    }
                }
                
            }
            
        }
        free(properties);
    }
    
    return obj;
}

//dict array 转 bean array
- (NSArray *)parseToBeanArr:(NSArray *)arr toClassArray:(NSArray * )clsArr
{
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i ++) {
        [mutableArr addObject:[self parseToBean:[arr objectAtIndex:i] toClassArray:clsArr]];
    }
    return  [mutableArr copy];
}

//bean转NSDictionary
//参数:BEAN cls:以什么类被转化
- (NSDictionary *)beanToDictionary:(NSObject *)bean classArray:(NSArray *)clsArr
{
    
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    unsigned int i;
    
    //本类的属性
    objc_property_t *properties = class_copyPropertyList([bean class], &outCount);
    for (i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        const char *attr = property_getAttributes(property);
        NSString *nsAttr = [[NSString alloc] initWithUTF8String:attr];
        
        //如果是常规类型
        if ([self isAllowedJSONTypes:nsAttr] || ![nsAttr containsString:@"@"]) {
            SEL selGet = NSSelectorFromString(key);
            if (bean && [bean respondsToSelector:selGet]) {
                NSObject *valObj = [bean valueForKey:key];
                
                //NSDctionary的值不能为nil, 如果为nil,那么赋值空字符串
                if (valObj) {
//                    //系统JSON转化不支持NSDate类型,所以要扫描整个类如果有NSDate类型就要转成标准字符串
//                    if ([valObj isKindOfClass:[NSDate class]]) {
//                        valObj = [self datetimeToDefaultString:(NSDate *)valObj];
//                    }
                    
                    [mutableDict setObject:valObj forKey:key];
                } else {
                    [mutableDict setObject:[NSNull null] forKey:key];
                }
            }
            
        //自定义对象类型,并且不是基本类型
        } else if([nsAttr containsString:@"@"]) {
            id obj = [bean valueForKey:key];
            NSArray *clsArray = [self getClassArrayWithClass:[obj class] exceptClass:[NSObject class]];
            //对象不为空
            if (obj) {
                NSDictionary *dict = [self beanToDictionary:obj classArray:clsArray];
                //字典不为空
                if(dict) {
                    [mutableDict setObject:dict forKey:key];
                //字典为空
                } else {
                    [mutableDict setObject:[NSNull null] forKey:key];
                }
                
            //对象为空
            } else {
                [mutableDict setObject:[NSNull null] forKey:key];
            }
        }
    }
    free(properties);
    
    //如果还有父类的属性
    if (clsArr && clsArr.count > 0) {
        unsigned int j;
        for( j = 0;j < clsArr.count;j ++) {
            unsigned int outCount;
            unsigned int i;
            Class curCls = [clsArr objectAtIndex:j];
            objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
            for (i = 0; i < outCount; i ++) {
                objc_property_t property = properties[i];
                NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                SEL selGet = NSSelectorFromString(key);
                
                const char *attr = property_getAttributes(property);
                NSString *nsAttr = [[NSString alloc] initWithUTF8String:attr];
                
                //如果是常规类型
                if ([self isAllowedJSONTypes:nsAttr] || ![nsAttr containsString:@"@"]) {
                    if (bean && [bean respondsToSelector:selGet]) {
                        NSObject *valObj = [bean valueForKey:key];
                        //NSDctionary的值不能为nil
                        if (valObj) {
//                            //系统JSON转化不支持NSDate类型,所以要扫描整个类如果有NSDate类型就要转成标准字符串
//                            if ([valObj isKindOfClass:[NSDate class]]) {
//                                valObj = [self datetimeToDefaultString:(NSDate *)valObj];
//                            }
                            [mutableDict setObject:valObj forKey:key];
                        }else {
                            [mutableDict setObject:[NSNull null] forKey:key];
                        }
                    }
                    //自定义对象类型,并且不是基本类型
                } else if([nsAttr containsString:@"@"]) {
                    id obj = [bean valueForKey:key];
                    NSArray *clsArray = [self getClassArrayWithClass:[obj class] exceptClass:[NSObject class]];
                    NSDictionary *dict = [self beanToDictionary:obj classArray:clsArray];
                    [mutableDict setObject:dict forKey:key];
                }
                
            }
            free(properties);
        }
    }
    
    return [mutableDict copy];
}

//字典转化为字符串
- (NSString *)dictionaryToString:(NSDictionary *)dict
{
    dict = [dict getDictionaryChangeDateToString:self.datetimeFormat];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

//对象转字符串
- (NSString *)beanToString:(NSObject *)bean classArray:(NSArray *)clsArr
{
    NSDictionary *dict = [self beanToDictionary:bean classArray:clsArr];
    dict = [dict getDictionaryChangeDateToString:self.datetimeFormat];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0  error:&error];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//实体类数组转字符串
- (NSString *)beanArrToString:(NSArray *)array classArray:(NSArray *)clsArr
{
   
    NSData *data = nil;
    if (array && array.count > 0 ) {
        NSMutableArray *mulArr = [NSMutableArray array];
        for(NSObject *bean in array) {
            [mulArr addObject:[self beanToDictionary:bean classArray:clsArr]];
        }
        
        //data = [[mulArr copy] JSONData];
        mulArr = [[mulArr getArrayChangeDateToString:self.datetimeFormat] mutableCopy];
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:[mulArr copy] options:0 error:&error];
    } else {
        data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    }
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//复制源BEAN中不为空的值给目标BEAN
- (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj classArray:(NSArray *)clsArr
{
    //迭代所有类的属性
    if (clsArr && clsArr.count > 0) {
        unsigned int j;
        for( j = 0;j < clsArr.count;j ++) {
            unsigned int outCount;
            unsigned int i;
            Class curCls = [clsArr objectAtIndex:j];
            objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
            for (i = 0; i < outCount; i ++) {
                objc_property_t property = properties[i];
                NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                SEL selGet = NSSelectorFromString(key);
                
                if (sourceObj && [sourceObj respondsToSelector:selGet]) {
                    NSObject *valObj = [sourceObj valueForKey:key];
                    //NSDctionary的值不能为nil
                    if (valObj) {
                        NSString *method1 = key;
                        NSString *str = @"set";
                        method1 = [[[method1 substringToIndex:1] uppercaseString] stringByAppendingString:[method1 substringFromIndex:1]];
                        method1 = [str stringByAppendingString:method1];
                        method1 = [method1 stringByAppendingString:@":"];
                        SEL selector =  NSSelectorFromString(method1);
                        
                        if (targetObj && [targetObj respondsToSelector:selGet]) {
                            [targetObj performSelector:selector withObject:valObj];
                        }
                    }
                }
            }
            free(properties);
        }
    }
}

#pragma mark - JSONModel Parsing

//数组转实体类数组 连带级联
- (NSArray *)JSONModelParseToBeanArray:(NSArray *)arr class:(Class)cls
{
    NSMutableArray *mutableArr = [NSMutableArray array];
    id model;
    if(arr && arr.count) {
        for (NSInteger i = 0; i < arr.count; i ++) {
            model = [[cls alloc] initWithDictionary:[arr objectAtIndex:i] error:nil];
            if (model) {
                [mutableArr addObject:model];
            }
        }
    }
    return mutableArr;
}

//字符串转实体类数组 连带级联
- (NSArray *)JSONModelStringToBeanArray:(NSString *)str class:(Class)cls
{
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    return [self JSONModelParseToBeanArray:arr class:cls];
}

#pragma mark - NSString && NSDate parse methods

/**
 *  是否日期/时间格式
 *
 *  @return 是否日期格式/时间
 */
- (BOOL)isDateFormat:(NSString *)dateStr
{
    BOOL b = NO;
    if (dateStr) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = self.dateFormat;
        NSDate *date = [dateFormat dateFromString:dateStr];
        
        dateFormat.dateFormat = self.datetimeFormat;
        NSDate *date2 = [dateFormat dateFromString:dateStr];
        
        if (date || date2) {
            b = YES;
        }
    }
    return b;
}

NSString *PHPDatePrefix = @"/Date(";
NSString *PHPDateSuffix = @")/";

//是否是PHP格式的date
- (BOOL)isPHPNSDate:(NSString *)dateStr
{
    if (dateStr && dateStr.length > (PHPDatePrefix.length + PHPDateSuffix.length)) {
        BOOL b1 = [[dateStr substringToIndex:PHPDatePrefix.length] isEqualToString:PHPDatePrefix];
        BOOL b2 = [[dateStr substringFromIndex:(dateStr.length - PHPDateSuffix.length)] isEqualToString:PHPDateSuffix];
        return (b1 && b2);
    }
    return NO;
}


// 转化时间戳为日期对象 固定格式：/Date(1394259720000)/
- (NSDate *)changePHPToNSDate:(NSString *)date withFormatter:(NSString *)format
{
    NSDate *pDate = nil;
    date = [NSString stringWithFormat:@"%@", date];
    if (date && ![date isEqualToString:@"<null>"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if (format == nil) {
            [formatter setDateFormat:self.datetimeFormat];
        } else {
            [formatter setDateFormat:format];
        }
        date = [date stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@")/" withString:@""];
        date = [date substringToIndex:10];
        
        pDate = [NSDate dateWithTimeIntervalSince1970:[date intValue]];
    }
    return pDate;
}

//时间格式化为字符串
- (NSString *)dateToString:(NSDate *)date withFormatter:(NSString *)format
{
    NSString *str = @"";
    if ([self isNotBlank:date] && [self isNotBlank:format]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = format;
        str = [df stringFromDate:date];
    }
    return str;
}

//默认日期转换字符串
- (NSString *)dateToDefaultString:(NSDate *)date
{
    return [self dateToString:date withFormatter:self.datetimeFormat];
}

//默认日期时间转换字符串
- (NSString *)datetimeToDefaultString:(NSDate *)date
{
    return [self dateToString:date withFormatter:self.datetimeFormat];
}

//字符串转日期
- (NSDate *)stringToDate:(NSString *)string withFormatter:(NSString *)format
{
    NSDate *date = nil;
    if ([self isNotBlank:string] && [self isNotBlank:format]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = format;
        date = [df dateFromString:string];
    }
    return date;
}

//默认字符串转日期
- (NSDate *)stringToDefaultDate:(NSString *)string
{
    return [self stringToDate:string withFormatter:self.datetimeFormat];
}

//默认字符串转日期时间
- (NSDate *)stringToDefaultDatetime:(NSString *)string
{
    return [self stringToDate:string withFormatter:self.datetimeFormat];
}

//获取NSDateComponents, 通过他可以获取年月日时分秒
- (NSDateComponents *)getNSDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    return comps;
}

//判断是否不为空
//支持 NSString, NSDate
- (BOOL)isNotBlank:(NSObject *)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        if (str != nil && str.length != 0) {
            return YES;
        }
    } else {
        if (obj) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - About Rejection

// 利用反射取得NSObject的属性，并存入到数组中
- (NSArray *)getPropertyList:(NSArray *)clsArr
{
    NSMutableArray *propertyArray = [NSMutableArray array];
    for(NSInteger i = 0;i < clsArr.count;i ++) {
        Class clazz = [clsArr objectAtIndex:i];
        u_int count;
        objc_property_t *properties = class_copyPropertyList(clazz, &count);
        for (int i = 0; i < count ; i++)
        {
            const char* propertyName = property_getName(properties[i]);
            [propertyArray addObject: [NSString stringWithUTF8String: propertyName]];
        }
        free(properties);
    }
    
    return propertyArray;
}

/**
 *  是否JSON对象常规类型
 *
 *  @param property_attr 对象属性attribute
 *
 *  @return 是否JSON对象常规类型
 */
- (BOOL)isAllowedJSONTypes:(NSString *)property_attr
{
    BOOL b = NO;
    
    Class allowType;
    for(NSInteger i = 0;i < self.allowedJSONTypes.count;i ++) {
        allowType = [self.allowedJSONTypes objectAtIndex:i];
        if ([property_attr containsString:NSStringFromClass(allowType)]) {
            b = YES;
            return b;
        }
    }
    return b;
}

/**
 *  从 objc_property_t 的attribute中获取对象类型
 *
 *  @return objc_property_t 的attribute中获取对象类型
 */
- (Class)getClassWithPropertyAttribute:(NSString *)property_attr
{
    Class cls;
    NSString *property_attr_copy  = [property_attr  mutableCopy];
    if ([property_attr_copy containsString:@"@"]) {
        NSRange firstRange = [property_attr_copy rangeOfString:@"\""];
        property_attr_copy = [property_attr_copy substringFromIndex:firstRange.location + 1];
        
        if ([property_attr_copy containsString:@"<"]) {
            NSRange lastRange = [property_attr_copy rangeOfString:@"<"];
            property_attr_copy = [property_attr_copy substringToIndex:lastRange.location];
        } else {
            NSRange lastRange = [property_attr_copy rangeOfString:@"\""];
            property_attr_copy = [property_attr_copy substringToIndex:lastRange.location];
        }
        
        if (property_attr_copy) {
            cls = NSClassFromString(property_attr_copy);
        }
    }
    return cls;
}

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