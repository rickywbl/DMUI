//
//  UIColor+DMUI.h
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2018/1/31.
//  Copyright © 2018年 王保霖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DMUI)

/**
 使用十六进制颜色创建UICololr

 @param hexString 十六进制颜色代码
 @return UIColor
 */
+ (UIColor *)dm_colorWithHexString: (NSString *) hexString;
@end
