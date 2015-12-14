//
//  LSPStatusTool.m
//  微视界
//
//  Created by mac on 15-12-2.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStatusTool.h"
#import "FMDB.h"
@implementation LSPStatusTool

//创建数据库
static FMDatabase *_fmdb;

+ (void)initialize
{
    //沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"];
    //打开数据库
    _fmdb = [FMDatabase databaseWithPath:path];
    [_fmdb open];
    //创建数据库表
    [_fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status(id integer PRIMARY KEY,status blob NOT NULL,idstr text NOT NULL);"];
}

/**
 *  根据请求去沙盒中查找需要加载的微博数据
 */
+ (NSArray *)statusWithParams:(NSDictionary *)params
{
    //根据请求参数执行对应的数据库查询语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT *FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;",params[@"since_id"]];
    }else if (params[@"max_id"]){
        
        sql = [NSString stringWithFormat:@"SELECT *FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;",params[@"max_id"]];
    }else{
        sql = @"SELECT *FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    
    //执行查询的SQL语句
    FMResultSet *set = [_fmdb executeQuery:sql];
    NSMutableArray *status = [NSMutableArray array];
    while (set.next) {
        
        NSData *data = [set objectForColumnName:@"status"];
        NSDictionary *statue = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [status addObject:statue];
        
    }
    return status;
}
/**
 *  保存微博数据
 */
+ (void)saveStatus:(NSArray *)status
{
    for (NSDictionary *statues in status) {
        
       NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statues];
        
        [_fmdb executeUpdateWithFormat:@"INSERT INTO t_status(status,idstr) VALUES(%@,%@);",statusData,statues[@"idstr"]];
    }
    
    
    
}

@end
