//
//  DMUIButton.m
//  DMUIButtonDemo
//
//  Created by DoubleMint on 2017/12/26.
//  Copyright © 2017年 王保霖. All rights reserved.
//



#import "DMUIButton.h"

@implementation DMUIButton


- (instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self didInitialized];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        [self didInitialized];
    }
    return self;
}


- (void)didInitialized{
    
    self.imagePosition = DMUIButtonImagePositionLeft;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(CGRectIsEmpty(self.bounds)){
        return;
    }
    BOOL isImageViewShowing = self.imageView && !self.imageView.hidden;
    BOOL isTitleLabelShowing = self.titleLabel && !self.titleLabel.hidden;
    CGSize imageLimitSize = CGSizeZero;
    CGSize titleLimitSize = CGSizeZero;
    CGSize imageTotalSize = CGSizeZero;// 包含 imageEdgeInsets 那些空间
    CGSize titleTotalSize = CGSizeZero;// 包含 titleEdgeInsets 那些空间
    CGRect imageFrame = CGRectZero;
    CGRect titleFrame = CGRectZero;
    CGFloat spacingBetweenImageAndTitle = isImageViewShowing && isTitleLabelShowing ? self.spacingBetweenImageAndTitle : 0;;// 如果图片或文字某一者没显示，则这个 spacing 不考虑进布局
    UIEdgeInsets contentEdgeInsets = self.contentEdgeInsets;
    //获取button真实的内容高度和宽度
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(contentEdgeInsets), CGRectGetHeight(self.bounds) - UIEdgeInsetsGetVerticalValue(contentEdgeInsets));

    if(isImageViewShowing){
        imageLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets)); //图片的最大Size
        CGSize imageSize = [self.imageView sizeThatFits:imageLimitSize];
        imageSize.width = fmin(imageSize.width, imageLimitSize.width);
        imageSize.height = fmin(imageSize.height,imageLimitSize.height);
        imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height); //计算Button中的图片真实的Size
        imageTotalSize = CGSizeMake(imageSize.width + UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), imageSize.height + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets)); //包括边距的图片的Size
    }
    
    if(self.imagePosition == DMUIButtonImagePositionTop || self.imagePosition == DMUIButtonImagePositionBottom){
        if(isTitleLabelShowing){
            titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.width = fmin(titleSize.width, titleLimitSize.width);
            titleSize.height = fmin(titleSize.height,titleLimitSize.height);
            titleFrame = CGRectMake(0, 0, titleSize.width, titleSize.height);
            titleTotalSize = CGSizeMake(titleSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), titleSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        }
        switch (self.contentHorizontalAlignment) {
                
            case UIControlContentHorizontalAlignmentLeft:
                imageFrame = isImageViewShowing ? CGRectMake(imageFrame.origin.x + self.imageEdgeInsets.left + self.contentEdgeInsets.right, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) :imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(titleFrame.origin.x + self.titleEdgeInsets.left + self.contentEdgeInsets.right, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;
                
            case UIControlContentHorizontalAlignmentRight:
                imageFrame = isImageViewShowing ? CGRectMake(contentSize.width - imageTotalSize.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) :imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(contentSize.width - titleTotalSize.width - self.imageEdgeInsets.right, titleFrame.origin.y- self.contentEdgeInsets.right, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;
                
            case UIControlContentHorizontalAlignmentCenter:
                imageFrame = isImageViewShowing ? CGRectMake(self.imageEdgeInsets.left + self.contentEdgeInsets.left + (imageLimitSize.width - imageFrame.size.width)/2, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) :imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(self.titleEdgeInsets.left + self.contentEdgeInsets.left + (titleLimitSize.width - titleFrame.size.width)/2, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;

            default:
                break;
        }
        
        
        if(self.imagePosition == DMUIButtonImagePositionTop){
         
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    imageFrame =  CGRectMake(imageFrame.origin.x, imageFrame.origin.y + self.imageEdgeInsets.top, imageFrame.size.width, imageFrame.size.height);
                    titleFrame = CGRectMake(titleFrame.origin.x, imageTotalSize.height + self.titleEdgeInsets.top + spacingBetweenImageAndTitle, titleFrame.size.width, titleFrame.size.height);
                    break;
                case UIControlContentVerticalAlignmentCenter:{
                    CGFloat contentHeight = imageTotalSize.height + spacingBetweenImageAndTitle + titleTotalSize.height;
                    CGFloat minY = (contentSize.height - contentHeight)/2 + contentEdgeInsets.top;
                    imageFrame =  CGRectMake(imageFrame.origin.x, minY + self.imageEdgeInsets.top, imageFrame.size.width, imageFrame.size.height);
                    titleFrame = CGRectMake(titleFrame.origin.x,minY+ self.titleEdgeInsets.top + spacingBetweenImageAndTitle + imageTotalSize.height, titleFrame.size.width, titleFrame.size.height);
                    break;
                }
                case UIControlContentVerticalAlignmentBottom:
                    titleFrame = CGRectMake(titleFrame.origin.x, contentSize.height - self.titleEdgeInsets.bottom - self.contentEdgeInsets.bottom - titleFrame.size.height, titleFrame.size.width, titleFrame.size.height);
                    imageFrame = CGRectMake(imageFrame.origin.x,titleFrame.origin.y - spacingBetweenImageAndTitle - imageFrame.size.height, imageFrame.size.width, imageFrame.size.height);
                    break;
                default:
                    break;
            }
            
        }else{
            
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    titleFrame = CGRectMake(titleFrame.origin.x, self.titleEdgeInsets.top + self.contentEdgeInsets.top,titleFrame.size.width, titleFrame.size.height);
                    imageFrame =  CGRectMake(imageFrame.origin.x,titleTotalSize.height + spacingBetweenImageAndTitle + self.imageEdgeInsets.top, imageFrame.size.width, imageFrame.size.height);
                    break;
                case UIControlContentVerticalAlignmentCenter:{
                    CGFloat contentHeight = imageTotalSize.height + spacingBetweenImageAndTitle + titleTotalSize.height;
                    CGFloat minY = (contentSize.height - contentHeight)/2 + contentEdgeInsets.top;
                    titleFrame = CGRectMake(titleFrame.origin.x , minY + self.titleEdgeInsets.top, titleFrame.size.width, titleFrame.size.height);
                    imageFrame =  CGRectMake(imageFrame.origin.x, minY + titleTotalSize.height + spacingBetweenImageAndTitle, imageFrame.size.width + self.imageEdgeInsets.top, imageFrame.size.height);
            
                    break;
                }
                case UIControlContentVerticalAlignmentBottom:
                    imageFrame = CGRectMake(imageFrame.origin.x,contentSize.height - self.imageEdgeInsets.bottom - self.contentEdgeInsets.bottom - imageFrame.size.height, imageFrame.size.width, imageFrame.size.height);
                    titleFrame = CGRectMake(titleFrame.origin.x,imageFrame.origin.y - spacingBetweenImageAndTitle - titleTotalSize.height, titleFrame.size.width, titleFrame.size.height);
                    break;
                default:
                    break;
            }
        }

    }else if(self.imagePosition == DMUIButtonImagePositionLeft || self.imagePosition == DMUIButtonImagePositionRight){
        
        if(isTitleLabelShowing){
            titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) - imageTotalSize.width - spacingBetweenImageAndTitle, contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.width = fmin(titleLimitSize.width, titleSize.width);
            titleSize.height = fmin(titleLimitSize.height, titleSize.height);
            titleFrame = CGRectMake(0, 0, titleSize.width, titleSize.height);
            titleTotalSize = CGSizeMake(titleSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), titleSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        }
        switch (self.contentVerticalAlignment) {
            case UIControlContentVerticalAlignmentTop:{
                imageFrame = isImageViewShowing? CGRectMake(imageFrame.origin.x,contentEdgeInsets.top + self.imageEdgeInsets.top, imageFrame.size.width,imageFrame.size.height):imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(titleFrame.origin.x, contentEdgeInsets.top+ self.titleEdgeInsets.top, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;}
            case UIControlContentVerticalAlignmentBottom:{
                imageFrame = isImageViewShowing? CGRectMake(imageFrame.origin.x,contentSize.height - imageFrame.size.height - self.imageEdgeInsets.bottom - self.contentEdgeInsets.bottom, imageFrame.size.width,imageFrame.size.height):imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(titleFrame.origin.x, contentSize.height - titleFrame.size.height - self.titleEdgeInsets.bottom - self.contentEdgeInsets.bottom, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;}
            case UIControlContentVerticalAlignmentCenter:{
                imageFrame = isImageViewShowing? CGRectMake(imageFrame.origin.x,(contentSize.height - imageFrame.size.height)/2 + self.imageEdgeInsets.top + self.contentEdgeInsets.top, imageFrame.size.width,imageFrame.size.height):imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectMake(titleFrame.origin.x, (contentSize.height - titleFrame.size.height)/2 + self.titleEdgeInsets.top + self.contentEdgeInsets.top, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                break;}
            case UIControlContentVerticalAlignmentFill:{
                if(isImageViewShowing){
                    imageFrame = CGRectMake(imageFrame.origin.x, contentEdgeInsets.top + self.imageEdgeInsets.top, imageFrame.size.width, contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
                }
                if(isTitleLabelShowing){
                    titleFrame = CGRectMake(titleFrame.origin.x, contentEdgeInsets.top + self.titleEdgeInsets.top, titleFrame.size.width, contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
                }
                break;}
            default:
                break;
        }
        //DMUIButtonImagePositionRight
        if(self.imagePosition == DMUIButtonImagePositionRight){
            switch (self.contentHorizontalAlignment) {
                case UIControlContentHorizontalAlignmentCenter:{
                    CGFloat contentWidh = imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width;
                    CGFloat minx = contentEdgeInsets.left + (contentSize.width - contentWidh)/2;
                    titleFrame = isTitleLabelShowing?CGRectMake(minx + self.titleEdgeInsets.left, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height):titleFrame;
                    imageFrame = isImageViewShowing? CGRectMake(minx + self.imageEdgeInsets.left + titleTotalSize.width + spacingBetweenImageAndTitle, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height):imageFrame;
                    break;}
                case UIControlContentHorizontalAlignmentRight:{
                    imageFrame = isImageViewShowing ? CGRectMake(self.bounds.size.width - imageFrame.size.width - self.imageEdgeInsets.right - self.contentEdgeInsets.right, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectMake(self.bounds.size.width - imageTotalSize.width - titleFrame.size.width - spacingBetweenImageAndTitle - self.contentEdgeInsets.right - self.titleEdgeInsets.right, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height):titleFrame;
                    break;}
                case UIControlContentHorizontalAlignmentLeft:{
                    if(imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width > contentSize.width){
                        imageFrame = CGRectMake(self.bounds.size.width - contentEdgeInsets.right - self.imageEdgeInsets.right - imageFrame.size.width, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height);
                        titleFrame = CGRectMake(self.bounds.size.width - contentEdgeInsets.right - imageTotalSize.width - spacingBetweenImageAndTitle -titleTotalSize.width + self.titleEdgeInsets.left, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height);
                    }else{
                        titleFrame = isTitleLabelShowing ? CGRectMake(contentEdgeInsets.left + self.titleEdgeInsets.left, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height) : titleFrame;
                        imageFrame = isImageViewShowing ? CGRectMake(contentEdgeInsets.left + titleTotalSize.width + spacingBetweenImageAndTitle + self.imageEdgeInsets.left, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) : imageFrame;
                    }
                    break;}
                case UIControlContentHorizontalAlignmentFill:{
                    // 如果 图片和文字都存在的话  图片先占满  文字占满其他的位置
                    if(isTitleLabelShowing && isImageViewShowing){
                        imageFrame = CGRectMake(self.bounds.size.width - imageFrame.size.width - self.imageEdgeInsets.right - contentEdgeInsets.right,imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height);
                        titleFrame = CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left , titleFrame.origin.y, imageFrame.origin.x - spacingBetweenImageAndTitle  - self.titleEdgeInsets.right - self.imageEdgeInsets.left,titleFrame.size.height);
                        
                    }else if(isImageViewShowing){ //只有图片 占满控件
                        imageFrame = CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, imageFrame.origin.y, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), imageFrame.size.height);
                    }else if(isTitleLabelShowing){ //只有标题 占满控件
                        titleFrame = CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, imageFrame.origin.y, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) , imageFrame.size.height);
                    }
               
                    break;
                }
                default:
                    break;
            }
        }else{
            //DMUIButtonImagePositionLeft
            switch (self.contentHorizontalAlignment) {
                case UIControlContentHorizontalAlignmentCenter:{
                    CGFloat contentWidh = imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width;
                    CGFloat minx = contentEdgeInsets.left + (contentSize.width - contentWidh)/2;
                    imageFrame = isImageViewShowing? CGRectMake(minx + self.imageEdgeInsets.left, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height):imageFrame;
                    titleFrame = isTitleLabelShowing? CGRectMake(imageFrame.origin.x +  imageFrame.size.width + self.imageEdgeInsets.right + self.titleEdgeInsets.left + spacingBetweenImageAndTitle, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height):titleFrame;
                    break;}
                case UIControlContentHorizontalAlignmentRight:{
                    
                    if(imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width > contentSize.width){
                        imageFrame = isImageViewShowing? CGRectMake(contentEdgeInsets.left + self.imageEdgeInsets.left, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height) :imageFrame;
                        titleFrame = isTitleLabelShowing ? CGRectMake(imageFrame.origin.x + spacingBetweenImageAndTitle + self.titleEdgeInsets.left + imageFrame.size.width + self.imageEdgeInsets.right, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height) :titleFrame;
                    }else{
                        
                        titleFrame = isTitleLabelShowing? CGRectMake(contentSize.width - self.titleEdgeInsets.right - contentEdgeInsets.right - titleFrame.size.width, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height):titleFrame;
                        imageFrame = isImageViewShowing? CGRectMake(titleFrame.origin.x - spacingBetweenImageAndTitle - self.imageEdgeInsets.right - imageFrame.size.width, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height):imageFrame;
                    }
                    
                    break;}
                case UIControlContentHorizontalAlignmentLeft:{
                    imageFrame = CGRectMake(contentEdgeInsets.left + self.imageEdgeInsets.left, imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height);
                    titleFrame = CGRectMake(imageFrame.origin.x + imageFrame.size.width + spacingBetweenImageAndTitle + self.titleEdgeInsets.left, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height);
                    break;}
                case UIControlContentHorizontalAlignmentFill:{
                    // 如果 图片和文字都存在的话  图片先占满  文字占满其他的位置
                    if(isTitleLabelShowing && isImageViewShowing){
                        imageFrame = CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left,imageFrame.origin.y, imageFrame.size.width, imageFrame.size.height);
                        titleFrame = CGRectMake(imageFrame.origin.x + imageFrame.size.width + self.imageEdgeInsets.right + self.titleEdgeInsets.left + spacingBetweenImageAndTitle, titleFrame.origin.y,self.bounds.size.width - imageFrame.origin.x - imageFrame.size.width - self.imageEdgeInsets.right - self.titleEdgeInsets.left - spacingBetweenImageAndTitle,titleFrame.size.height);
                    }else if(isImageViewShowing){ //只有图片 占满控件
                        imageFrame = CGRectMake(self.contentEdgeInsets.left + self.imageEdgeInsets.left, imageFrame.origin.y, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), imageFrame.size.height);
                    }else if(isTitleLabelShowing){ //只有标题 占满控件
                        titleFrame = CGRectMake(self.contentEdgeInsets.left + self.titleEdgeInsets.left, imageFrame.origin.y, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) , imageFrame.size.height);
                    }
                    break;
                }
                default:
                    break;
            }
        }
        
    }
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
}

- (void)setImagePosition:(DMUIButtonImagePosition)imagePosition{
    _imagePosition = imagePosition;
    [self setNeedsLayout];
}

- (void)setSpacingBetweenImageAndTitle:(CGFloat)spacingBetweenImageAndTitle{
    _spacingBetweenImageAndTitle = spacingBetweenImageAndTitle;
    [self setNeedsLayout];
}

@end


























