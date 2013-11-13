//
//  NSString+Additions.m
//  iceios
//
//  Created by Greg Pardo on 6/19/13.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

-(NSString *) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
