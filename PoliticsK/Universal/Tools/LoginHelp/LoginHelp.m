//
//  LoginHelp.m
//  PoliticsK
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "LoginHelp.h"

@implementation LoginHelp

+ (void)loginWithUsername:(NSString *)username andLoginType:(int)type{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:username forKey:USER_NAME];
    [defaults setObject:username forKey:USER_TYPE];
    [defaults setBool:YES forKey:USER_IS_LOGIN];
}

+ (BOOL)isUserLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_IS_LOGIN];
}

+ (NSString *)getUsername{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
}

+(void)logout{
    
}
@end
