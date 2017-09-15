//
//  ScaryBugsDoc.m
//  ScaryBugsMac
//
//  Created by wanglei on 2017/9/15.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "ScaryBugsDoc.h"

@implementation ScaryBugsDoc

- (instancetype)initWithTitle:(NSString *)title
                       rating:(float)rating
                   thumbImage:(NSImage *)thumbImage
                    fullImage:(NSImage *)fullImage{
    self = [super init];
    if (self) {
        self.data = [[ScaryBugData alloc] initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
