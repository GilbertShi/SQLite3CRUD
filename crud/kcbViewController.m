//
//  kcbViewController.m
//  crud
//
//  Created by Kevin Languedoc on 11/29/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import "kcbViewController.h"
#import "CrudOp.h"

@implementation kcbViewController
@synthesize stringFld;
@synthesize intFld;
@synthesize seg;
@synthesize doubleFld;
@synthesize dbCrud;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)dealloc{
    [self setStringFld:nil];
    [self setIntFld:nil];
    [self setDoubleFld:nil];
}

// move database from dpPath to documentPath
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSError * errInformation;
    dbCrud = [[CrudOp alloc] init];
    
    // [dbCrud CopyDbToDocumentsFolder];
    NSFileManager * fmgr = [NSFileManager defaultManager];
    //====================
    
    //Path to database in Resourse path
    NSString * dbPath = [[NSBundle mainBundle] pathForResource:@"cruddb" ofType:@"sqlite"];
    if(![fmgr fileExistsAtPath:dbPath]) {
        NSLog(@"Error database");
        return;
        
    }
    NSLog(@"originel path:dpPath-->  %@", dbPath);
    
    //Get list of directories in Document path 
    NSArray * dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Define new path for database
    NSString * documentPath = [[dirPath objectAtIndex:0] stringByAppendingPathComponent:@"cruddb.sqlite"];
    NSLog(@"target path:documentPath--> %@", documentPath);
    
    //Copy the database
    if(![fmgr fileExistsAtPath:documentPath]) {
        
        BOOL copyStatus = [fmgr copyItemAtPath:dbPath toPath:documentPath error:&errInformation ]; 
        if(copyStatus) {
            NSLog(@"copy from dpPath to documentPath--> success.");
        } else {
            NSLog(@"%@", [errInformation localizedDescription]);
            return;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textfield{
    
    if (textfield == [self stringFld]) {
        [textfield resignFirstResponder];
        
    } else if(textfield == [self intFld]) {
        [textfield resignFirstResponder];
    
    } else{
        [textfield resignFirstResponder];

    }
    return YES;
}


- (IBAction)segButton {
    NSMutableString *fldTxt = [NSMutableString stringWithString:self.stringFld.text];
    
    switch(self.seg.selectedSegmentIndex) {
        case 0:
            [dbCrud InsertRecords:fldTxt :[self.intFld.text intValue] :[self.doubleFld.text doubleValue]];            
            break;

        case 1:
            [dbCrud UpdateRecords:self.stringFld.text :fldTxt];
            break;
            
        case 2:
            [dbCrud DeleteRecords:self.stringFld.text];
            break;
    }
}
@end