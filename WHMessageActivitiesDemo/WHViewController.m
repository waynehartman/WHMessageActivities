//
//  WHViewController.m
//  WHMessageActivities
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import "WHViewController.h"
#import "WHMailActivity.h"
#import "WHTextActivity.h"

@interface WHViewController ()

@end

@implementation WHViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)didSelectShare:(id)sender {
    NSMutableArray *activityItems = [NSMutableArray array];

    NSString *htmlBody = @"<html><body><h1>Customized body</h1></body></html>";

    //  For Mail
    [activityItems addObject:[WHMailActivityItem mailActivityItemWithSelectionHandler:^(MFMailComposeViewController *mailController) {
        [mailController setSubject:@"Hey it's a subject!"];
        [mailController setMessageBody:htmlBody isHTML:YES];
        [mailController addAttachmentData:[htmlBody dataUsingEncoding:NSUTF8StringEncoding]
                                 mimeType:@"text/html"
                                 fileName:@"Awesome Attachment.html"];
        mailController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];

    //  For texting
    [activityItems addObject:[WHTextActivityItem textActivityItemWithSelectionHandler:^(MFMessageComposeViewController *messageController) {
        [messageController setBody:@"My super awesome message for texting only!"];
        messageController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }]];

    //  For everything else
    [activityItems addObject:@"Some boring text that should be copied..."];

    NSArray *activities = (@[
                            [[WHMailActivity alloc] init],
                            [[WHTextActivity alloc] init]   // keep in mind that texting is broken on the simulator...
                           ]);

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                     applicationActivities:activities];
    activityController.excludedActivityTypes = (@[
                                                    UIActivityTypeAssignToContact,
                                                    UIActivityTypeMail,
                                                    UIActivityTypeMessage,
                                                    UIActivityTypePrint,
                                                    UIActivityTypeSaveToCameraRoll
                                                ]);

    [self presentViewController:activityController animated:YES completion:NULL];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
