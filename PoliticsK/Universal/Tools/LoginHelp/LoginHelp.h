//
//  LoginHelp.h
//  PoliticsK
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelp : NSObject

+ (void)loginWithUsername:(NSString *)username andLoginType:(int)type;

+ (BOOL)isUserLogin;

+ (NSString *)getUsername;

+ (void)logout;
@end
