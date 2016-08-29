//
//  PoliticEngine.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//


#import "PoliticEngine.h"

@interface PoliticEngine()

@property (nonatomic) NSMutableArray *questions;
@property (nonatomic) int correctCount;
@property (nonatomic) int unfinishedCount;
@property (nonatomic) int leftTime;

@end

@implementation PoliticEngine
static PoliticEngine *sharePoliticEngine = nil;

+ (PoliticEngine *)getSharePoliticEngine{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharePoliticEngine = [[self alloc] init];
    });
    [sharePoliticEngine reuseSharePoliticEngine];
    
    return sharePoliticEngine;
}

- (instancetype)init{
    if (self = [super init]) {
        _questions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

- (void)reuseSharePoliticEngine{
    [_questions removeAllObjects];
    _correctCount = 0;
    _unfinishedCount = 0;
    _leftTime = 0;
}

- (PoliticEngine *)getPoliticEngineWithSection:(SectionBean *)section andType:(int)doType{
    [sharePoliticEngine reuseSharePoliticEngine];
    
    
    
    return sharePoliticEngine;
}


@end
