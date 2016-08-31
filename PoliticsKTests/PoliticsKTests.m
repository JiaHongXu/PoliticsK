//
//  PoliticsKTests.m
//  PoliticsKTests
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DBHelper.h"

@interface PoliticsKTests : XCTestCase
@property (nonatomic) NSMutableArray *array;
@end

@implementation PoliticsKTests

- (void)setUp {
    [super setUp];
    [DBHelper initUserUsageDataSuccess:^(NSString *msg) {
        NSLog(@"%@",msg);
    } Failure:^(NSString *msg, NSError *error) {
        NSLog(@"%@",msg);
    }];
    _array = [DBHelper getSectionsBySubjectType:@"1"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //初始化的代码，在测试方法调用之前调用
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    // 释放测试用例的资源代码，这个方法会每个测试用例执行后调用
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // 测试用例的例子，注意测试用例一定要test开头
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 测试性能例子
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码
        
        [DBHelper setupDataBaseForUser:@"aaa" withProgress:^(int progress) {
            NSLog(@"%d", progress);
        }];
    }];
}

@end
