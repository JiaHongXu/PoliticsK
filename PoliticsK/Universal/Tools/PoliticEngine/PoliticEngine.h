//
//  PoliticEngine.h
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//
//  用于支撑总体业务，单例
//  掌握题库操作方式，从题库提取题目进入题目池，拥有题目队列

#import <Foundation/Foundation.h>

#import "QuestionModel.h"
#import "SectionBean.h"

@interface PoliticEngine : NSObject

//获取PoliticEngine实例
//section:选择的章节 doType:答题模式
- (PoliticEngine *)getPoliticEngineWithSection:(SectionBean *)section andType:(int)doType;

//section:选择的科目 doType:答题模式
- (PoliticEngine *)getPoliticEngineWithSubject:(int)Subject andType:(int)doType;

//获得上一个、下一个题目
- (QuestionModel *)getNextQuestion;
- (QuestionModel *)getLastQuestion;

//获得答题进度
- (int)getProgress;
@end
