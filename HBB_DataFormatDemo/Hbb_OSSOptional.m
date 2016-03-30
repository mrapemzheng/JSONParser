//
//  Hbb_OSSOptional.m
//  OSSDemo
//
//  Created by CHENG DE LUO on 15/12/8.
//  Copyright © 2015年 mige. All rights reserved.
//

#import "Hbb_OSSOptional.h"
#import <objc/runtime.h>

@implementation Hbb_OSSOptional

OSSRect OSSRectMake(NSUInteger x, NSUInteger y, NSUInteger width, NSUInteger height)
{
    OSSRect rect;
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
}

OSSSize OSSSizeMake(NSUInteger width, NSUInteger height)
{
    OSSSize size;
    size.width = width;
    size.height = height;
    return size;
}


#pragma mark - getter Method
- (NSUInteger)scalePercent
{
    if (_scalePercent > 1000) {
        _scalePercent = 1000;
    }
    return _scalePercent;
}

- (NSUInteger)rotationAngle
{
    if (_rotationAngle > 360) {
        _rotationAngle = 360;
    }
    return _rotationAngle;
}

- (NSUInteger)sharpen
{
    if (_sharpen > 399) {
        _sharpen = 399;
    }else if (_sharpen < 50 && _sharpen > 0){
        _sharpen = 50;
    }
    return _sharpen;
}

- (NSInteger)brightness
{
    if (_brightness < -100) {
        _brightness = -100;
    }else if (_brightness > 100){
        _brightness = 100;
    }
    return _brightness;
}

- (NSInteger)contrast
{
    if (_contrast < -100) {
        _contrast = -100;
    }else if (_contrast > 100){
        _contrast = 100;
    }
    return _contrast;
}

- (NSUInteger)relativeQuality
{
    if (_relativeQuality > 100) {
        _relativeQuality = 100;
    }
    return _relativeQuality;
}

- (NSUInteger)absoluteQuality
{
    if (_absoluteQuality > 100) {
        _absoluteQuality = 100;
    }
    return _absoluteQuality;
}

@end
