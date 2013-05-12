//
//  HomePageViewController.m
//  EmailZipPractice
//
//  Created by Ali Vafai on 5/11/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "EmailContent.h"
#import "AppDelegate.h"

@interface EmailContent ()
{
    NSManagedObjectContext *context ;
}
@end

@implementation EmailContent

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
    // Do any additional setup after loading the view from its nib.
    [[self nameOfNoteTaker]setDelegate:self];
    AppDelegate *appdel = [[UIApplication sharedApplication]delegate];
    context = [appdel managedObjectContext];
}

- (IBAction)actionEmailComposer {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notes" inManagedObjectContext:context];
    Notes *newNote = [[Notes alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    newNote.noteTaker = self.nameOfNoteTaker.text;
    newNote.noteBody = self.mainNote.text ;
    NSError *error;
    [context save:&error];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@""];
        [mailViewController setSubject:@"Testing emailing function in app"];
        [mailViewController setMessageBody:@"How are you?" isHTML:NO];

        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* dPath = [paths objectAtIndex:0];
        NSString* txtfile = [dPath stringByAppendingPathComponent:@"EmailZipPractice.zip"];

        NSURL *aURL = [NSURL fileURLWithPath:txtfile];
        NSData *myData = [NSData dataWithContentsOfURL:aURL];
        [mailViewController addAttachmentData:myData mimeType:@"application/zip" fileName:@"EmailZipPractice.zip"];

        [self presentViewController:mailViewController animated:YES completion:nil];
    }else {
        NSLog(@"Device is unable to send email in its current state.");
    }
}

- (IBAction)zipFileButton:(id)sender {
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dPath = [paths objectAtIndex:0];
    NSString* txtfile = [dPath stringByAppendingPathComponent:@"EmailZipPractice.sqlite"];
    NSString* zipfile = [dPath stringByAppendingPathComponent:@"EmailZipPractice.zip"];
    ZipArchive* zip = [[ZipArchive alloc] init];
    BOOL ret = [zip CreateZipFile2:zipfile];
    ret = [zip addFileToZip:txtfile newname:@"EmailZipPractice.sqlite"];//zip
    if( ![zip CloseZipFile2] )
    {
        zipfile = @"";
    }
    
    NSLog(@"The file has been zipped");


}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end