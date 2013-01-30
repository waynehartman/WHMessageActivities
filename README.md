`WHMessageActivities`
===================

__What__: `UIActivity` subclasses for direct customization of `MessageUI` controllers.

__Why__: `UIActivity` is an awesome API for sharing content with built-in iOS services.  It's really easy to share via email and text message with the built-in activities, but for one really fatal flaw:  Apple's API doesn't allow for customizing content specific to the built-in activities.  Take `MFMailComposeViewController`: incredibly useful, except that there's no API for setting the subject and adding attachments.  Lame.  Another example:  The text you put on there for a Tweet might be different from the text you put into a text message.  But there's no API to be able to specify special text for the text message. Lame.

__How__: Add `MessageUI.framework` to your project, then instantiate a `WHMailActivityItem` with a selection handler, using it to populate the contents of a `MFMailComposeViewController` or `MFMessageComposeViewController`:

    [NSMutableArray *activityItems = [NSMutableArray array];


    // For Mail Messages
    NSString *htmlBody = @"<html><body><h1>Customized body</h1></body></html>";
    [activityItems addObject:[WHMailActivityItem mailActivityItemWithSelectionHandler:^(MFMailComposeViewController *mailController) {
        [mailController setSubject:@"Hey it's a subject!"];
        [mailController setMessageBody:htmlBody isHTML:YES];
        [mailController addAttachmentData:[htmlBody dataUsingEncoding:NSUTF8StringEncoding]
                                 mimeType:@"text/html"
                                 fileName:@"Awesome Attachment.html"];
    }]];

    //  For texting
    [activityItems addObject:[WHTextActivityItem textActivityItemWithSelectionHandler:^(MFMessageComposeViewController *messageController) {
        [messageController setBody:@"My super awesome message for texting only!"];
    }]];

    NSArray *activities = (@[
                            [[WHMailActivity alloc] init],
                            [[WHTextActivity alloc] init]   // keep in mind that texting is broken on the simulator...
                           ]);

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                                     applicationActivities:activities];
    // turn off Apple's activities                                                                                     
    activityController.excludedActivityTypes = (@[
                                                    UIActivityTypeMail,
                                                    UIActivityTypeMessage,
                                                ]);
    // let 'er rip!
    [self presentViewController:activityController animated:YES completion:NULL];
