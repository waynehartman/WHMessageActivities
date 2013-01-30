//
//  WHTextActivityItem.m
//  Geekdom
//
//  Created by Wayne on 1/29/13.
//  Copyright (c) 2013 WayneHartman. All rights reserved.
//

#import "WHTextActivityItem.h"

@implementation WHTextActivityItem

+ (instancetype)textActivityItemWithSelectionHandler:(OnTextActivitySelected)onTextActivitySelected {
    WHTextActivityItem *item = [[WHTextActivityItem alloc] init];
    item.onTextActivitySelected = onTextActivitySelected;

    return item;
}

@end
