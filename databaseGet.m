//
//  databaseGet.m
//  test5
//
//  Created by student on 13-9-25.
//  Copyright (c) 2013年 nww. All rights reserved.
//

#import "databaseGet.h"
@implementation databaseGet
@synthesize db;
@synthesize statement;
static int databaseIsReady=0;
//type值的是插入数据的类型,此插入操作不存在二进制数据传入
-(int)getR1:(NSString *)upsql :(NSMutableArray *)BindDate{
    if(!databaseIsReady){
        if (![self addDatabase]) {
            return 0;
        }
    }
    if(sqlite3_open([[self pathnameofDb:DataFile] UTF8String],&db)!=SQLITE_OK){
        NSLog(@"初始化成就表打开数据库失败");
        return -1;
    }    else{
        if(sqlite3_prepare_v2(db, [upsql UTF8String], -1, &statement, NULL)==SQLITE_OK){
            for(int i=0;i<[BindDate count];i++){
                NSLog(@"canshu wei%@",[BindDate objectAtIndex:i]);
                sqlite3_bind_text(statement,i+1,[[BindDate objectAtIndex:i] UTF8String],-1, NULL);
            }
            if(sqlite3_step(statement)!=SQLITE_DONE){
                NSLog(@"修改任务状态失败");
                return 0;
            }else{
                return 2;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return 0;
    }

}
//type值的是插入数据的类型，0表示二进制，1表示非二进制
//插入数据操作  返回2 表示成功
-(int)getR3:(NSString *)upsql :(NSMutableArray *)BindDate :(NSArray *)type{
    if(!databaseIsReady){
        if (![self addDatabase]) {
            return 0;
        }
    }
    if(sqlite3_open([[self pathnameofDb:DataFile] UTF8String],&db)!=SQLITE_OK){
        NSLog(@"初始化成就表打开数据库失败");
        return -1;
    }    else{
        int av=sqlite3_prepare_v2(db, [upsql UTF8String], -1, &statement, NULL);
        if(av==SQLITE_OK){
            for(int i=0;i<[BindDate count];i++){
                if([[type objectAtIndex:i] intValue]){
                    sqlite3_bind_text(statement,i+1,[[BindDate objectAtIndex:i] UTF8String],-1, NULL);
                }else{
                    NSData *temp=[BindDate objectAtIndex:i];
                    sqlite3_bind_blob(statement, i+1, [temp bytes], [temp length], NULL);
                }
            }
            int a=sqlite3_step(statement);
            if(a!=SQLITE_DONE){
                return 0;
            }else{
                return 2;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
        return 0;
    }
}
-(NSString *)pathnameofDb:(NSString *)filename{
    NSArray *doc=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *pathname=[doc objectAtIndex:0];
    NSLog(@"%@",[pathname stringByAppendingPathComponent:filename]);
    return [pathname stringByAppendingPathComponent:filename];
}
/*
 *type 0为整形  1为nsstring 2为二进制,type指的是返回数据的类型
 */
//查询操作,有数据返回
-(NSMutableArray *)getR2:(NSString *)upsql :(NSMutableArray *)BindDate :(NSArray *)type{
    if(!databaseIsReady){
        if (![self addDatabase]) {
            return 0;
        }
    }
    NSMutableArray *r=[[NSMutableArray alloc] init];
    if(sqlite3_open([[self pathnameofDb:DataFile] UTF8String],&db)!=SQLITE_OK){
        NSLog(@"初始化成就表打开数据库失败");
    }
    else{
        if(sqlite3_prepare_v2(db, [upsql UTF8String], -1, &statement, NULL)==SQLITE_OK){
            for(int i=0;i<[BindDate count];i++){
                sqlite3_bind_text(statement,i+1,[[BindDate objectAtIndex:i] UTF8String],-1, NULL);
            }
            while(sqlite3_step(statement)==SQLITE_ROW){
                for(int i=0;i<[type count];i++){
                    //0为整形  1为nsstring 2为二进制
                    if([type objectAtIndex:i]==[NSNumber numberWithInt:1]){
                        [r addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, i)]];
                    }
                    else if([type objectAtIndex:i]==[NSNumber numberWithInt:0]){
                        [r addObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(statement, i)]];
                    }
                    else
                    {
                        //注意此处返回的不是nsstring ,是nsdata类型  sqlite3_column_text
                        //http://stackoverflow.com/questions/24121298/converting-sqlite3-column-blob-to-nsstring
                        NSLog(@"%d", sqlite3_column_bytes(statement, i));
                        NSData *content = [[NSData alloc] initWithBytes:sqlite3_column_blob(statement, i) length:sqlite3_column_bytes(statement, i)];
                        [r addObject:content];
                    }
                }
            }
            sqlite3_finalize(statement);
            sqlite3_close(db);
        }
    }
    return r;
}
-(int)addDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DataFile];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) {databaseIsReady=1; NSLog(@"已经存在"); return 1;}
    else{
        // The writable database does not exist, so copy the default to the appropriate location.
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DataFile];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if (!success) {
            NSLog(@"数据库添加不成功，请联系相关开发人员");
            return 0;
        }else{
            databaseIsReady=1;
            return 1;
        }
    }
}
@end
