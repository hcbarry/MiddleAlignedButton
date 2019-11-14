//
//  UIButton+MiddleAligning.m
//  UIButton+MiddleAligning
//
//  Created by Barry on 12/11/15.
//  Copyright © 2015 BarryLee. All rights reserved.
//

#import "UIButton+MiddleAligning.h"

@interface UIImage (MiddleAligning)

@end

@implementation UIImage (MiddleAligning)

- (UIImage *)MiddleAlignedButtonImageScaleToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end

@implementation UIButton (MiddleAligning)

- (void)middleAlignButtonWithSpacing:(CGFloat)spacing {
    UIUserInterfaceLayoutDirection direction = [UIApplication sharedApplication].userInterfaceLayoutDirection;
    if ([self respondsToSelector:@selector(effectiveUserInterfaceLayoutDirection)]) {
        direction = self.effectiveUserInterfaceLayoutDirection;
    }
    [self middleAlignButtonWithSpacing:spacing direction:direction];
}

- (void)middleAlignButtonWithSpacing:(CGFloat)spacing direction:(UIUserInterfaceLayoutDirection)direction {
    UIControlState state = UIControlStateNormal;
    
    NSString *titleString = [self titleForState:state]? : @"";
    NSDictionary *attributes = @{NSFontAttributeName : self.titleLabel.font};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:titleString attributes:attributes];
    CGSize titleSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                      context:nil].size;
    
    CGSize imageSize = [self imageForState:state].size;
    
    CGFloat maxImageHeight = CGRectGetHeight(self.frame) - titleSize.height - spacing * 2;
    CGFloat maxImageWidth = CGRectGetWidth(self.frame);
    
    UIImage *image = self.imageView.image;
    
    UIImage *newImage = nil;
    
    if (imageSize.width > ceilf(maxImageWidth)) {
        CGFloat ratio = maxImageWidth / imageSize.width;
        newImage = [image MiddleAlignedButtonImageScaleToSize:CGSizeMake(maxImageWidth, imageSize.height * ratio)];
        imageSize = newImage.size;
    }
    if (imageSize.height > ceilf(maxImageHeight)) {
        CGFloat ratio = maxImageHeight / imageSize.height;
        newImage = [image MiddleAlignedButtonImageScaleToSize:CGSizeMake(imageSize.width * ratio, maxImageHeight)];
        imageSize = newImage.size;
    }
    if (newImage != nil) {
        if ([newImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            newImage = [newImage imageWithRenderingMode:image.renderingMode];
        }
        [self setImage:newImage forState:state];
    }
    
    CGFloat imageVerticalDiff = titleSize.height + spacing;
    CGFloat imageHorizontalDiff = titleSize.width;
    
    CGFloat titleVerticalDiff = imageSize.height + spacing;
    CGFloat titleHorizontalDiff = imageSize.width;
    
    UIEdgeInsets imageEdgeInsets, titleEdgeInsets;
    
    switch (direction) {
        case UIUserInterfaceLayoutDirectionLeftToRight:
            imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalDiff, 0, 0, -imageHorizontalDiff);
            titleEdgeInsets = UIEdgeInsetsMake(0, -titleHorizontalDiff, -titleVerticalDiff, 0);
            break;
        case UIUserInterfaceLayoutDirectionRightToLeft:
            imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalDiff, -imageHorizontalDiff, 0, 0);
            titleEdgeInsets = UIEdgeInsetsMake(0, 0, -titleVerticalDiff, -titleHorizontalDiff);
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

@end
