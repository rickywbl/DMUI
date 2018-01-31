//
//  UIView+DMUI.h
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2018/1/31.
//  Copyright © 2018年 王保霖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DMUI)


/**
 使用size初始化UiVeiw

 @param size View的大小
 @return UIView对象
 */
- (instancetype)dm_initWithSize:(CGSize )size;

/**
 单独设置View.frame.origin.x
 @param x x坐标
 */
- (void)dm_setFrameX:(CGFloat)x;

/**
 单独设置View.frame.origin.y
 @param y y坐标
 */
- (void)dm_setFrameY:(CGFloat)y;

/**
 单独设置View.frame.size.width
 @param width View的宽度
 */
- (void)dm_setFrameWidth:(CGFloat)width;

/**
 单独设置View.frame.size.height
 @param height View的高度
 */
- (void)dm_setFrameHeight:(CGFloat)height;

/**
 单独设置View.frame.size
 @param size View的大小
 */
- (void)dm_setFrameSize:(CGSize)size;

@end
