//
//  CrudOp.m
//  crud
//
//  Created by Kevin Languedoc on 11/29/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import "CrudOp.h"

@implementation CrudOp
@synthesize  coldbl;
@synthesize colint;
@synthesize coltext;
@synthesize dataId;
@synthesize fileMgr;
@synthesize homeDir;
@synthesize title;


-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
    
    return homeDir;
}

-(void)CopyDbToDocumentsFolder{
    NSError *err=nil;
   
    fileMgr = [NSFileManager defaultManager];
   
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"cruddb.sqlite"]; 
    
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
    
    [fileMgr removeItemAtPath:copydbpath error:&err];
    if(![fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
    {
        UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:title message:@"Unable to copy database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [tellErr show];

    }
               
}

-(void)InsertRecords:(NSMutableString *) txt :(int) integer :(double) dbl
{
    fileMgr = [NSFileManager defaultManager];
    //Get list of directories in Document path 
    NSArray * dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Define new path for database
    NSString * documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"cruddb.sqlite"];
    NSLog(@"%@", documentPath);
    
    //Copy the database
    if([fileMgr fileExistsAtPath:documentPath]) {
        sqlite3_stmt *stmt=nil;
        sqlite3 *cruddb;
        
        //insert
        const char *sql = "Insert into data(coltext, colint, coldouble) values(?,?,?)";
        
        //Open db
        //NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
        if(sqlite3_open([documentPath UTF8String], &cruddb)==SQLITE_OK) {
            
            if(sqlite3_prepare(cruddb, sql, -1, &stmt, NULL)==SQLITE_OK) {
                sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_int(stmt, 2, integer);
                sqlite3_bind_double(stmt, 3, dbl);
                sqlite3_step(stmt);
                sqlite3_finalize(stmt);
                sqlite3_close(cruddb);   
                NSLog(@"InsertRecords: insert record success.");
            } else {
                NSLog(@"InsertRecords: Prepare Statement error");
            }
        } else {
            NSLog(@"Error opening database");
        }
    }
}
            
-(void)UpdateRecords:(NSString *)txt :(NSMutableString *)utxt{
    
    fileMgr = [NSFileManager defaultManager];
    //Get list of directories in Document path
    NSArray * dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"cruddb.sqlite"];
    
    if ([fileMgr fileExistsAtPath:documentPath]) {
        sqlite3_stmt *stmt=nil;
        sqlite3 *cruddb;
        
        //update
        const char *sql = "Update data set coltext=? where coltext=?";
        
        //Open db
        //NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
        if (sqlite3_open([documentPath UTF8String], &cruddb)==SQLITE_OK) {
            
            if( sqlite3_prepare_v2(cruddb, sql, -1, &stmt, NULL)==SQLITE_OK ) {
                sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(stmt, 2, [txt UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                sqlite3_finalize(stmt);
                sqlite3_close(cruddb);
                NSLog(@"UpdateRecords: update record success.");
            } else {
                NSLog(@"UpdateRecords: Prepare Statement error");
            }    
        } else {
            NSLog(@"Error opening database");
        }
    }
    
}

-(void)DeleteRecords:(NSString *)txt{
    fileMgr = [NSFileManager defaultManager];
    //Get list of directories in Document path
    NSArray * dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"cruddb.sqlite"];

    if ([fileMgr fileExistsAtPath:documentPath]) {
        sqlite3_stmt *stmt=nil;
        sqlite3 *cruddb;
     
        //delete
        const char *sql = "Delete from data where coltext=?";
        
        //Open db
        //NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
        if ( sqlite3_open([documentPath UTF8String], &cruddb)==SQLITE_OK ) {
            
            if ( sqlite3_prepare_v2(cruddb, sql, -1, &stmt, NULL)==SQLITE_OK ) {
                sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
                
                sqlite3_step(stmt);
                sqlite3_finalize(stmt);
                sqlite3_close(cruddb);
                NSLog(@"DeleteRecords: delete record success.");
            } else {
                NSLog(@"DeleteRecords: Prepare Statement error");
            }
            
        } else {
            NSLog(@"Error opening database");
        }
    }
}

@end