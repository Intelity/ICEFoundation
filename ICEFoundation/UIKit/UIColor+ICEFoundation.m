//
//  UIColor+ICEFoundation.m
//  iceios
//
//  Created by Andrew Smith on 2013-11-12.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import "UIColor+ICEFoundation.h"

static void HSL2RGB(CGFloat h, CGFloat s, CGFloat l, CGFloat* outR, CGFloat* outG, CGFloat* outB);
static void RGB2HSL(CGFloat r, CGFloat g, CGFloat b, CGFloat* outH, CGFloat* outS, CGFloat* outL);

@implementation UIColor (ICEFoundation)

- (UIColor *)darkenColorByPercentOfOriginal:(CGFloat)amount
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    if (model != kCGColorSpaceModelRGB)
    {
        return self;
    }
    CGFloat hue, saturation, lightness, alpha;
    [self ice_getHue:&hue saturation:&saturation lightness:&lightness alpha:&alpha];
    lightness = MAX(lightness - fabsf(amount), 0.0f);
    return [UIColor ice_colorWithHue:hue saturation:saturation lightness:lightness alpha:alpha];
}

- (UIColor *)lightenColorByPercentage:(CGFloat)amount
{
    CGColorSpaceModel model = CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    if (model != kCGColorSpaceModelRGB)
    {
        return self;
    }
    CGFloat hue, saturation, lightness, alpha;
    [self ice_getHue:&hue saturation:&saturation lightness:&lightness alpha:&alpha];
    lightness = MIN(lightness + fabsf(amount), 1.0f);
    return [UIColor ice_colorWithHue:hue saturation:saturation lightness:lightness alpha:alpha];
}

CGFloat ICEGetColorComponentFrom(NSString *string, NSInteger start, NSInteger length);
CGFloat ICEGetColorComponentFrom(NSString *string, NSInteger start, NSInteger length)
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0f;
}

+ (UIColor *)ice_colorWithHex:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = ICEGetColorComponentFrom(colorString, 0, 1);
            green = ICEGetColorComponentFrom(colorString, 1, 1);
            blue  = ICEGetColorComponentFrom(colorString, 2, 1);
            break;
        case 4: // #ARGB
            alpha = ICEGetColorComponentFrom(colorString, 0, 1);
            red   = ICEGetColorComponentFrom(colorString, 1, 1);
            green = ICEGetColorComponentFrom(colorString, 2, 1);
            blue  = ICEGetColorComponentFrom(colorString, 3, 1);
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = ICEGetColorComponentFrom(colorString, 0, 2);
            green = ICEGetColorComponentFrom(colorString, 2, 2);
            blue  = ICEGetColorComponentFrom(colorString, 4, 2);
            break;
        case 8: // #AARRGGBB
            alpha = ICEGetColorComponentFrom(colorString, 0, 2);
            red   = ICEGetColorComponentFrom(colorString, 2, 2);
            green = ICEGetColorComponentFrom(colorString, 4, 2);
            blue  = ICEGetColorComponentFrom(colorString, 6, 2);
            break;
        case 0:
            return nil;
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (UIColor *)ice_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    CGFloat red, green, blue;
    HSL2RGB(hue, saturation, lightness, &red, &green, &blue);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (BOOL)ice_getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha
{
    CGFloat red, green, blue;
    BOOL returnValue = [self getRed:&red green:&green blue:&blue alpha:alpha];
    RGB2HSL(red, green, blue, hue, saturation, lightness);
    return returnValue;
}

@end

// Modified from https://github.com/alessani/ColorConverter
static void HSL2RGB(CGFloat h, CGFloat s, CGFloat l, CGFloat* outR, CGFloat* outG, CGFloat* outB)
{
	CGFloat     temp1, temp2;
	CGFloat     temp[3];
	NSInteger   i;

	// Check for saturation. If there isn't any just return the luminance value
    // for each, which results in gray.
	if(s == 0.0f)
    {
		if(outR)
			*outR = l;
		if(outG)
			*outG = l;
		if(outB)
			*outB = l;
		return;
	}

	// Test for luminance and compute temporary values based on
    // luminance and saturation
	if(l < 0.5)
		temp2 = l * (1.0f + s);
	else
		temp2 = l + s - l * s;
    temp1 = 2.0f * l - temp2;

	// Compute intermediate values based on hue
	temp[0] = h + 1.0f / 3.0f;
	temp[1] = h;
	temp[2] = h - 1.0f / 3.0f;

	for(i = 0; i < 3; ++i)
    {
		// Adjust the range
		if(temp[i] < 0.0)
			temp[i] += 1.0;
		if(temp[i] > 1.0)
			temp[i] -= 1.0;


		if(6.0 * temp[i] < 1.0)
			temp[i] = temp1 + (temp2 - temp1) * 6.0f * temp[i];
		else {
			if(2.0 * temp[i] < 1.0)
				temp[i] = temp2;
			else {
				if(3.0 * temp[i] < 2.0)
					temp[i] = temp1 + (temp2 - temp1) * ((2.0f / 3.0f) - temp[i]) * 6.0f;
				else
					temp[i] = temp1;
			}
		}
	}

	// Assign temporary values to R, G, B
	if(outR)
		*outR = temp[0];
	if(outG)
		*outG = temp[1];
	if(outB)
		*outB = temp[2];
}

// https://github.com/alessani/ColorConverter
static void RGB2HSL(CGFloat r, CGFloat g, CGFloat b, CGFloat* outH, CGFloat* outS, CGFloat* outL)
{
    CGFloat h,s, l, v, m, vm, r2, g2, b2;

    h = 0;
    s = 0;
    l = 0;

    v = MAX(r, g);
    v = MAX(v, b);
    m = MIN(r, g);
    m = MIN(m, b);

    l = (m+v)/2.0f;

    if (l <= 0.0)
    {
        if(outH)
			*outH = h;
		if(outS)
			*outS = s;
		if(outL)
			*outL = l;
        return;
    }

    vm = v - m;
    s = vm;

    if (s > 0.0f){
        s/= (l <= 0.5f) ? (v + m) : (2.0 - v - m);
    }else{
        if(outH)
			*outH = h;
		if(outS)
			*outS = s;
		if(outL)
			*outL = l;
        return;
    }

    r2 = (v - r)/vm;
    g2 = (v - g)/vm;
    b2 = (v - b)/vm;

    if (r == v){
        h = (g == m ? 5.0f + b2 : 1.0f - g2);
    }else if (g == v){
        h = (b == m ? 1.0f + r2 : 3.0f - b2);
    }else{
        h = (r == m ? 3.0f + g2 : 5.0f - r2);
    }

    h/=6.0f;

    if(outH)
        *outH = h;
    if(outS)
        *outS = s;
    if(outL)
        *outL = l;
}

// Only works with colors in the RGBA colorspace
// Stolen from Sass's ruby implementation
UIColor* ICEColorMixColorsWeighted(UIColor *color1, UIColor *color2, CGFloat weight)
{
    CGFloat p = MAX(MIN(weight, 100.f), 0.f); // clamp to 0..1
    CGFloat w = (p * 2) - 1;

    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat a = a1 - a2;

    CGFloat w1 = (((w * a == -1) ? w : (w + a)/(1 + w*a)) + 1)/2.0;
    CGFloat w2 = 1 - w1;

    CGFloat red, blue, green, alpha;
    red = r1*w1 + r2*w2;
    green = g1*w1 + g2*w2;
    blue = b1*w1 + b2*w2;
    alpha = a1*p + a2*(1-p);

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
