//
//  QuestionModel.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "QuestionModel.h"

@interface QuestionModel()

@property (nonatomic) NSString *question;
@property (nonatomic) NSString *explanation;

@property (nonatomic) NSArray *options;
@property (nonatomic) NSArray *correctAnswsers;
@property (nonatomic) NSMutableArray *selectedAnswers;

@end

@implementation QuestionModel

- (instancetype)initWithQuestion:(NSString *)question Options:(NSArray *)options andCorrectAnswers:(NSArray *)answers andExplaination:(NSString *)explanation{
    
    if (self = [super init]) {
        _question = question;
        _options = options;
        _correctAnswsers = answers;
        _explanation = explanation;
        _selectedAnswers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

- (NSString *)getQuestion{
    return _question;
}

- (NSArray *)getOptions{
    return _options;
}

- (NSString *)getExplanation{
    return _explanation;
}

- (void)selectAnswer:(AnswerBean *)answer{
    NSNumber *index = [NSNumber numberWithUnsignedInteger:[_options indexOfObject:answer]];
    [_selectedAnswers addObject:index];
}

- (void)unselectAnswer:(AnswerBean *)answer{
    for (NSNumber *index in _selectedAnswers) {
        if ([index isEqualToNumber:[NSNumber numberWithUnsignedInteger:[_options indexOfObject:answer]]]) {
            [_selectedAnswers removeObject:index];
            return;
        }
    }
    
    NSAssert(@"发生异常", @"反选择出现错误");
}

- (BOOL)checkAnswer{
    int i = 0;
    
    for (NSNumber *selectedIndex in _selectedAnswers) {
        for (NSNumber *correctIndex in _correctAnswsers) {
            if ([selectedIndex isEqualToNumber:correctIndex]) {
                i++;
            }
        }
    }
    
    if (i==_correctAnswsers.count) {
        return YES;
    }else{
        return NO;
    }
}
@end
