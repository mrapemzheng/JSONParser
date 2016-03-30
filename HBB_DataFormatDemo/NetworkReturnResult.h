//
//  NetworkReturnResult.h
//  HBB_BuyerProject
//
//  Created by LUOCHENG DE on 15/10/15.
//  Copyright © 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络返回结果
 *
 *  @author apem
 */

@interface NetworkReturnResult : NSObject

@property (nonatomic, assign) NSInteger errcode;    //0或1=通讯成功，其它表示通讯不成功
@property (nonatomic, strong) NSString *errmsg;     //通讯错误信息描述
@property (nonatomic, assign) NSInteger resultcode; //0=业务处理成功，非0=业务处理不成功
@property (nonatomic, strong) NSString *resultmsg;  //业务错误信息描述
@property (nonatomic, strong) id Data;              //当errcode=0且resultcode=0，增加返回Data数据

/**
 *  实例化
 *
 *  @param dict 字典
 *
 *  @return 网络返回结果对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
