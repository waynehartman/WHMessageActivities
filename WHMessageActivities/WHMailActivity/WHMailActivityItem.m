//
//  WHMailActivityItem.m
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import "WHMailActivityItem.h"

@implementation WHMailActivityItem

+ (instancetype) mailActivityItemWithSelectionHandler:(OnMailActivitySelected)onMailActivitySelected {
    WHMailActivityItem *activityItem = [[WHMailActivityItem alloc] init];
    activityItem.onMailActivitySelected = onMailActivitySelected;

    return activityItem;
}

@end
