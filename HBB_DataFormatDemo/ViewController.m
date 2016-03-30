//
//  ViewController.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/29.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"
#import "MyInnerObject.h"
//#import "Hbb_DataFormat.h"
#import <objc/runtime.h>

#import "NetworkReturnResult.h"
#import <Hbb_DataFormatFramework/Hbb_DataFormatFramework.h>

#import "User.h"
#import "EncodingUtf-8.h"
#import "OSSUploadFileParam.h"
#import "Hbb_OSSOptional.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
//    //Test1
//    NSArray *arr = [NSArray arrayWithObjects:@"a",@"b", @"c", nil];
//    NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:@"name", @"google", @"application", @"add", arr, @"arr", nil];
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:21002], @"errcode", @"呵呵", @"errmsg", @0, @"resultcode,", @"", @"resultmsg", dataDict, @"Data", nil];
//    NetworkReturnResult *networkReturnResult = [[NetworkReturnResult alloc] initWithDictionary:dictionary];
//    NSDictionary *newDict = [[Hbb_JSONParser shared] beanToDictionary:networkReturnResult];
//    
//    
//    //Test2
//    NSString *str = @"{\"errcode\":\"0\",\"errmsg\":\"\",\"resultcode\":\"0\",\"resultmsg\":\"\",\"data\":{\"tableCount\":\"1\",\"table1\":[{\"EntCode\":\"r\",\"EntName\":\"the\",\"EntID\":\"116185283\"}],\"table1_rowCount\":\"1\",\"table1_columnCount\":\"3\",\"table1_columns\":\"EntCode&String|EntName&String|EntID&String\",\"table1_emptyRow\":[{\"EntCode\":\"null\",\"EntName\":\"null\",\"EntID\":\"null\"}]}}";
//    NSDictionary *dict2 = [[Hbb_JSONParser shared] jsonStringToDictionary:str];
//    NetworkReturnResult *networkReturnResult2 = [[NetworkReturnResult alloc] initWithDictionary:dict2];
//    
//    //Test3
//    NSString *str22 = @"[{\"EntID\":\"436298257\",\"UserID\":\"077826160\",\"UserCode\":\"18819270592\",\"UserName\":\"wjm\",\"JobName\":\"android%u5F00%u53D1\",\"Signature\":\"%u6211%u662F%u5434%u5C0F%u660E%uFF0C%u54C8%u54C8\",\"Sex\":\"0\",\"DepID\":\"947519681\",\"DepName\":\"%u4E00%u7EC4\",\"EntryDate\":\"2015-11-06\",\"HeadImg\":\"http%3A//wx.qlogo.cn/mmopen/LKZB7ahWBRjzeKxWgxeZlc88Te3MbEvZ3NGtfxyq0YRT3F4a5IMvLVbwsG1XAmOEZI8Ut10GqB9XIrZYibF4AR7V93FT5w54W/0\",\"DepFullName\":\"%u5E02%u573A%u90E8-%u5E02%u573A%u90E8-%u4E00%u90E8-%u4E00%u7EC4\",\"Phone\":\"18819270592\",\"Call\":\"18819270592\",\"Fax\":\"12345678\",\"Email\":\"336921@qq.com\",\"WXID\":\"123456\",\"QQID\":\"45975\",\"IsAdmin\":\"1\",\"Status\":\"1\"}]";
//    str22=[EncodingUtf_8 encode:str22];
//    NSArray *arr22 = [[Hbb_JSONParser shared] jsonStringToDictionaryArray:str22];
//    NSArray *beanArr22 = [[Hbb_JSONParser shared] dictionaryArrayToBeanArray:arr22 cls:[User class]];
//    
//    
//    //Test4
//    OSSUploadFileParam *ossUploadFileParam = [[OSSUploadFileParam alloc] init];
//    ossUploadFileParam.ClassID = @"";
//    ossUploadFileParam.FileName = @"test_file.png";
//    ossUploadFileParam.FileSize = [NSNumber numberWithInt:4000000];
//    ossUploadFileParam.FileType = @"";
//    ossUploadFileParam.ImgWidth = [NSNumber numberWithInt:3000];
//    ossUploadFileParam.ImgHeight = [NSNumber numberWithInt:3000];
//    ossUploadFileParam.SecondValueID = @"sendcond value id 001";
//    
//    NSArray *ossParamArr = [NSArray arrayWithObject:ossUploadFileParam];
//    NSArray * dict = [[Hbb_JSONParser shared] beanArrayToDictionaryArray:ossParamArr];
//    
//    //Test5
//    Hbb_OSSOptional *op1 = [[Hbb_OSSOptional alloc] init];
//    op1.scalePercent = 1;
//    Hbb_OSSOptional *op2 = [[Hbb_OSSOptional alloc] init];
//    op2.brightness = 99;
//    [[BeanParser shared] copyBeanToBean:op2 targetObj:op1 classArray:[NSArray arrayWithObjects:[Hbb_OSSOptional class], nil]];
//    
//    //Test6
//    
//    NSString *str3 = @"{\"errcode\":\"0\",\"errmsg\":\",\"resultcode\":\"0\",\"resultmsg\":\",\"data\":{\"tableCount\":\"4\",\"table1_rowCount\":\"1\",\"table1\":[{\"EntID\":\"365676788\",\"UserID\":\"809368864\",\"EntName\":\"货宝宝网络科技有限公司\",\"UserCode\":\"18819270592\",\"UserName\":\"狂野小肌肉男\",\"JobName\":\"市场总\",\"Signature\":\",\"HeadImg\":\"http://kinggen.oss-cn-hangzhou.aliyuncs.com/HBB/Album/1453947822657.jpg\",\"Email\":\"370940332@qq.com\",\"Sex\":\"0\",\"Phone\":\"18819270592\",\"Call\":\",\"Fax\":\",\"DepID\":\"163900056\",\"DepName\":\"市场部\",\"UserCertStatus\":\"0\",\"ContactCount\":\"4\",\"FavoriteQua\":\"8\",\"GroupName\":\"同事\",\"TagName\":\",\"ContactUserID\":\"809368864\",\"ContactStatus\":\"1\",\"Verification\":\"}],\"table2_rowCount\":\"1\",\"table2\":[{\"EntID\":\"365676788\",\"EntCode\":\"hbb\",\"EntName\":\"货宝宝网络科技有限公司\",\"LogoImg\":\"http://kinggen.oss-cn-hangzhou.aliyuncs.com/HBB/Album/1456387163485.jpg\",\"EntCall\":\"020-81236200\",\"EntFax\":\",\"WebSite\":\"www.baidu.com\",\"ServiceScore\":\"0.0\",\"Country\":\",\"Province\":\"广东省\",\"City\":\"广州市\",\"District\":\"越秀区\",\"MainAddress\":\"广东省广州市越秀区朝阳大街21-1\",\"GPS_Lng\":\"23.233300\",\"GPS_Lat\":\"113.223300\",\"EntCertStatus\":\"0\",\"EShopGoodsCount\":\"1\",\"BaseCount\":\"2\",\"HbbVenueCount\":\"3\"}],\"table3_rowCount\":\"1\",\"table3\":[{\"EntID\":\"365676788\",\"ExCount\":\"20\",\"ExBackRate\":\"0.20\",\"ImCount\":\"50\",\"ImBackRate\":\"0.10\",\"ExDeliveryRate\":\"1.00\"}],\"table4_rowCount\":\"1\",\"table4\":[{\"UserID\":\"329630481\",\"ContactUserID\":\"809368864\",\"GroupID\":\"0\"}]}}";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
