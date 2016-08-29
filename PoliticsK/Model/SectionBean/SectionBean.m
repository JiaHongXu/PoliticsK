//
//  SectionBean.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "SectionBean.h"
@interface SectionBean ()
@property (nonatomic) NSString *sectionNum;
@property (nonatomic) NSString *sectionName;
@end
@implementation SectionBean

- (instancetype)initWithSectionNum:(NSString *)sectionNum andSectionName:(NSString *)sectionName{
    if (self = [super init]) {
        _sectionNum = sectionNum;
        _sectionName = sectionName;
    }
    
    return self;
}

- (NSString *)getSectionNum{
    return _sectionNum;
}

- (NSString *)getSectionName{
    return _sectionName;
}
@end
