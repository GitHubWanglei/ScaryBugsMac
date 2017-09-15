//
//  ScaryBugsDoc.h
//  ScaryBugsMac
//
//  Created by wanglei on 2017/9/15.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScaryBugData.h"

@interface ScaryBugsDoc : NSObject

@property (nonatomic, strong) ScaryBugData *data;
@property (nonatomic, strong) NSImage *thumbImage;
@property (nonatomic, strong) NSImage *fullImage;

- (instancetype)initWithTitle:(NSString *)title
                       rating:(float)rating
                   thumbImage:(NSImage *)thumbImage
                    fullImage:(NSImage *)fullImage;

@end
