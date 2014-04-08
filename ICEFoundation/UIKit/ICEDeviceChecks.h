//
//  ICEDeviceChecks.h
//  ICEFoundation
//
//  Created by Andrew Smith on 2014-04-08.
//  Copyright (c) 2014 Intelity. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Compares strings to the current device’s version of iOS, ie. @"7.0"
 *
 * @since 0.0.4
 */
// http://stackoverflow.com/questions/7848766/how-can-we-programmatically-detect-which-ios-version-is-device-running-on
#define ice_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define ice_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define ice_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ice_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define ice_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/**
 * Checks if the device is an iPad
 * @since 0.0.4
 */
#define ice_USER_INTERFACE_IS_PAD   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

/**
 * Checks if the device is an iPhone or iPod
 * @since 0.0.4
 */
#define ice_USER_INTERFACE_IS_PHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)