//
//  ViewController.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "ViewController.h"
#import "SampleModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SampleModel *sample = [[SampleModel alloc] init];
    sample.nameString = @"Piet";
    sample.ageNumber = @22;
    
    NSArray *errors = [sample save];
    if (errors.count != 0) {
        
        NSLog(@"I got some errors here.");
        
        for (NSError *error in errors) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"Hide" otherButtonTitles:nil];
            [alertView show];
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
