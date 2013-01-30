/*
 
 Copyright (c) 2013, Wayne Hartman
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of Wayne Hartman nor the
 names of its contributors may be used to endorse or promote products
 derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL WAYNE HARTMAN BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

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
