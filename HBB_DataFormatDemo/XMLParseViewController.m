//
//  XMLParseViewController.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/8/1.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "XMLParseViewController.h"
//#import "Hbb_DataFormat.h"
#import <Hbb_DataFormatFramework/Hbb_XMLParser.h>
#import "SOAPObject.h"

@interface XMLParseViewController ()

@property (nonatomic, strong) NSString *xmlString;
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@property (nonatomic, strong) NSString *xmlBeanString;
@property (nonatomic, strong) SOAPObject *soapObject;

@property (nonatomic, strong) Hbb_XMLParser *hbb_XMLParser;
@end

@implementation XMLParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hbb_XMLParser = [[Hbb_XMLParser alloc] init];
    
    //xml字符串转字典
    self.xmlString = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><Body><GetData_GoodsColorList xmlns=\"http://tempuri.org/\"><sSerialNumber>219114051417237666</sSerialNumber><sKey>Kgsoft</sKey><OpTime>72389-06-02 22:37:02</OpTime><GoodsID></GoodsID><ColorID></ColorID></GetData_GoodsColorList></soap:Body></soap:Envelope>";
    
    self.dictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *multiDict = [NSMutableDictionary dictionary];
    [self.dictionary setObject:multiDict forKey:@"soap:Envelope"];
    
    NSMutableDictionary *multiLittle = [NSMutableDictionary dictionary];
    [multiDict setObject:multiLittle forKey:@"soap:Body"];
    
    NSMutableDictionary *multiSmall = [NSMutableDictionary dictionary];
    [multiLittle setObject:multiSmall forKey:@"GetData_GoodsColorList"];
    
    [multiSmall setObject:@"219114051417237666" forKey:@"sSerialNumber"];
    [multiSmall setObject:@"Kgsoft" forKey:@"sKey"];
    [multiSmall setObject:@"72389-06-02 22:37:02" forKey:@"OpTime"];
    [multiSmall setObject:@"" forKey:@"GoodsID"];
    [multiSmall setObject:@"" forKey:@"ColorID"];
    
    self.xmlBeanString = @"<?xml version=\"1.0\" encoding=\"utf-8\"?><GetData_GoodsColorList xmlns=\"http://tempuri.org/\"><sSerialNumber>219114051417237666</sSerialNumber><sKey>Kgsoft</sKey><OpTime>72389-06-02 22:37:02</OpTime><GoodsID></GoodsID><ColorID></ColorID></GetData_GoodsColorList>";
    
    self.soapObject = [[SOAPObject alloc] init];
    self.soapObject.sSerialNumber = @"123456";
    self.soapObject.sKey = @"kgsoft123456";
    self.soapObject.OpTime = [NSDate date];
    self.soapObject.GoodsID = @"goods123";
    self.soapObject.ColorID = @"";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

/**
 *  XML字符串转化为字典
 *
 *  @param sender 事件触发者
 */
- (IBAction)xmlStringToDictionary:(id)sender {
    NSDictionary *dict = [self.hbb_XMLParser xmlStringToDictionary:self.xmlString];
    NSLog(@"%s:XML字符串转化为字典dict=%@\n---------------------------------------\n", __FUNCTION__, dict);
}

/**
 *  字典转化为XML字符串
 *
 *  @param sender 事件触发者
 */
- (IBAction)dictionaryToXmlString:(id)sender {
    NSString *xmlString = [self.hbb_XMLParser dictionaryToXmlString:self.dictionary];
    NSLog(@"%s:字典转化为XML字符串,xmlString%@\n---------------------------------------\n", __FUNCTION__, xmlString);
    
}

/**
 *  XML字符串转化为模型对象
 *
 *  @param sender 事件触发者
 */
- (IBAction)xmlStringToBean:(id)sender {
    SOAPObject *soapObject = [self.hbb_XMLParser xmlStringToBean:self.xmlBeanString cls:[SOAPObject class]];
    NSLog(@"%s:XML字符串转化为模型对象,soapObject%@\n---------------------------------------\n", __FUNCTION__, soapObject);
}

/**
 *  模型对象转化为XML字符串
 *
 *  @param sender 事件触发者
 */
- (IBAction)beanToXmlString:(id)sender {
    NSString *xmlBeanString = [self.hbb_XMLParser beanToXmlString:self.soapObject];
    NSLog(@"%s:模型对象转化为XML字符串,xmlBeanString%@\n---------------------------------------\n", __FUNCTION__, xmlBeanString);
}

@end
