//
//  Hbb_JSONParserTests.m
//  HBB_DataFormatDemo
//
//  Created by LUOCHENG DE on 16/3/14.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Hbb_JSONParser.h"
#import "NewColleagueCheck.h"
#import "KgNetworkReturnResult.h"

@interface Hbb_JSONParserTests : XCTestCase

@end

@implementation Hbb_JSONParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/*字符串先转字典再转模型,字符串中含有日期
 */
- (void)testJsonToDictionaryThenToBean_forDateFormat
{
    NSString *json = @"{\"EntID\":\"\",\"EntCode\":\"\",\"Email\":\"\",\"EntName\":\"\",\"CheckTime\":\"\",\"UserName\":\"霍思燕\",\"Phone\":\"15692414056\",\"CreatedDate\":\"2016-03-14 13:04:24\",\"CheckName\":\"\",\"UserCode\":\"\",\"CheckResult\":\"\",\"Status\":\"\",\"JobName\":\"\",\"Sex\":1,\"UserID\":\"11223344\",\"UserCheckID\":\"\"}";
    Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
    NSDictionary *dict = [hbb_JSONParser jsonStringToDictionary:json];
    XCTAssert([dict objectForKey:@"CreatedDate"] != nil, @"时间转化失败,得到的时间为nil");
    
    NewColleagueCheck *newColleagueCheck = [hbb_JSONParser dictionaryToBean:dict cls:[NewColleagueCheck class]];
    XCTAssert(newColleagueCheck.CreatedDate != nil, @"时间转化失败,得到的时间为nil");
    
}

/*字典转模型
  模型上IsErr属性是NSInteger类型, 而json中的IsErr是字符串类型, 测试是否能成功转化
 */
- (void)test_DictionaryToBeanWithConflictType
{
    Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
    NSString *json = @"{\"IsErr\":\"0\"}";
    NSDictionary *dict = [hbb_JSONParser jsonStringToDictionary:json];
    KgNetworkReturnResult *kgNetworkResult = [hbb_JSONParser dictionaryToBean:dict cls:[KgNetworkReturnResult class]];
    XCTAssert(kgNetworkResult != nil, @"字典转模型失败");
}

/**
 测试单引号json字符串转化为字典
 */
- (void)test_singleSignalJsonExchange
{
    NSString *singleSignalStr = @"{\'customID\':\'20160324163322877983\',\'type\':\'SYS_UserApprove\',\'displayType\':\'0\',\'desc\':\'新同事审核\',\'title\':\'新同事审核\',\'url\':\'\',\'body\':[{\'EntID\':\'881621867515\',\'UserCode\':\'18819270592\',\'UserName\':\'55\',\'JobName\':\'\',\'Phone\':\'18819270592\',\'Sex\':\'0\',\'Email\':\'\',\'CreatedDate\':\'2016-03-24 16:33\'}],\'action\':{\'actionCode\':\'0\',\'afterOpen\':\'0\',\'beforeOpen\':\'0\'},\'extra\':{}}";
    NSData *data = [singleSignalStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
//    XCTAssert(dict != nil, @"单引号json字符串转化为字典失败");
    
    NSString *doubleSignalStr = @"{\"customID\":\"20160324163322877983\",\"type\":\"SYS_UserApprove\",\"displayType\":\"0\",\"desc\":\"新同事审核\",\"title\":\"新同事审核\",\"url\":\"\",\"body\":[{\"EntID\":\"881621867515\",\"UserCode\":\"18819270592\",\"UserName\":\"55\",\"JobName\":\"\",\"Phone\":\"18819270592\",\"Sex\":\"0\",\"Email\":\"\",\"CreatedDate\":\"2016-03-24 16:33\"}],\"action\":{\"actionCode\":\"0\",\"afterOpen\":\"0\",\"beforeOpen\":\"0\"},\"extra\":{}}";
    NSData *data2 = [doubleSignalStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err2;
    NSDictionary *dict2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:&err2];
    XCTAssert(dict2 != nil, @"双引号json字符串转化为字典失败");
    
}




@end
