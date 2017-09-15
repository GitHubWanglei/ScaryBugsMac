//
//  ScaryBugData.m
//  ScaryBugsMac
//
//  Created by wanglei on 2017/9/15.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "ScaryBugData.h"

@implementation ScaryBugData

- (instancetype)initWithTitle:(NSString *)title rating:(float)rating{
    self = [super init];
    if (self) {
        self.title = title;
        self.rating = rating;
    }
    return self;
}


@end
