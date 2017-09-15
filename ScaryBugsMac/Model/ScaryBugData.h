//
//  ScaryBugData.h
//  ScaryBugsMac
//
//  Created by wanglei on 2017/9/15.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float rating;

- (instancetype)initWithTitle:(NSString *)title rating:(float)rating;

@end
