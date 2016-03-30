//
//  NetworkReturnResult.m
//  HBB_BuyerProject
//
//  Created by LUOCHENG DE on 15/10/15.
//  Copyright © 2015年 CHENG DE LUO. All rights reserved.
//

#import "NetworkReturnResult.h"
#import <Hbb_DataFormatFramework/Hbb_DataFormatFramework.h>

@implementation NetworkReturnResult


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    Hbb_JSONParser *hbb_JsonParser = [[Hbb_JSONParser alloc] init];
    NetworkReturnResult *networkReturnResult = [hbb_JsonParser dictionaryToBean:dict cls:[NetworkReturnResult class]];
    return networkReturnResult;
}

@end
