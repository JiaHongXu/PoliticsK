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

@implementation DBHelper

static FMDatabase *db;

+ (void)initUserUsageDataSuccess:(void (^)(NSString *))success Failure:(void (^)(NSString *, NSError *))failure{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IS_DB_COPIED]) {
        [self moveToDBFile];
    }
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:DBPATH];
    FMDatabase *database = [FMDatabase databaseWithPath:filePath];
    
    if ([database open]) {
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
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Question WHERE CharaterNum = %d", section.sectionNum];
    FMResultSet *s = [db executeQuery:sql];
    while ([s next]) {
        // 每条记录的检索值
        QuestionModel *model = [[QuestionModel alloc] initWithQuestion:[s stringForColumn:@"QuestionNum"] andContent:[s stringForColumn:@"QuestionContent"] andCorrectAnswers:[s stringForColumn:@"CorrectAnswer"] andExplaination:[s stringForColumn:@"QuestionExplain"]];
        [questions addObject:model];
    }
    
    return questions;
}

+ (NSMutableArray *)getSectionsBySubjectType:(int)SubjectType{
    NSMutableArray *sections = [[NSMutableArray alloc] initWithCapacity:0];
//    NSString *sql = [NSString stringWithFormat:@"SELECT  FROM Question WHERE CharaterNum = %d", section.sectionNum];
    
    return sections;
}
@end
