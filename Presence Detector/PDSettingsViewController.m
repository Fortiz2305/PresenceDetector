//
//  PDSettingsViewController.m
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 27/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//


#import "PDSettingsViewController.h"

@interface PDSettingsViewController ()

@end

@implementation PDSettingsViewController

@synthesize mySSID;
@synthesize ssidScanFrequency;
@synthesize alertMessage;
@synthesize minInterval;
@synthesize email;
@synthesize scroollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [scroollView setScrollEnabled:YES];
    [scroollView setContentSize:CGSizeMake(320, 1049)];
    
    if (flagSetting == 0) {
        alertMessage.text = @"Change in Situation";
        ssidScanFrequency.text = @"15";
        minInterval.text = @"20";
    }else{
     mySSID.text = mySSIDString;
     alertMessage.text = alertMessageString;
     ssidScanFrequency.text = [NSString stringWithFormat:@"%.1f", scanFrequency];
     minInterval.text = [NSString stringWithFormat:@"%.1f", minIntervalForChange];
     email.text = emailRecipientString;
    }
}

-(IBAction)applySettings:(id)sender
{
    flagSetting = 1;
    mySSIDString = [NSMutableString stringWithString:mySSID.text];
    scanFrequency = [ssidScanFrequency.text floatValue];
    alertMessageString = [NSMutableString stringWithString:alertMessage.text];
    minIntervalForChange = [minInterval.text floatValue];
    emailRecipientString = [NSMutableString stringWithString:email.text];
}

-(IBAction)volver:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)closeKeyboardmySSID:(id)sender
{
    [mySSID resignFirstResponder];
}

-(IBAction)closeKeyboardAlarm:(id)sender
{
    [alertMessage resignFirstResponder];
}

-(IBAction)closeKeyboardFreq:(id)sender
{
    [ssidScanFrequency resignFirstResponder];
}

-(IBAction)closeKeyboardMinInterval:(id)sender
{
    [minInterval resignFirstResponder];
}

-(IBAction)closeKeyboardEmail:(id)sender
{
    [email resignFirstResponder];
}


@end

