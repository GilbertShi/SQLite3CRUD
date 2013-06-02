//
//  kcbViewController.h
//  crud
//
//  Created by Kevin Languedoc on 11/29/11.
//  Copyright (c) 2011 kCodebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrudOp.h"

@interface kcbViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *stringFld;
@property (weak, nonatomic) IBOutlet UITextField *intFld;
@property (weak, nonatomic) IBOutlet UITextField *doubleFld;
@property (nonatomic, strong) IBOutlet UISegmentedControl *seg;
@property (nonatomic, strong) CrudOp *dbCrud;


- (IBAction)segButton;


@end
