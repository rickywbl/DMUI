//
//  DMUIButton.h
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2017/12/26.
//  Copyright © 2017年 王保霖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger ,DMUIButtonImagePosition){
    DMUIButtonImagePositionTop,
    DMUIButtonImagePositionBottom,
    DMUIButtonImagePositionLeft,
    DMUIButtonImagePositionRight,
    
};


CG_INLINE CGFloat
removeFloatMin(CGFloat floatValue) {
    return floatValue == CGFLOAT_MIN ? 0 : floatValue;
}

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}


CG_INLINE UIEdgeInsets
UIEdgeInsetsRemoveFloatMin(UIEdgeInsets insets) {
    UIEdgeInsets result = UIEdgeInsetsMake(removeFloatMin(insets.top), removeFloatMin(insets.left), removeFloatMin(insets.bottom), removeFloatMin(insets.right));
    return result;
}


IB_DESIGNABLE

@interface DMUIButton : UIButton

@property(nonatomic,assign) IBInspectable  DMUIButtonImagePosition imagePosition; //图片的位置
@property(nonatomic,assign) IBInspectable CGFloat spacingBetweenImageAndTitle;  //图片和文字的间距

@end
