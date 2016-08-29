//
//  AppDelegate.m
//  PoliticsK
//
//  Created by 307A on 16/7/26.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DBHelper.h"

@interface AppDelegate ()
@property (nonatomic) MainViewController *mainViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initUserData];
    [self initDataBase];
    
    //测试 获得章节
    NSMutableArray *array = [DBHelper getSectionsBySubjectType:@"1"];
    
    //测试 获得题目
    NSMutableArray *array1 = [DBHelper getQuestionsBySection:[array objectAtIndex:0]];
    //通过代码显示视图
    self.window = [UIWindow new];
    [self.window makeKeyAndVisible];
    self.window.frame = [[UIScreen mainScreen] bounds];
    [self initAppNavigation];

    
    
    return YES;
}

-(void)initAppNavigation{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _mainNavigation = [[UINavigationController alloc] initWithRootViewController:_mainViewController];//唯一导航
    _mainNavigation.navigationBarHidden = YES;
    
    self.window.rootViewController = _mainNavigation;

}

- (void)initDataBase{
    [DBHelper initUserUsageDataSuccess:^(NSString *msg) {
        NSLog(@"%@",msg);
    } Failure:^(NSString *msg, NSError *error) {
        NSLog(@"%@",msg);
    }];
}

- (void)initUserData{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
