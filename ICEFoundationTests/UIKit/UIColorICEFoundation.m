//
//  UIColorICEFoundation.m
//  ICEFoundation
//
//  Created by Andrew Smith on 2013-11-12.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+ICEFoundation.h"

@interface UIColorICEFoundation : XCTestCase

@end

@implementation UIColorICEFoundation

- (void)testColorWithHexAbbreviated
{
    UIColor *color;
    color = [UIColor ice_colorWithHex:@"#FFF"];
    XCTAssertEqualObjects(color, [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f], @"White color does not match");

    color = [UIColor ice_colorWithHex:@"#000"];
    XCTAssertEqualObjects(color, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f], @"Black color does not match");
}

- (void)testColorWithHexAbbreviatedAndAlpha
{
    UIColor *color;
    color = [UIColor ice_colorWithHex:@"#3000"];
    XCTAssertEqualObjects(color, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f], @"Alpha color mismatch");
}

- (void)testColorWithHex
{
    UIColor *color, *expectedColor;
    color = [UIColor ice_colorWithHex:@"#FF0066"];
    expectedColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.4f alpha:1.0f];
    XCTAssertEqualObjects(color, expectedColor, @"Color mismatch");
}

- (void)testColorWithHexAndAlpha
{
    UIColor *color, *expectedColor;
    color = [UIColor ice_colorWithHex:@"#996633FF"];
    expectedColor = [UIColor colorWithRed:0.4f green:0.2f blue:1.0f alpha:0.6f];
    XCTAssertEqualObjects(color, expectedColor, @"Color mismatch");
}

- (void)testColorWithHexWhenNil
{
    XCTAssertNil([UIColor ice_colorWithHex:nil], @"nil when sent nil");
    XCTAssertNil([UIColor ice_colorWithHex:@""], @"nil when sent empty string");
}

@end
