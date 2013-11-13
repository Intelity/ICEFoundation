//
//  NSString+ICEFoundation.m
//  ICEFoundation
//
//  Created by Greg Pardo on 2013-06-19.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import "NSString+ICEFoundation.h"

@implementation NSString (ICEFoundation)

- (NSString *)stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
