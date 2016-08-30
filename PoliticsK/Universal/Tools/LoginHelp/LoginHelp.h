//
//  LoginHelp.h
//  PoliticsK
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelp : NSObject

+ (void)loginWithUserID:(NSString *)userID andLoginType:(int)type;

+ (BOOL)isUserLogin;

//昵称
+ (NSString *)getUsername;

+ (NSString *)getUserID;

+ (BOOL)isFirstTimeLogin;

+ (void)logout;
@end
