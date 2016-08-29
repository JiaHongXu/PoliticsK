//
//  SectionBean.h
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionBean : NSObject
- (instancetype)initWithSectionNum:(NSString *)sectionNum andSectionName:(NSString *)sectionName;

- (NSString *)getSectionNum;

- (NSString *)getSectionName;
@end
