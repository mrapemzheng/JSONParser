//
//  MyObject.h
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyInnerObject.h"

@protocol MyObjectDelegate <NSObject>

@end

@interface MyObject : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) int normalInt;
@property (nonatomic, assign) long normalLong;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, strong) MyInnerObject *myInnerObject;
@property (nonatomic, assign) CGFloat cgfloat;
@property (nonatomic, assign) float normalFloat;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *str;
@end
