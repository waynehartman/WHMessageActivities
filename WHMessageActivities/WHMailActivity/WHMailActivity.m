//
//  WHMailActivity.m
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import "WHMailActivity.h"

@interface WHMailActivity() <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong)WHMailActivityItem *activityItem;

@end


@implementation WHMailActivity

#pragma mark - UIActivity Overrides

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (NSString *)activityTitle {
    return NSLocalizedString(@"Mail", @"title for Mail activity item");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"mailActivity.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (![MFMailComposeViewController canSendMail]) {
        return NO;
    }

    for (id item in activityItems) {
        if ([item isKindOfClass:[WHMailActivityItem class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[WHMailActivityItem class]]){
            self.activityItem = item;
        }
    }
}

- (UIViewController *)activityViewController {
    if (self.activityItem.onMailActivitySelected) {
        MFMailComposeViewController *composeController = [[MFMailComposeViewController alloc] init];
        self.activityItem.onMailActivitySelected(composeController);
        composeController.mailComposeDelegate = self;

        return composeController;
    } else {
        return nil;
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self activityDidFinish:YES];
}

@end
