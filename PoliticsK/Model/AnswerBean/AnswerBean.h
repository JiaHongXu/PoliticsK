//
//  AnswerBean.h
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerBean : NSObject

- (instancetype)initWithNum:(NSString *)num andContent:(NSString *)content andOrder:(int)order;
- (NSString *)getAnswerNum;
- (NSString *)getAnswerContent;
- (int)getAnswerOrder;
- (void)setSelected:(BOOL)selected;
- (BOOL)getIsSelected;
@end
