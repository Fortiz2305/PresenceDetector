//
//  PDRecordTableViewController.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 27/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PDSettingsViewController.h"
#import "PDAvailabilityNetwork.h"
#import "PDMainViewController.h"


@interface PDRecordTableViewController : UITableViewController{
    
}

/*
 * Come back to TFGMainViewController
 */
-(IBAction)volver:(id)sender;

/*!
 * Reset Network Changes Record
 */
-(IBAction)resetRecord:(id)sender;

@end

