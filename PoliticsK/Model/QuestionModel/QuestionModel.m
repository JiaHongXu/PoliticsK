//
//  QuestionModel.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "QuestionModel.h"

@interface QuestionModel()
@property (nonatomic) NSString *questionNum;

@property (nonatomic) NSString *questionContent;
@property (nonatomic) NSString *explanation;

@property (nonatomic) NSMutableArray *options;
@property (nonatomic) NSMutableArray *correctAnswsers;

@end

@implementation QuestionModel

- (instancetype)initWithQuestion:(NSString *)questionNum andContent:(NSString *)content andCorrectAnswers:(NSString *)answers andExplaination:(NSString *)explanation{
    
    if (self = [super init]) {
        _questionNum = questionNum;
        _questionContent = content;
        _explanation = explanation;
        [self setCorrectAnswerWithString:answers];
    }
    
    return self;
}

- (NSString *)getContent{
    return _questionContent;
}

- (NSString *)getQuestionNum{
    return _questionNum;
}

- (void)setOption:(AnswerBean *)option{
    [_options addObject:option];
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
        for (AnswerBean *correctAnswer in _correctAnswsers) {
            if ([selectedAnswer getAnswerNum] == [correctAnswer getAnswerNum]) {
                if ([selectedAnswer getIsSelected]) {
                    i++;
                }else{
                    return NO;
                }
            }
        }
    }
    
    if (i==_correctAnswsers.count) {
        return YES;
    }else{
        return NO;
    }
}

- (void)setCorrectAnswerWithString:(NSString *)string{
    
}
@end
