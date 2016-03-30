//
//  Hbb_OSSOptional.h
//  OSSDemo
//
//  Created by CHENG DE LUO on 15/12/8.
//  Copyright © 2015年 mige. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hbb_OSSOptional : NSObject

/**
 *  因为不能传入浮点数，负数，所以重新定义Size
 */
typedef struct {
    NSUInteger width;
    NSUInteger height;
    
}OSSSize;

typedef struct {
    NSUInteger x;
    NSUInteger y;
    NSUInteger width;
    NSUInteger height;
}OSSRect;


/**
 *  图片缩略类型
 */
typedef NS_ENUM(NSInteger, Hbb_OSSScalePriorityType) {
    Hbb_OSSScalePriorityTypeLong = 0,//长边优先
    Hbb_OSSScalePriorityTypeShort = 1,//短边优先
    Hbb_OSSScalePriorityTypeForce = 2//强制缩略
};

/**
 *  区域裁剪
 */
typedef NS_ENUM(NSInteger, Hbb_OSSClippingArea) {
    Hbb_OSSClippingAreaLeftTop = 1,//左上
    Hbb_OSSClippingAreaMiddleTop = 2,//中上
    Hbb_OSSClippingAreaRightTop = 3,//右上
    Hbb_OSSClippingAreaMiddleLeft = 4,//左中
    Hbb_OSSClippingAreaCenter = 5,//中部
    Hbb_OSSClippingAreaMiddleRight = 6,//右中
    Hbb_OSSClippingAreaLeftBottom = 7,//左下
    Hbb_OSSClippingAreaMiddleBottom = 8,//中下
    Hbb_OSSClippingAreaRightBottom = 9//右下
};

/**
 *  圆角裁剪类型
 */
typedef NS_ENUM(NSInteger, Hbb_OSSClippingCornerRaduisType) {
    Hbb_OSSClippingCornerRaduisOriginal = 0,//内切圆-表示图片最终大小仍然是原图大小
    Hbb_OSSClippingCornerRaduisFit = 1,//内切圆-表示图片最终大小是能包含这个圆的最小正方形
    Hbb_OSSClippingCornerRaduisRect = 2//圆角矩形
};

/**
 *  索引切割方向
 */
typedef NS_ENUM(NSInteger, Hbb_OSSClippingDirection) {
    Hbb_OSSClippingHorizontal = 0,//索引切割方向
    Hbb_OSSClippingVertical = 1,//内切圆-表示图片最终大小是能包含这个圆的最小正方形
};

/**
 *  旋转类型
 */
typedef NS_ENUM(NSInteger, Hbb_OSSRotateType) {
    Hbb_OSSRotateNone = 0,//不进行自动旋转
    Hbb_OSSRotateAfther = 1, //先进行缩略，再进行旋转
    Hbb_OSSRotateBefore = 2  //先进行旋转，再进行缩略
};


/**
 *  图片格式
 */
typedef NS_ENUM(NSInteger, Hbb_OSSImageFormat) {
    OSSImageSRCFormat = 1,  //按原图格式返回，如果原图是gif, 此时返回gif格式第一帧,保存成jpg格式，而非gif格式
    OSSImagePNGFormat = 2,//png格式
    OSSImageJPGFormat = 3, //jpg格式1
    OSSImageJPGWHFormat = 4, //jpg格式2:如果原图是png,webp,bmp存在透明通道，默认会把透明填充成黑色。如果想把透明填充成白色可以指定1wh参数
    OSSImageWEBPFormat = 5,  //webp格式
    OSSImageBMPFormat = 6 //bmp格式
};

/**
 *  渐进显示:jpg格式在呈现时有两种方式，一种是自上而下扫描式的，另外一种是先模糊后渐渐清晰
 */
typedef NS_ENUM(NSInteger, Hbb_OSSImageDisplayType) {
    Hbb_OSSImageDisplayNormal = 0,  //自上而下扫描式
    Hbb_OSSImageDisplayGradually = 1,//先模糊后渐渐清晰
};


@property (nonatomic, retain) NSNumber* scaleHandle;     //目标缩略图大于原图是否处理。值是1, 即不处理，是0，表示处理	0/1, 默认是0
@property (nonatomic, assign) NSUInteger scalePercent;   //百分比缩放。 小于100，即是缩小，大于100即是放大。	取值范围：1-1000
@property (nonatomic, retain) NSNumber* autoClipping;    //是否进行裁剪。如果是想对图进行自动裁剪，必须指定为1
@property (nonatomic, assign) NSUInteger rotationAngle;  //旋转角度。 取值范围：0-360
@property (nonatomic, assign) Hbb_OSSRotateType rotationType;  //旋转类型。
@property (nonatomic, assign) NSUInteger sharpen;        //锐化处理。取值越大，越清晰，为达到较优效果，推荐取值为100。 取值范围：[50, 399]
@property (nonatomic, assign) NSInteger brightness;      //亮度：0表示原图亮度，小于0表示亮度越低，大于0表示亮度越高	取值范围：[-100, 100]
@property (nonatomic, assign) NSInteger contrast;        //对比度：0表示原图对比度，小于0表示对比越低，大于0表示对比越高。 取值范围：[-100, 100]

@property (nonatomic, assign) NSUInteger relativeQuality; //相对质量（累积效果）：jpg格式适用，png格式则相当于绝对质量。 取值范围：[1, 100]
@property (nonatomic, assign) NSUInteger absoluteQuality; //绝对质量：jpg/png格式适用，同时指定了相对质量，则按绝对质量处理。 取值范围：[1, 100]
@property (nonatomic, assign) Hbb_OSSImageFormat imageFormat;//转换图片格式
@property (nonatomic, assign) Hbb_OSSImageDisplayType displayType;//渐进显示:原图是jpg格式才有效果。

//设置大小、矩形的方法
OSSRect OSSRectMake(NSUInteger x, NSUInteger y, NSUInteger width, NSUInteger height);
OSSSize OSSSizeMake(NSUInteger width, NSUInteger height);

@end
