//
//  MiddleAlignedButton.m
//  MiddleAlignedButton
//
//  Created by Barry on 12/11/15.
//  Copyright © 2015 BarryLee. All rights reserved.
//

#import "MiddleAlignedButton.h"

@interface UIImage (MiddleAlignedButton)

@end

@implementation UIImage (MiddleAlignedButton)

- (UIImage *)MiddleAlignedButtonImageViewScaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;
}

@end

@implementation MiddleAlignedButton

- (void)setMiddleSpace:(CGFloat)middleSpace
{
    _middleSpace = middleSpace;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize titleSize = self.titleLabel.frame.size;
    CGSize imageSize = self.imageView.image.size;
    CGFloat height = CGRectGetHeight(self.frame) - titleSize.height - self.middleSpace * 2;
    CGFloat width = CGRectGetWidth(self.frame) - titleSize.width;
    UIImage *newImage = nil;
    if (imageSize.width > ceilf(width)) {
        CGFloat ratio = width / imageSize.width;
        newImage = [self.imageView.image MiddleAlignedButtonImageViewScaleToSize:CGSizeMake(width, imageSize.height * ratio)];
        imageSize = newImage.size;
    }
    if (imageSize.height > ceilf(height)) {
        CGFloat ratio = height / imageSize.height;
        newImage = [self.imageView.image MiddleAlignedButtonImageViewScaleToSize:CGSizeMake(imageSize.width * ratio, height)];
        imageSize = newImage.size;
    }
    if (newImage) {
        if ([newImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            newImage = [newImage imageWithRenderingMode:self.imageView.image.renderingMode];
        }
        [self setImage:newImage forState:UIControlStateNormal];
    }

    CGFloat imageVerticalDiff = imageSize.height / 2.0f;
    if (imageVerticalDiff > (titleSize.height / 2.0f)) {
        imageVerticalDiff = (titleSize.height / 2.0f);
    }
    imageVerticalDiff += self.middleSpace;
    CGFloat imageHorizontalDiff = titleSize.width / 2.0f;

    self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalDiff, imageHorizontalDiff, imageVerticalDiff, -imageHorizontalDiff);

    CGFloat titleVerticalDiff = imageSize.height / 2.0f + self.middleSpace;
    CGFloat titleHorizontalDiff = imageSize.width / 2.0f;

    self.titleEdgeInsets = UIEdgeInsetsMake(titleVerticalDiff, -titleHorizontalDiff, -titleVerticalDiff, titleHorizontalDiff);
}

@end
