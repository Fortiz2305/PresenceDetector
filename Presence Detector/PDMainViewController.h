//
//  PDMainViewController.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 27/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import <SystemConfiguration/CaptiveNetwork.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "PDSettingsViewController.h"
#import "PDRecordTableViewController.h"
#import "PDAvailabilityNetwork.h"
#import "PDItemsTable.h"
#import "PDMailComposeViewController.h"

NSMutableString *mySSIDString, *alertMessageString, *emailRecipientString;
NSMutableArray *arrayResults;
NSString *startHour;
float scanFrequency, minIntervalForChange;
PDAvailabilityNetwork *internetAvailability;

@interface PDMainViewController : UIViewController{

}

@property (nonatomic, weak) NSString *targetSSID;
@property (nonatomic, weak) PDAvailabilityNetwork *wifiAvailability;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic) float ssidResul, targetWifiTime, totalTime, flag, flagStatus, control3G, controlTW, controlNTW;
@property (nonatomic, weak) IBOutlet UILabel *currentssid;
@property (nonatomic, weak) IBOutlet UILabel *startTime, *currentHour;
@property (nonatomic, weak) IBOutlet UILabel *finalResult;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

/*
 * Return Current Wifi SSID.
 */
-(NSString*)currentSSID;

/*
 * Start monitorize Presence in Target Wifi.
 */
-(IBAction)startMonitorize:(id)sender;

/*
 * Stop monitorize Presence in Target Wifi.
 */
-(IBAction)stopMonitorize:(id)sender;

/*
 * Start NSTimer for count time in Target Wifi
 */
-(void)start:(NSTimer*)timer;

/*
 * Reset NSTimer
 */
-(IBAction)resetTargetWifiTime:(id)sender;

/*
 * Configure User Interface
 */
-(void)configureInterfaceWithAvailability:(PDAvailabilityNetwork*)availability;

/*
 * Show message if Settings are incompleted.
 */
-(void)showAlertMessage1;

/*
 * Show message if Target Wifi Connect or Disconnect
 */
-(void)localNotification;

/*
 * Return current time
 */
-(NSString*)getHour;

@end
