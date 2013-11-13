//
//  UIImage+ICEKit.h
//  iceios
//
//  Created by Andrew Smith on 2013-11-12.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief Collection of UIImage helpers
 *
 * @since 1.0.0
 */
@interface UIImage (ICEKit)

+ (UIImage *)imageNamed:(NSString *)name ofSize:(CGSize)size withBlock:(void (^)())drawingBlock;
+ (UIImage *)imageOfColor:(UIColor *)color;
- (UIImage *)tintedImageWithColor:(UIColor *)color;
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scaleToMaxWidth:(CGFloat)width andMaxHeight:(CGFloat)height;

@end
