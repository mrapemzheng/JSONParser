//
//  Hbb_XMLParser.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "Hbb_XMLParser.h"
#import "XMLDictionary.h"
#import "BeanParser.h"

@implementation Hbb_XMLParser

+ (instancetype)shared
{
    static Hbb_XMLParser *hbb_XMLParser;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^(void){
        hbb_XMLParser = [[Hbb_XMLParser alloc] init];
    });
    return hbb_XMLParser;
}

- (NSDictionary *)xmlStringToDictionary:(NSString *)xmlString
{
    NSDictionary *dict = [NSDictionary dictionaryWithXMLString:xmlString];
//    NSDictionary *attributes = [dict attributes];
//    NSDictionary *childNodes = [dict childNodes];
//    NSArray *comments = [dict comments];
//    NSString *nodeName = [dict nodeName];
//    NSString *innerText = [dict innerText];
//    NSString *innerXML = [dict innerXML];
//    NSString *XMLString = [dict XMLString];
    
    return dict;
}

- (NSString *)dictionaryToXmlString:(NSDictionary *)dictionary
{
    NSString *xmlString = [dictionary XMLString];
    return xmlString;
}

- (id)xmlStringToBean:(NSString *)xmlString cls:(Class)cls
{
    NSDictionary *dict = [self xmlStringToDictionary:xmlString];
    NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
    id bean = [[BeanParser shared] parseToBean:dict toClassArray:clsArray];
    return bean;
}

- (NSString *)beanToXmlString:(NSObject *)bean
{
    NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
    NSDictionary *dict = [[BeanParser shared] beanToDictionary:bean classArray:clsArray];
    NSString *xmlString = [dict XMLString];
    return xmlString;
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
