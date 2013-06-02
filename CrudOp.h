//
//  CrudOp.h
//  crud
//
//  Created by Kevin Languedoc on 11/29/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface CrudOp : NSObject{
    NSInteger dataId;
    NSString *coltext;
    NSInteger colint;
    double coldbl;
    sqlite3 *db;
    NSFileManager *fileMgr;
    NSString *homeDir;
    NSString *title;
 

    

}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *coltext;
@property (nonatomic,retain) NSString *homeDir;
@property (nonatomic, assign) NSInteger dataId;
@property (nonatomic,assign) NSInteger colint;
@property (nonatomic, assign) double coldbl;
@property (nonatomic,retain) NSFileManager *fileMgr;

-(void)CopyDbToDocumentsFolder;
-(NSString *) GetDocumentDirectory;

-(void)InsertRecords:(NSMutableString *)txt :(int) integer :(double) dbl;
-(void)UpdateRecords:(NSString *)txt :(NSMutableString *) utxt;
-(void)DeleteRecords:(NSString *)txt;



@end
