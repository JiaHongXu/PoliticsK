//
//  PoliticHelper.h
//  PoliticsK
//
//  Created by 307A on 16/8/28.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoliticHelper : NSObject

//获取章节
//projectType:科目类型
+ (NSMutableArray *)getSectionsWithProject:(int)projectType;
@end
