//
//  QuestionModel.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "QuestionModel.h"
#import "DBHelper.h"

@interface QuestionModel()
@property (nonatomic) NSString *questionNum;

@property (nonatomic) NSString *questionContent;
@property (nonatomic) NSString *explanation;

@property (nonatomic) NSMutableArray *options;
@property (nonatomic) NSString *correctAnswsers;

@end

@implementation QuestionModel

- (instancetype)initWithQuestion:(NSString *)questionNum andContent:(NSString *)content andCorrectAnswers:(NSString *)answers andExplaination:(NSString *)explanation{
    
    if (self = [super init]) {
        _questionNum = questionNum;
        _questionContent = content;
        _explanation = explanation;
        _correctAnswsers = answers;
    }
    
    return self;
}

- (NSString *)getContent{
    return _questionContent;
}

- (NSString *)getQuestionNum{
    return _questionNum;
}

- (void)setOption:(NSMutableArray *)options{
    _options = options;
}

- (NSArray *)getOptions{
    return _options;
}

- (NSString *)getExplanation{
    return _explanation;
}

- (void)setAnswer:(AnswerBean *)answer isSelected:(BOOL)isSelected{
    for (AnswerBean *temp in _options) {
        if ([[temp getAnswerNum] isEqualToString:[answer getAnswerNum]]) {
            [temp setSelected:isSelected];
            return;
        }
    }
    
    NSAssert(@"选项错误", @"没有选中");
}

- (BOOL)checkAnswer{
    int i = 0;
    
    for (AnswerBean *selectedAnswer in _options) {
        if ([selectedAnswer getIsSelected]) {
            if ([_correctAnswsers containsString:[selectedAnswer getAnswerOrder]]) {
                i++;
            }
        }
    }
    
    if (i==[self numberOfCorrectAnswers]) {
        return YES;
    }else{
        return NO;
    }
}

- (int)numberOfCorrectAnswers{
    return ((int)[_correctAnswsers length] + 1)/2;
}

@end
