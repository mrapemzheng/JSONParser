//
//  KgNetworkReturnResult.h
//  KgOrderSys
//
//  Created by LUOCHENG DE on 16/3/15.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KgNetworkReturnResult : NSObject

@property (nonatomic, assign) NSInteger Count;      //记录条数
@property (nonatomic, strong) NSString *ErrMsg;     //错误信息描述
@property (nonatomic, assign) NSInteger ErrNo;      //错误代码
@property (nonatomic, assign) NSInteger IsErr;     //是否成功
@property (nonatomic, strong) id Data;

@end
