//
//  JSONParseViewController.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/1.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "JSONParseViewController.h"
#import <Foundation/Foundation.h>
//#import "Hbb_DataFormat.h"

#import <Hbb_DataFormatFramework/Hbb_JSONParser.h>
#import <Hbb_DataFormatFramework/Hbb_XMLParser.h>

#import "MyObject.h"
#import "MyInnerObject.h"

@interface JSONParseViewController ()

@property (nonatomic, strong) NSString *jsonArrayStr;
@property (nonatomic, strong) NSString *jsonStr;

@property (nonatomic, strong) MyObject *myObject;
@property (nonatomic, strong) NSMutableArray *myObjectArray;

@property (nonatomic, strong) Hbb_JSONParser *hbb_JSONParser;
@property (nonatomic, strong) Hbb_XMLParser *hbb_XMLParser;

@end

@implementation JSONParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hbb_JSONParser = [[Hbb_JSONParser alloc] init];
    self.hbb_XMLParser = [[Hbb_XMLParser alloc] init];
    

    self.jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
    
    self.jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
    
    //对象
    self.myObject = [[MyObject alloc] init];
    self.myObject.integer = 1;
    self.myObject.normalFloat = 1.0;
    self.myObject.normalLong = 1;
    self.myObject.normalInt = 1;
    self.myObject.array = [NSArray array];
    self.myObject.dictionary = [NSDictionary dictionary];
    self.myObject.date = [NSDate date];

    MyInnerObject *myInnerObject = [[MyInnerObject alloc] init];
    myInnerObject.str = @"str";
    myInnerObject.str2 = nil;
    self.myObject.myInnerObject = myInnerObject;
    
    //数组
    self.myObjectArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 2; i ++) {
        MyObject *myObject = [[MyObject alloc] init];
        myObject.integer = 3;
        myObject.normalFloat = 1.0;
        myObject.normalLong = 1;
        myObject.normalInt = 1;
        myObject.array = [NSArray array];
        myObject.dictionary = [NSDictionary dictionary];
        myObject.date = [NSDate date];
        
        MyInnerObject *myInnerObject = [[MyInnerObject alloc] init];
        myInnerObject.str = @"str";
        myInnerObject.str2 = @"str2";
        myObject.myInnerObject = myInnerObject;
        [self.myObjectArray addObject:myObject];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

/**
 *  JSON字符串转化为模型对象
 *
 *  @param sender 发送者
 */
- (IBAction)jsonStringToBean:(id)sender {
    MyObject *myObject = [self.hbb_JSONParser jsonStringToBean:self.jsonStr cls:[MyObject class]];
    [myObject.date timeIntervalSince1970];
    NSLog(@"%s:JSON字符串转化为模型对象myObject=%@\n---------------------------\n", __func__, myObject);
}

/**
 *  JSON字符串转化为模型对象数组
 *
 *  @param sender 发送者
 */
- (IBAction)jsonStringToBeanArray:(id)sender {
    NSArray *beanArray = [self.hbb_JSONParser jsonStringToBeanArray:self.jsonArrayStr cls:[MyObject class]];
    NSLog(@"%s:JSON字符串转化为模型对象数组beanArray=%@\n---------------------------\n", __func__, beanArray);
}

/**
 *  模型对象转化为JSON字符串
 *
 *  @param sender 发送者
 */
- (IBAction)beanToJsonString:(id)sender {
    self.hbb_JSONParser.nullParseType = Hbb_JSONParserNullParseTypeNoNotParseWhenNull;
    NSString *jsonString = [self.hbb_JSONParser beanToJsonString:self.myObject  ];
    NSLog(@"%s模型对象转化为JSON字符串jsonString1 默认null=%@\n---------------------------\n", __func__, jsonString);
    
    self.hbb_JSONParser.nullParseType = Hbb_JSONParserNullParseTypeDefautNull;
    NSString *jsonString2 = [self.hbb_JSONParser beanToJsonString:self.myObject  ];
    NSLog(@"%s模型对象转化为JSON字符串jsonString2 不转化null =%@\n---------------------------\n", __func__, jsonString2);
    
    self.hbb_JSONParser.nullParseType = Hbb_JSONParserNullParseTypeAlphabeticString;
    NSString *jsonString3 = [self.hbb_JSONParser beanToJsonString:self.myObject  ];
    NSLog(@"%s模型对象转化为JSON字符串jsonString3 null转化为\"\" =%@\n---------------------------\n", __func__, jsonString3);
}

/**
 *  模型对象数组转化为JSON字符串
 *
 *  @param sender 发送者
 */
- (IBAction)beanArrayToJsonString:(id)sender {
    NSString *jsonArrayString = [self.hbb_JSONParser beanArrayToJsonString:self.myObjectArray cls:[MyObject class]];
     NSLog(@"%s 模型对象数组转化为JSON字符串jsonArrayString=%@\n---------------------------\n", __func__, jsonArrayString);
}

/**
 *  JSON字符串转化为字典
 *
 *  @param sender 发送者
 */
- (IBAction)jsonStringToDictionary:(id)sender {
    NSDictionary *dict = [self.hbb_JSONParser jsonStringToDictionary:self.jsonStr];
    NSLog(@"%s JSON字符串转化为字典dict=%@\n---------------------------\n", __func__, dict);
}

/**
 *  JSON字符串转化为字典数组
 *
 *  @param sender 发送者
 */
- (IBAction)jsonStringToDictionaryArray:(id)sender {
    NSArray *array = [self.hbb_JSONParser jsonStringToDictionaryArray:self.jsonArrayStr];
     NSLog(@"%s JSON字符串转化为字典数组array=%@\n---------------------------\n", __func__, array);
}

/**
 *  字典转化为JSON字符串
 *
 *  @param sender 发送者
 */
- (IBAction)dictionaryToJsonString:(id)sender {
    NSDictionary *dict = [self.hbb_JSONParser beanToDictionary:self.myObject];
    NSString *jsonString = [self.hbb_JSONParser dictionaryToJsonString:dict];
    NSLog(@"%s 字典转化为JSON字符串jsonString=%@\n---------------------------\n", __func__, jsonString);
}

/**
 *  字典数组转化为JSON字符串
 *
 *  @param sender 发送者
 */
- (IBAction)dictionaryArrayToJsonString:(id)sender {
    NSArray *dictArray = [self.hbb_JSONParser beanArrayToDictionaryArray:self.myObjectArray];
    NSString *jsonArrayString = [self.hbb_JSONParser dictionaryArrayToJsonString:dictArray];
    NSLog(@"%s字典数组转化为JSON字符串 jsonArrayString=%@\n---------------------------\n", __func__, jsonArrayString);
}

/**
 *  模型对象转化为字典
 *
 *  @param sender 发送者
 */
- (IBAction)beanToDictionary:(id)sender {
    NSDictionary *dict = [self.hbb_JSONParser beanToDictionary:self.myObject];
    NSLog(@"%s 模型对象转化为字典dict=%@\n---------------------------\n", __func__, dict);
}

/**
 *  字典转化为模型对象
 *
 *  @param sender 发送者
 */
- (IBAction)dictionaryToBean:(id)sender {
    NSDictionary *dict = [self.hbb_JSONParser jsonStringToDictionary:self.jsonStr];
    MyObject *myObject = [self.hbb_JSONParser dictionaryToBean:dict cls:[MyObject class]];
    NSLog(@"%s 字典转化为模型对象myObject=%@\n---------------------------\n", __func__, myObject);
}


@end
