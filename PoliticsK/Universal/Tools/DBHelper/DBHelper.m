//
//  DBHelper.m
//  PoliticsK
//
//  Created by 307A on 16/8/27.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "DBHelper.h"
#import "LoginHelp.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "QuestionModel.h"
#import "SectionBean.h"
#import "AnswerBean.h"

@implementation DBHelper

static FMDatabase *db;
static NSString *db_path;

+ (void)initUserUsageDataSuccess:(void (^)(NSString *))success Failure:(void (^)(NSString *, NSError *))failure{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IS_DB_COPIED]) {
        [self moveToDBFile];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    db_path = [path stringByAppendingPathComponent:DBPATH];
    db = [FMDatabase databaseWithPath:db_path];
    
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

+ (NSMutableArray *)getQuestionNumOfAllQuestion{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *sql = @"SELECT QuestionNum, CorrectAnswer FROM Question";
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        [array addObject:[s stringForColumn:@"QuestionNum"]];
    }
    
    return array;
}


+ (void)setupDataBaseForUser:(NSString *)userID{
    NSMutableArray *array = [self getQuestionNumOfAllQuestion];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:db_path];
    dispatch_queue_t q = dispatch_queue_create("UserDatabaseInitQueue", NULL);
    
    dispatch_async(q, ^{
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            NSString *sql = @"";
            NSString *questionNum;
            
            for (int i = 0; i < array.count; i++) {
                questionNum = [array objectAtIndex:i];
                sql = [NSString stringWithFormat:@"INSERT INTO R_User_Question_Do_History VALUES ( \"%@\", \"%@\", 0, 0, 0 )", userID, questionNum];

                if (![db executeUpdate:sql]) {
                    NSLog(@"%@,%d", [db lastError].description, i);
                }
            }
            
        }];
    });
}

+ (void)setupDataBaseForUser:(NSString *)userID withProgress:(void(^)(int progress))progress {
    NSMutableArray *array = [self getQuestionNumOfAllQuestion];
    
//    NSString *sql = @"";
//    NSString *questionNum;
//    
//    int lastProgress = 0;
//    int currentProgress = 0;
//    
//    for (int i = 0; i < array.count; i++) {
//        questionNum = [array objectAtIndex:i];
//        sql = [NSString stringWithFormat:@"INSERT INTO R_User_Question_Do_History VALUES ( \"%@\", \"%@\", 0, 0, 0 )", userID, questionNum];
//        
//        currentProgress = ((float)(i+1)/(float)array.count)*100;
//        
//        if (currentProgress!=lastProgress) {
//            progress(currentProgress);
//            lastProgress = currentProgress;
//        }
//        
//        if (![db executeUpdate:sql]) {
//            NSLog(@"%@,%d", [db lastError].description, i);
//        }
//    }
    
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:db_path];
    dispatch_queue_t q = dispatch_queue_create("UserDatabaseInitQueue", NULL);
    
    dispatch_async(q, ^{
        [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            //开启缓存
            [db shouldCacheStatements];
            
            NSString *sql = @"";
            NSString *questionNum;
            
            int lastProgress = 0;
            int currentProgress = 0;
            
            for (int i = 0; i < array.count; i++) {
                questionNum = [array objectAtIndex:i];
                sql = [NSString stringWithFormat:@"INSERT INTO R_User_Question_Do_History VALUES ( \"%@\", \"%@\", 0, 0, 0 )", userID, questionNum];
                
                currentProgress = ((float)(i+1)/(float)array.count)*100;
                
                if (currentProgress!=lastProgress) {
                    progress(currentProgress);
                    lastProgress = currentProgress;
                }
                
                if (![db executeUpdate:sql]) {
                    NSLog(@"%@,%d", [db lastError].description, i);
                }
            }
            
        }];
    });
}

+ (void)deleteDataBaseForUser:(NSString *)userID {
    NSString *sql = @"";
    sql = [NSString stringWithFormat:@"DELETE FROM R_User_Question_Do_History WHERE UserID = \"%@\"", userID];
    
    if(![db executeUpdate:sql]){
        NSLog(@"删除数据出错");
    }else{
        NSLog(@"删除数据成功");
    }
}

+ (NSMutableArray *)getQuestionsBySection:(SectionBean *)section{
    NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:0];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Question WHERE CharaterNum = %@", [section getSectionNum]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        // 每条记录的检索值
        QuestionModel *model = [[QuestionModel alloc] initWithQuestion:[s stringForColumn:@"QuestionNum"] andContent:[s stringForColumn:@"QuestionContent"] andCorrectAnswers:[s stringForColumn:@"CorrectAnswer"] andExplaination:[s stringForColumn:@"QuestionExplain"]];
        //        [self setOptionsByQuestion:model];
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
    if (isCorrect) {
        NSString *sql = [NSString stringWithFormat:@"UPDATE R_User_Question_Do_History SET rightTimes = %d WHERE QuestionNum = %@ and UserID = %@", [self getCorrectTimesByQuestion:question] + 1, [question getQuestionNum], [LoginHelp getUserID]];
        
        if (![db executeUpdate:sql]) {
            NSLog(@"%@", [db lastError].description);
        }
    }else{
        NSString *sql = [NSString stringWithFormat:@"UPDATE R_User_Question_Do_History SET wrongTimes = %d WHERE QuestionNum = %@ and UserID = %@", [self getWrongTimesByQuestion:question] + 1, [question getQuestionNum], [LoginHelp getUserID]];
        
        if (![db executeUpdate:sql]) {
            NSLog(@"%@", [db lastError].description);
        }
    }
}

+ (void)setIsCollected:(BOOL)isCollected byQuestion:(QuestionModel *)question{
    int boolValue = isCollected ? 1 : 0;
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE R_User_Question_Do_History SET isCollected = %d WHERE QuestionNum = %@ and UserID = %@", boolValue, [question getQuestionNum], [LoginHelp getUserID]];
    
    if (![db executeUpdate:sql]) {
        NSLog(@"%@", [db lastError].description);
    }
}

+ (BOOL)getIsCollectedByQuestion:(QuestionModel *)question{
    NSString *sql = [NSString stringWithFormat:@"SELECT isCollected FROM R_User_Question_Do_History WHERE QuestionNum = %@ and UserID = %@", [question getQuestionNum], [LoginHelp getUserID]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        return [s intForColumn:@"isCollected"] == 1 ? YES : NO;
    }
    return NO;
}

+ (int)getCorrectTimesByQuestion:(QuestionModel *)question{
    NSString *sql = [NSString stringWithFormat:@"SELECT rightTimes FROM R_User_Question_Do_History WHERE QuestionNum = %@ and UserID = %@", [question getQuestionNum], [LoginHelp getUserID]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        return [s intForColumn:@"rightTimes"];
    }
    
    return 0;
}

+ (int)getWrongTimesByQuestion:(QuestionModel *)question{
    NSString *sql = [NSString stringWithFormat:@"SELECT wrongTimes FROM R_User_Question_Do_History WHERE QuestionNum = %@ and UserID = %@", [question getQuestionNum], [LoginHelp getUserID]];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        return [s intForColumn:@"wrongTimes"];
    }
    
    return 0;
}
@end
