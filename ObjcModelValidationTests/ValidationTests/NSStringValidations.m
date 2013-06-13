//
//  NSStringValidations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSString+Validations.h"
#import "NSObject+Validations.h"
#import "Kiwi.h"

SPEC_BEGIN(NSStringValidation)

describe(@"String exclusion", ^{
    __block NSString *string;
    
    beforeEach(^{
        string = @"Hello Darling!";
    });
    
   it(@"validates with included String", ^{
       [[theValue([string exclusion:@[@"Darling"]]) should] beFalse];
   });
    
    it(@"validates with not included String", ^{
        [[theValue([string exclusion:@[@"Piet"]]) should] beTrue];
    });
    
    it(@"validates with NSNumber", ^{
        [[theValue([string exclusion:@[@4]]) should] beTrue];
    });
});

describe(@"String regex", ^{

    __block NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    it(@"validates email", ^{
        NSString *string = @"info@nerdishbynature.com";
        [[theValue([string format:regex]) should] beTrue];
    });
    
    it(@"validates nonsense", ^{
        NSString *string = @"info%nerdishbynaturecom,";
        [[theValue([string format:regex]) should] beFalse];
    });
});

describe(@"String inclusion", ^{
    
    __block NSString *string;
    
    beforeAll(^{
        string = @"Hello Darling!";
    });
    
    it(@"validates with included String", ^{
        [[theValue([string inclusion:@[@"Darling"]]) should] beTrue];
    });
    
    it(@"validates with not included String", ^{
        [[theValue([string inclusion:@[@"Piet"]]) should] beFalse];
    });
    
    it(@"validates with NSNumber", ^{
        [[theValue([string inclusion:@[@4]]) should] beFalse];
    });

});

describe(@"String length min", ^{
    __block NSString *string;
    
    beforeEach(^{
        string = @"Hello";
    });
    
    it(@"validates correct", ^{
        [[theValue([string lengthMin:1]) should] beTrue];
    });

    it(@"validates too short string", ^{
        [[theValue([string lengthMin:10]) should] beFalse];
    });
});

describe(@"String length max", ^{
    __block NSString *string;
    
    beforeEach(^{
        string = @"Hello";
    });
    
    it(@"validates correct", ^{
        [[theValue([string lengthMax:10]) should] beTrue];
    });
    
    it(@"string to long for validation", ^{
        [[theValue([string lengthMax:1]) should] beFalse];
    });
});

describe(@"String length min and max", ^{
    __block NSString *string;
    
    beforeEach(^{
        string = @"Hello";
    });
    
    it(@"validates correct", ^{
        [[theValue([string lengthIn:1 and:10]) should] beTrue];
    });
    
    it(@"string to short for validation", ^{
        [[theValue([string lengthIn:10 and:15]) should] beFalse];
    });
});


describe(@"String length is", ^{
    __block NSString *string;
    
    beforeEach(^{
        string = @"Hello";
    });
    
    it(@"validates correct", ^{
        [[theValue([string lengthIs:5]) should] beTrue];
    });
    
    it(@"not equal to validation", ^{
        [[theValue([string lengthIs:10]) should] beFalse];
    });
});

describe(@"Object presence", ^{
    __block NSString *string;
    
    it(@"validates with nil", ^{
        string = nil;
        [[theValue([string presence]) should] beFalse];
    });
    
    it(@"validates with initialization", ^{
        string = @"Hello";
        [[theValue([string presence]) should] beTrue];
    });
    
    it(@"validates with empty string", ^{
        string = @"";
        [[theValue([string presence]) should] beFalse];
    });
});

//describe(@"Object absence", ^{    
//    it(@"validates with nil", ^{
//        NSString *nilString = nil;
//        PBLog(@"%@", [nilString class]);
//        [[theValue([nilString absence]) should] beTrue];
//    });
//    
//    it(@"validates with initialization", ^{
//        NSString *helloString = @"Hello";
//        [[theValue([helloString absence]) should] beFalse];
//    });
//    
//    it(@"validates with empty string", ^{
//        NSString *emptyString = @"";
//        [[theValue([emptyString absence]) should] beTrue];
//    });
//});

describe(@"Object numericality", ^{
    
    it(@"validates with integer", ^{
        [[theValue([@"5" numericality])should] beTrue];
    });
    
    it(@"validates with en number", ^{
        [[theValue([@"4.5" numericality])should] beTrue];
    });
    
    it(@"validates with de number", ^{
        [[theValue([@"4,5" numericality])should] beTrue];
    });
    
    it(@"validates not with containing strings", ^{
        [[theValue([@"4,5de" numericality])should] beFalse];
    });
});



SPEC_END