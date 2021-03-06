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
- (instancetype)initWithQuestion:(NSString *)questionNum andContent:(NSString *)content andCorrectAnswers:(NSString *)answers andExplaination:(NSString *)explanation;

//获取题号
- (NSString *)getQuestionNum;

//获取题目
- (NSString *)getContent;

//设置选项
- (void)setOption:(NSMutableArray *)options;

//获取选项
- (NSArray *)getOptions;

//获取解析
- (NSString *)getExplanation;

//选中选项和反选中选项
- (void)setAnswer:(AnswerBean *)answer isSelected:(BOOL)isSelected;
//检查已选择答案是否正确
- (BOOL)checkAnswer;
//获取正确答案个数
- (int)numberOfCorrectAnswers;
@end
