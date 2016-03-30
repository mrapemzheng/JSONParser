//
//  NewColleagueCheck.h
//  HBB_BuyerProject
//
//  Created by CHENG DE LUO on 15/11/30.
//  Copyright © 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewColleagueCheck : NSObject

@property (nonatomic, strong) NSString *UserID;                 //会员内部账号（长度9位）\货宝宝账号
@property (nonatomic, strong) NSString *UserCode;               //会员账号（默认手机号，可以修改）
@property (nonatomic, strong) NSString *UserName;               //真实姓名（认证后不可修改）
@property (nonatomic, strong) NSString *EntID;                  //企业账号
@property (nonatomic, strong) NSString *EntName;                  //企业账号
@property (nonatomic, strong) NSString *EntCode;                //企业账号
@property (nonatomic, strong) NSString *JobName;                //职位名称
@property (nonatomic, strong) NSString *Phone;                  //个人手机(允许更换手机)
@property (nonatomic, strong) NSString *Email;                  //邮箱
@property (nonatomic, strong) NSDate *CreatedDate;              //申请时间
@property (nonatomic, strong) NSNumber *Status;                 //账号状态：1同意、2拒绝
@property (nonatomic, strong) NSNumber *Sex;                    //性别：0男，1女
@property (nonatomic, strong) NSString *UserCheckID;            //申请人ID
@property (nonatomic, strong) NSDate *CheckTime;              //审核时间
@property (nonatomic, strong) NSString *CheckName;              // 审核人
@property (nonatomic, strong) NSString *CheckResult;            //审核结果说明，比如说明不通过的原因

@end
