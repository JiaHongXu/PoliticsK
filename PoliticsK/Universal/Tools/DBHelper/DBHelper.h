//
//  DBHelper.h
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionModel.h"
#import "SectionBean.h"

@interface DBHelper : NSObject

//初始化用户数据，主要针对 R_User_Question_Do_History 表进行批量插入操作
- (void)initUserUsageDataSuccess:(void(^)(NSString *msg))success Failure:(void(^)(NSString *msg, NSError *error))failure;

//根据章节号获取题目
- (NSMutableArray *)getQuestionsBySection:(SectionBean *)section;

//根据题目编号获取题目
- (QuestionModel *)getQuestionByQuestionNum:(NSString *)questionNum;

//根据科目号获取章节
- (NSMutableArray *)getSectionsByProjectType:(int)projectType;

//根据题号设置题目被收藏
- (void)setIsCollected:(BOOL)isCollected byQuestion:(QuestionModel *)question;

//根据题号增加题目对错记录
- (void)setIsCorrect:(BOOL)isCorrect byQuestion:(QuestionModel *)question;
@end
