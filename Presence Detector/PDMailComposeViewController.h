//
//  PDMailComposeViewController.h
//  Presence Detector
//
//  Created by Francisco Ortiz Abril on 29/03/14.
//  Copyright (c) 2014 US. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "sendgrid.h"
#import "PDMainViewController.h"

@interface PDMailComposeViewController : UIViewController <MFMailComposeViewControllerDelegate>{
    
}

/*!
 *  Send email
 */
-(void)send:(NSString*)body;


@end
