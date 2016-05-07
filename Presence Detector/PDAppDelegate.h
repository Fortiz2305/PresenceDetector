//
//  PDAppDelegate.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 22/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PDMainViewController.h"

@interface PDAppDelegate : UIResponder <UIApplicationDelegate>{
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow *window;

@end
