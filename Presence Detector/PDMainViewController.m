//
//  PDMainViewController.m
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 27/01/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import "PDMainViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@interface PDMainViewController ()

@end

@implementation PDMainViewController

@synthesize timer, targetSSID, currentHour, flagStatus, control3G, controlNTW, controlTW;
@synthesize ssidResul, targetWifiTime, totalTime, flag, currentssid, startTime, finalResult, statusLabel;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[arrayResults objectAtIndex:0]intValue] == 0)
    {
        arrayResults = [[NSMutableArray alloc]init];
    }
    
    internetAvailability = [PDAvailabilityNetwork availabilityForInternetConnection];
}

-(void)configureInterfaceWithAvailability:(PDAvailabilityNetwork*)availability
{
    NetworkStatus netStatus = [availability currentAvailabilityStatus];
    NSString *ssidLabel = @"";
    currentHour.text = [self getHour];
    PDItemsTable *item = [[PDItemsTable alloc]init];
    PDMailComposeViewController *mailView = [[PDMailComposeViewController alloc]init];
    
    switch (netStatus) {
        case Use3G:          {
            NSLog(@"3G");
            controlNTW = 0;
            controlTW = 0;
            control3G += scanFrequency;
            ssidLabel = NSLocalizedString(@"Not Using Wifi", @"");
            item.changeTime = [self getHour];
            item.value = @"3G";
            item.ssid = @"3G";
            if ((flagStatus == 0 || flagStatus == 2 || flagStatus == 3 || ([arrayResults count] < 1)) && control3G >= minIntervalForChange){
                [arrayResults addObject:item];
                flagStatus = 1;
            }
            if (self.flag == 1)
            {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                [self localNotification];
                [mailView send:[NSString stringWithFormat:@"%@ --> Target SSID Disconnect. Your Status is 3G.", item.changeTime]];
                self.flag++;
            }
            break;
        }
        case UseWiFi:        {
            control3G = 0;
            ssidLabel = [self currentSSID];
            if([mySSIDString isEqualToString:ssidLabel] && self.totalTime != 0)
                self.ssidResul = 1;
            if (self.ssidResul == 1){
                NSLog(@"Target SSID");
                controlTW += scanFrequency;
                controlNTW = 0;
                flag = 1;
                targetWifiTime += scanFrequency;
                item.changeTime = [self getHour];
                item.value = @"Target SSID";
                item.ssid = [self currentSSID];
                if((flagStatus == 0 || flagStatus == 1 || flagStatus == 3 || ([arrayResults count] < 1)) && controlTW >= minIntervalForChange){
                    [arrayResults addObject:item];
                    flagStatus = 2;
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    [self localNotification];
                    [mailView send:[NSString stringWithFormat:@"%@ --> Connect to Target SSID, %@.", item.changeTime, item.ssid]];
                }
            }else{
                NSLog(@"No target SSID");
                controlTW = 0;
                controlNTW += scanFrequency;
                item.changeTime = [self getHour];
                item.value = @"No target SSID";
                item.ssid = [self currentSSID];
                if((flagStatus == 0 || flagStatus == 1 || flagStatus == 2 || ([arrayResults count] < 1)) && controlNTW >= minIntervalForChange){
                    [arrayResults addObject:item];
                    flagStatus = 3;
                }
                if (self.flag == 1)
                {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                    [self localNotification];
                    [mailView send:[NSString stringWithFormat:@"%@ --> Target SSID Disconnect. Your Status is %@.", item.changeTime, item.ssid]];
                    self.flag++;
                }
            }
            break;
        }
        default:
            break;
    }
    self.currentssid.text = ssidLabel;
 }

-(NSString*)currentSSID
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if(info[@"SSID"]){
            ssid = info[@"SSID"];
            NSLog(@"%@", ssid);
        }
    }
    return ssid;
}


-(NSString*)getHour{
    //Current date
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
    //Hour, minutes and seconds
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    
    NSString *hora = [NSString stringWithFormat:@"%02i:%02i", hours, minutes];
    return hora;
}

-(IBAction)startMonitorize:(id)sender
{
    startHour = [self getHour];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:scanFrequency target:self selector:@selector(start:) userInfo:nil repeats:YES];
    if ((mySSIDString != nil && alertMessageString != nil & scanFrequency != 0 && minIntervalForChange != 0))
        statusLabel.text = @"You are using Presence Detector";

}

-(void)start:(NSTimer*)timer
{
    if ((mySSIDString == nil || alertMessageString == nil || scanFrequency == 0 || minIntervalForChange == 0)){
        [self showAlertMessage1];
        [self.timer invalidate];
    }else{
        self.totalTime += scanFrequency;
        startTime.text = startHour;
        [self configureInterfaceWithAvailability:internetAvailability];
    }
    
}

-(void)localNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNotification.alertBody = alertMessageString;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    //localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(IBAction)resetTargetWifiTime:(id)sender
{
    float result = (self.targetWifiTime/self.totalTime)*1 * 100;   // Time(%) in Target SSID
    NSString *str = [NSString stringWithFormat:@"%.2f", result];
    self.finalResult.text = str;
    self.targetWifiTime = 0;
}

-(IBAction)stopMonitorize:(id)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
        self.totalTime = 0;
        mySSIDString = nil;
        alertMessageString = nil;
        scanFrequency = 0;
        flagSetting = 0;
        statusLabel.text = @"Press start to begin monitorize";
    }
}

-(void)showAlertMessage1
{
    UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Enter your Settings" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [message show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"OK"]) {
        NSLog(@"Ha pulsado OK");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
