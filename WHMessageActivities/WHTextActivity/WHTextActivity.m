//
//  WHTextActivity.m
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import "WHTextActivity.h"

@interface WHTextActivity () <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) WHTextActivityItem *textActivityItem;

@end

@implementation WHTextActivity

#pragma mark - UIActivity Overrides

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedString(@"Message", @"title for iMessage activity");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"textActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (![MFMessageComposeViewController canSendText]) {
        return NO;
    }

    for (id item in activityItems) {
        if ([WHTextActivityItem class]) {
            return YES;
        }
    }

    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHTextActivityItem class]]) {
            self.textActivityItem = item;
        }
    }
}

- (UIViewController *)activityViewController {
    if (self.textActivityItem.onTextActivitySelected) {
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        self.textActivityItem.onTextActivitySelected(messageController);
        messageController.messageComposeDelegate = self;

        return messageController;
    } else {
        return nil;
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self activityDidFinish:YES];
}


@end
