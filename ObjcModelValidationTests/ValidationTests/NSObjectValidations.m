//
//  NSObjectValidations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 13.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "Kiwi.h"
#import "NSObject+Validations.h"

SPEC_BEGIN(NSObjectValidationTests)

describe(@"Object presence", ^{
    __block id obj;
    
    it(@"validates only with declaration", ^{
        [[theValue([obj presence]) should] beFalse];
    });
    
    it(@"validates with nil", ^{
        obj = nil;
        [[theValue([obj presence]) should] beFalse];
    });
    
    it(@"validates with initialization", ^{
        obj = @"Hello";
        [[theValue([obj presence]) should] beTrue];
    });
});

//describe(@"Object absence", ^{
//    __block id obj;
//    
//    it(@"validates only with declaration", ^{
//        [[theValue([obj absence]) should] beTrue];
//    });
//    
//    it(@"validates with nil", ^{
//        obj = nil;
//        [[theValue([obj absence]) should] beTrue];
//    });
//    
//    it(@"validates with initialization", ^{
//        obj = @"Hello";
//        [[theValue([obj absence]) should] beFalse];
//    });
//});

SPEC_END