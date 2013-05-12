//
//  EmailContent.h
//  EmailZipPractice
//
//  Created by Ali Vafai on 5/11/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface EmailContent : UIViewController <MFMailComposeViewControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameOfNoteTaker;
@property (weak, nonatomic) IBOutlet UITextView *mainNote;

- (IBAction) actionEmailComposer;
- (IBAction) zipFileButton:(id)sender;

@end
