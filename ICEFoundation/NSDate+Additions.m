//
//  NSDate+Additions.m
//  iceios
//
//  Created by Greg Pardo on 7/30/13.
//  Copyright (c) 2013 Intelity. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

- (BOOL)isBetweenDate:(NSDate *)date1
              andDate:(NSDate *)date2 {
    
    // We don't want precision to seconds here. It seems to cause problems so we just use minutes.
    NSInteger baseTimeMinutes = [self minutesSince1970];
    NSInteger date1IntervalMinutes = [date1 minutesSince1970];
    NSInteger date2IntervalMinutes = [date2 minutesSince1970];
    
    return (baseTimeMinutes >= date1IntervalMinutes &&
            baseTimeMinutes <= date2IntervalMinutes);
}

- (NSString *)description
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterFullStyle;
    formatter.timeStyle = NSDateFormatterFullStyle;
    formatter.timeZone = [NSTimeZone defaultTimeZone];
    NSString *defaultTimeZone = [formatter stringFromDate:self];
    formatter.timeZone= [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSString *utcTimeZone = [formatter stringFromDate:self];
    return [NSString stringWithFormat:@"Default Time Zone: %@\nUTC Time Zone    : %@", defaultTimeZone, utcTimeZone];
}

- (NSInteger)minutesSince1970
{
    return (NSInteger)floor([self timeIntervalSince1970] / 60.0);
}

@end
