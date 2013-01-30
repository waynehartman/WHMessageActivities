//
//  WHTextActivityItem.h
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

typedef void(^OnTextActivitySelected)(MFMessageComposeViewController *messageComposeController);

@interface WHTextActivityItem : NSObject

+ (instancetype)textActivityItemWithSelectionHandler:(OnTextActivitySelected)onTextActivitySelected;

@property (nonatomic, copy) OnTextActivitySelected onTextActivitySelected;

@end
