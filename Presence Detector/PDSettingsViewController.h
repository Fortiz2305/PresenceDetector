//
//  PDSettingsViewController.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 27/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDAvailabilityNetwork.h"
#import "PDMainViewController.h"
#import "PDRecordTableViewController.h"

int flagSetting;

@interface PDSettingsViewController : UIViewController{
    
}

@property (nonatomic, weak) IBOutlet UITextField *mySSID;
@property (nonatomic, weak) IBOutlet UITextField *ssidScanFrequency;
@property (nonatomic, weak) IBOutlet UITextField *minInterval;
@property (nonatomic, weak) IBOutlet UITextField *alertMessage;
@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UIScrollView *scroollView;

/*!
 * Come back to TFGMainViewController
 */
-(IBAction)volver:(id)sender;

/*!
 * Apply settings to monitorize.
 */
-(IBAction)applySettings:(id)sender;

/*!
 * Close keyboards
 */
-(IBAction)closeKeyboardmySSID:(id)sender;
-(IBAction)closeKeyboardFreq:(id)sender;
-(IBAction)closeKeyboardAlarm:(id)sender;
-(IBAction)closeKeyboardMinInterval:(id)sender;


@end
