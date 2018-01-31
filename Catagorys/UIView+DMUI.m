//
//  UIView+DMUI.m
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2018/1/31.
//  Copyright © 2018年 王保霖. All rights reserved.
//

#import "UIView+DMUI.h"

@implementation UIView (DMUI)

- (instancetype)dm_initWithSize:(CGSize )size{
    
    return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (void)dm_setFrameX:(CGFloat)x{
    
    CGRect rect = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)dm_setFrameY:(CGFloat)y{
    
    CGRect rect = CGRectMake(self.frame.origin.x,y, self.frame.size.width, self.frame.size.height);
    self.frame = rect;
}

- (void)dm_setFrameWidth:(CGFloat)width{
    
    CGRect rect = CGRectMake(self.frame.origin.x,self.frame.origin.y, width, self.frame.size.height);
    self.frame = rect;
}

- (void)dm_setFrameHeight:(CGFloat)height{
    CGRect rect = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.width,height);
    self.frame = rect;
}

- (void)dm_setFrameSize:(CGSize)size{
    CGRect rect = CGRectMake(self.frame.origin.x,self.frame.origin.y,size.width,size.height);
    self.frame = rect;
}


@end
