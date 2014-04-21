//
//  UIImage+ICEFoundation.m
//  iceios
//
//  Created by Andrew Smith on 2013-11-12.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import "UIImage+ICEFoundation.h"

@implementation UIImage (ICEKit)

+ (UIImage *)imageNamed:(NSString *)name ofSize:(CGSize)size withBlock:(void (^)())drawingBlock
{
    NSParameterAssert(drawingBlock);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    drawingBlock();
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOfColor:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1,1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect fillRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, fillRect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color andAlpha:(CGFloat)alpha andSize:(CGSize)size
{
    UIImage *image = [UIImage imageNamed:name withColor:color andAlpha:alpha];
    image = [image scaleToSize:size];
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color andAlpha:(CGFloat)alpha
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image tintedImageWithColor:color];
    image = [image imageWithAlpha:alpha];
    return image;
}

- (UIImage *)tintedImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [color setFill];
    CGContextFillRect(context, rect);
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, self.CGImage);
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)imageWithAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)scaleToMaxWidth:(CGFloat)width andMaxHeight:(CGFloat)height
{
    CGFloat oldWidth = self.size.width;
    CGFloat oldHeight = self.size.height;
    
    // Only scale down
    if (oldWidth < width && oldHeight < height)
    {
        return self;
    }
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    return [self scaleToSize:newSize];
}

@end
