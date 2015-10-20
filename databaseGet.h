//
//  databaseGet.h
//  test5
//
//  Created by student on 13-9-25.
//  Copyright (c) 2013年 nww. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "sqlite3.h"
#define DataFile @"Towhere.sqlite"
@interface databaseGet : NSObject{
    sqlite3 *db;
    sqlite3_stmt *statement;
}
@property (nonatomic) sqlite3 *db;
@property (nonatomic) sqlite3_stmt *statement;
-(int)getR1:(NSString *) upsql :(NSMutableArray *)BindDate;
-(NSMutableArray *)getR2:(NSString *) upsql :(NSMutableArray *)BindDate :(NSArray *) type;
-(int)getR3:(NSString *)upsql :(NSMutableArray *)BindDate :(NSArray *)type;
-(NSString *)pathnameofDb:(NSString *)filename;
@end

