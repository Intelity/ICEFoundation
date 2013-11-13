//
//  NSDate+Additions.h
//  iceios
//
//  Created by Greg Pardo on 7/30/13.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

- (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2;

- (NSString *)description;

- (NSInteger)minutesSince1970;

@end
