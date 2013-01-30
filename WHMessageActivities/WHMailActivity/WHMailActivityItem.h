//
//  WHMailActivityItem.h
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

typedef void(^OnMailActivitySelected)(MFMailComposeViewController *mailComposeController);

@interface WHMailActivityItem : NSObject

@property (nonatomic, copy) OnMailActivitySelected onMailActivitySelected;

+ (instancetype) mailActivityItemWithSelectionHandler:(OnMailActivitySelected)onMailActivitySelected;

@end
