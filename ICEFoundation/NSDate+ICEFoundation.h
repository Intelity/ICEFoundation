//
//  NSDate+ICEFoundation.h
//  ICEFoundation
//
//  Created by Greg Pardo on 2013-07-30.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

- (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2;

- (NSString *)description;

- (NSInteger)minutesSince1970;

@end
