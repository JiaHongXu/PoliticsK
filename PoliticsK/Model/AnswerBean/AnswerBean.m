//
//  AnswerBean.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "AnswerBean.h"
@interface AnswerBean()
@property (nonatomic) NSString *answerNum;
@property (nonatomic) NSString *anserContent;
@property (nonatomic) int answerOrder;//A,B,C,D
@property (nonatomic) BOOL isSelected;
@end

@implementation AnswerBean

- (instancetype)initWithNum:(NSString *)num andContent:(NSString *)content andOrder:(int)order{
    if (self = [super init]) {
        _answerNum = num;
        _anserContent = content;
        _answerOrder = order;
        _isSelected = NO;
    }
    return self;
}

- (NSString *)getAnswerNum{
    return _answerNum;
}

- (NSString *)getAnswerContent{
    return _anserContent;
}

- (int)getAnswerOrder{
    return _answerOrder;
}

- (void)setSelected:(BOOL)selected{
    _isSelected = selected;
}

- (BOOL)getIsSelected{
    return _isSelected;
}
@end
