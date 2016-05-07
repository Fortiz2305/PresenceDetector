//
//  PDAvailabilityNetwork.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 22/01/14.
//  Copyright (c) 2014 Francisco Ortiz Abril. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>


typedef enum : NSInteger {
	Use3G = 0,
	UseWiFi
} NetworkStatus;

@interface PDAvailabilityNetwork : NSObject{
    
}

@property (nonatomic) BOOL ReturnLocalWiFiStatus; //default is NO
@property (nonatomic) SCNetworkReachabilityRef reachabilityRef;

/*!
 * Use to check the reachability of a given IP address.
 */
+ (PDAvailabilityNetwork*)availabilityWithAddress:(const struct sockaddr_in *)hostAddress;

/*!
 * Checks internet connection is available in the default route.
 */
+ (PDAvailabilityNetwork*)availabilityForInternetConnection;

/*!
 * Check current NetworkStatus.
 */
- (NetworkStatus)currentAvailabilityStatus;

/*!
 * Return flags with current Status
 */
 
- (NetworkStatus)localWiFiStatusForFlags:(SCNetworkReachabilityFlags)flags;

- (NetworkStatus)networkStatusForFlags:(SCNetworkReachabilityFlags)flags;




@end


