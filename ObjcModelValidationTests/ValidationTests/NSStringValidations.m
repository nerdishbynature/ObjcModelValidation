//
//  NSStringValidations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSString+Validations.h"
#import "Kiwi.h"

SPEC_BEGIN(NSStringValidation)

describe(@"String", ^{
   it(@"validates with exclusions", ^{
       NSString *string = @"Hello Darling!";
       [[theValue([string exclusion:@[@"Darling"]]) should] beFalse];
   });
    
    it(@"validates with exclusions", ^{
        NSString *string = @"Hello Darling!";
        [[theValue([string exclusion:@[@"Piet"]]) should] beTrue];
    });
    
    it(@"validates with NSNumber", ^{
        NSString *string = @"Hello Darling!";
        [[theValue([string exclusion:@[@4]]) should] beTrue];
    });
});

SPEC_END