//
//  OSSCatchFileNameParam.h
//  HBB_BuyerProject
//
//  Created by LUOCHENG DE on 16/2/27.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * OSS获取文件名称参数
 * @author apem
 */
@interface OSSUploadFileParam : NSObject

/**
 分类编号：
 CloudEnt=企业云盘,CloudGroup=群云盘,CloudUser=个人云盘,EntCert=企业认证,EntPhoto=企业相册,Goods=商品管理,Other=其他文件,Partner=企业伙伴,UserCert=个人认证
 */
@property (nonatomic, strong) NSString *ClassID;//分类编号：(必须)
@property (nonatomic, strong) NSString *FileName; //文件名称 ((必须))
@property (nonatomic, strong) NSNumber *FileSize; //文件大小（单位：B） (必须)
@property (nonatomic, strong) NSString *FileType; //文件类型：jpg、png、xls (必须)
@property (nonatomic, strong) NSNumber *ImgWidth; //图像宽度（单位：像素）(图片必须)
@property (nonatomic, strong) NSNumber *ImgHeight; //图像高度（单位：像素）(图片必须)
@property (nonatomic, strong) NSString *SecondValueID; //第二个选项值编号，如：群ID，伙伴ID，商品ID (必须)
@property (nonatomic, strong) NSData *data; //文件二进制文件 (上传必须,其他非必须)

@end
