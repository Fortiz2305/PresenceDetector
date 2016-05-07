//
//  PDMailComposeViewController.m
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 29/03/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import "PDMailComposeViewController.h"

@interface PDMailComposeViewController ()

@end

@implementation PDMailComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)send:(NSString*)body
{
    sendgrid *msg = [sendgrid user:@"Fortiz2305" andPass:@"Proyecto2014"];
    msg.to = emailRecipientString;
    msg.subject = @"Presence Detector";
    msg.text = body;
    msg.from = @"presencedetector2014@gmail.com";
    msg.html = body;
    
    [msg sendWithWeb];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
