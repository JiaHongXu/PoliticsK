//
//  QuestionModel.h
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "AnswerBean.h"

@interface QuestionModel : NSObject

//初始化
- (instancetype)initWithQuestion:(NSString *)question Options:(NSArray *)options andCorrectAnswers:(NSArray *)answers andExplaination:(NSString *)explanation;

//获取题目
- (NSString *)getQuestion;

//获取选项列表
- (NSArray *)getOptions;

//获取解析
- (NSString *)getExplanation;

//选中选项和反选中选项
- (void)selectAnswer:(AnswerBean *)answer;
- (void)unselectAnswer:(AnswerBean *)answer;

//检查已选择答案是否正确
- (BOOL)checkAnswer;
@end
