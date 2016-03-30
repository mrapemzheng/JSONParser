//
//  User.h
//  HBB_DataFormatDemo
//
//  Created by LUOCHENG DE on 15/11/6.
//  Copyright © 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) NSString *UserID;                 //会员内部账号（长度9位）\货宝宝账号
@property (nonatomic, strong) NSString *EntID;                  //企业账号
@property (nonatomic, strong) NSString *EntName;                //企业账号
@property (nonatomic, strong) NSString *UserCode;               //会员账号（默认手机号，可以修改）
@property (nonatomic, strong) NSString *UserName;               //真实姓名（认证后不可修改）
@property (nonatomic, strong) NSString *JobName;                //职位名称
@property (nonatomic, strong) NSString *Signature;              //个性签名
@property (nonatomic, strong) NSString *HeadImg;                //个人头像
@property (nonatomic, strong) NSString *LogoImg;                //企业头像
@property (nonatomic, strong) NSNumber *Sex;                    //性别：0男，1女
@property (nonatomic, strong) NSString *DepID;                  //所属组织架构编号
@property (nonatomic, strong) NSString *Phone;                  //个人手机(允许更换手机)
@property (nonatomic, strong) NSString *Call;                   //办公电话
@property (nonatomic, strong) NSString *Fax;                    //公司传真
@property (nonatomic, strong) NSString *Email;                  //邮箱
@property (nonatomic, strong) NSString *WXID;                   //微信账号
@property (nonatomic, strong) NSString *QQID;                   //QQ账号
@property (nonatomic, strong) NSNumber *IsAdmin;                //是否管理员（注册企业账号用户默认是管理员）
@property (nonatomic, strong) NSNumber *IsOnline;               ////是否在线*
@property (nonatomic, strong) NSNumber *IsCert;                 //身份认证状态：未认证，已认证
@property (nonatomic, strong) NSString *NickName;               //用户昵称,可重复*
@property (nonatomic, strong) NSString *PWD;                    //登录密码
@property (nonatomic, strong) NSNumber *Status;                 //账号状态：0未激活、1在职、2离职

@property (nonatomic, strong) NSDate *EntryDate;                //入职时间
@property (nonatomic, strong) NSString *DepFullName;            //部门全称
@property (nonatomic, strong) NSString *DepName;                //部门名称

@property (nonatomic, strong) NSString *EntCode;                //企业账号
@property (nonatomic, strong) NSDate *LastUpdateTime;           //最后修改时间

@property (nonatomic, strong) NSString *GroupName;              //分组名
@property (nonatomic, strong) NSNumber *GroupID;
@property (nonatomic, strong) NSString *UserCertStatus;         //个人认证状态：0未认证，1认证中，2认证失败，3认证成功
@property (nonatomic, strong) NSString *EntCertStatus ;         //企业认证状态：0未认证，1认证中，2认证失败，3认证成功
@property (nonatomic, strong) NSString *UserCheckID;             //申请人审核编号
@property (nonatomic, strong) NSString *CheckTime  ;            //审核时间
@property (nonatomic, strong) NSString *CheckName  ;            //审核人
@property (nonatomic, strong) NSString *CheckResult;            //审核结果说明，比如说明不通过的原因
@property (nonatomic, strong) NSString *CreatedDate;            //申请时间
@property (nonatomic, strong) NSString *ContactCount;           //人脉
@property (nonatomic, strong) NSNumber *IsContact;                   // 是否在通讯录中
@property (nonatomic, strong) NSNumber *HbbStatus; // 注册货宝宝状态 0=未注册 1=注册中 2=已注册
@property (nonatomic, strong) NSNumber *ContactStatus; // 通讯录联系人状态 0=不在通讯录 1=已在通讯录 2=已申请 等待同意


@end
