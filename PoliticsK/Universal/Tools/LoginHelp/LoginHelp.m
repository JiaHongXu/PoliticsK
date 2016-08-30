//
//  LoginHelp.m
//  PoliticsK
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "LoginHelp.h"

@implementation LoginHelp

+ (void)loginWithUserID:(NSString *)userID andLoginType:(int)type{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:userID forKey:USER_ID];
    [defaults setInteger:type forKey:USER_TYPE];
    [defaults setBool:YES forKey:USER_IS_LOGIN];
    
//    NSMutableArray *userArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:USER_ARRAY]];
//    
//    if (![userArray containsObject:username]) {
//        [userArray addObject:username];
//    }
}

+ (BOOL)isUserLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN];
}

+ (BOOL)isFirstTimeLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:USER_ARRAY]];
    
    if ([userArray containsObject:[LoginHelp getUserID]]) {
        return NO;
    }else{
        return YES;
    }
}

+ (NSString *)getUsername{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
}

+ (NSString *)getUserID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
}

+(void)logout{
    
}
@end
