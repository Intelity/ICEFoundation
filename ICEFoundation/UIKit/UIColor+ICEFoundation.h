//
//  UIColor+ICEFoundation.h
//  iceios
//
//  Created by Andrew Smith on 2013-11-12.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief A collection of UIColor helpers
 *
 * @since 1.0.0
 */
@interface UIColor (ICEFoundation)

/*!
 * @brief Darkens the reciever
 *
 * @since 1.0.0
 */
- (UIColor *)darkenColorByPercentOfOriginal:(CGFloat)amount;

/*!
 * @brief Lightens the reciever
 *
 * @since 1.0.0
 */
- (UIColor *)lightenColorByPercentage:(CGFloat)amount;

/*!
 * @brief Creates a UIColor from Android & CSS style hexadecimals.
 *
 * Works for #RGB, #RRGGBB, #ARGB, #AARRGGBB
 *
 * @since 1.0.0
 */
+ (UIColor *)ice_colorWithHex:(NSString *)hexString;

/*!
 * @brief Creates a UIColor with HSL values
 *
 * @since 1.0.0
 */
+ (UIColor *)ice_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

/*!
 * @brief Gets the reciever's HSL components
 *
 * @since 1.0.0
 */
- (BOOL)ice_getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha;

@end

/*!
 * Mixes two colors. Accounts for alpha.
 * @param weight should be between 0 and 1.
 * @since 1.0.1
 */
UIColor* ICEColorMixColorsWeighted(UIColor *color1, UIColor *color2, CGFloat weight);
