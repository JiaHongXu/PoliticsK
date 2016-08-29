//
//  DBHelper.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabase.h"
#import "QuestionModel.h"
#import "SectionBean.h"
#import "AnswerBean.h"

@implementation DBHelper

static FMDatabase *db;

+ (void)initUserUsageDataSuccess:(void (^)(NSString *))success Failure:(void (^)(NSString *, NSError *))failure{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IS_DB_COPIED]) {
        [self moveToDBFile];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:DBPATH];
    db = [FMDatabase databaseWithPath:filePath];
    
    if ([db open]) {
        success(@"打开数据库成功");
    }else{
        failure(@"打开数据库失败", nil);
    }
}

+ (void)moveToDBFile{
    //1、获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"TiKuDB"ofType:@"sqlite"];
    
    //2、获得沙盒中Document文件夹的路径——目的路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *desPath = [documentPath stringByAppendingPathComponent:@"TiKuDB.sqlite"];
    
    //3、通过NSFileManager类，将工程中的数据库文件复制到沙盒中。
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:desPath])
    {
        NSError *error ;
        
        if ([fileManager copyItemAtPath:sourcesPath toPath:desPath error:&error]) {
            NSLog(@"数据库移动成功");
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_DB_COPIED];
        }
        else {
            NSLog(@"数据库移动失败");
        }
    }
}

+ (NSMutableArray *)getQuestionsBySection:(SectionBean *)section{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Question WHERE CharaterNum = %@", [section getSectionNum]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        // 每条记录的检索值
        QuestionModel *model = [[QuestionModel alloc] initWithQuestion:[s stringForColumn:@"QuestionNum"] andContent:[s stringForColumn:@"QuestionContent"] andCorrectAnswers:[s stringForColumn:@"CorrectAnswer"] andExplaination:[s stringForColumn:@"QuestionExplain"]];
        [self setOptionsByQuestion:model];
        [questions addObject:model];
    }
    
    return questions;
}

+ (QuestionModel *)getQuestionByQuestionNum:(NSString *)questionNum{
    QuestionModel *model;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Question WHERE QuestionNum = %@", questionNum];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        model = [[QuestionModel alloc] initWithQuestion:[s stringForColumn:@"QuestionNum"] andContent:[s stringForColumn:@"QuestionContent"] andCorrectAnswers:[s stringForColumn:@"CorrectAnswer"] andExplaination:[s stringForColumn:@"QuestionExplain"]];
    }
    
    return model;
}

+ (void)setOptionsByQuestion:(QuestionModel *)question{
    NSMutableArray *options = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Answer WHERE QuestionNum = %@", [question getQuestionNum]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        // 每条记录的检索值
        AnswerBean *bean = [[AnswerBean alloc] initWithAnswerNum:[s stringForColumn:@"AnswerNum"] andQuestionNum:[s stringForColumn:@"QuestionNum"] andContent:[s stringForColumn:@"AnswerContent"] andOrder:[s stringForColumn:@"AnswerABCD"]];
        [options addObject:bean];
    }
    [question setOption:options];
}

+ (NSMutableArray *)getSectionsBySubjectType:(NSString *)SubjectType{
    NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *sql = [NSString stringWithFormat:@"SELECT Charater.CharaterNum, Charater.CharaterName FROM Charater, Section, R_Section_Charater WHERE Charater.CharaterNum = R_Section_Charater.CharaterNum and R_Section_Charater.SectionNum = Section.SectionNum and Section.SectionNum = %@", SubjectType];
    
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        // 每条记录的检索值
        SectionBean *bean = [[SectionBean alloc] initWithSectionNum:[s stringForColumn:@"CharaterNum"] andSectionName:[s stringForColumn:@"CharaterName"]];
                             
        [sections addObject:bean];
    }

    return sections;
}

+ (void)setIsCorrect:(BOOL)isCorrect byQuestion:(QuestionModel *)question{
    int boolValue = [self valueOfBool:isCorrect];
    
//    NSString *sql = [NSString stringWithFormat:@"UPDATE SET  WHERE CharaterNum = %@", [section getSectionNum]];
//    
//    if (![db executeUpdate:sql]) {
//        NSLog(@"%@", [db lastError].description);
//    }
}

+ (void)setIsCollected:(BOOL)isCollected byQuestion:(QuestionModel *)question{
    
}

+ (int)valueOfBool:(BOOL)Bool{
    if (Bool) {
        return 1;
    }else{
        return 0;
    }
}
@end
