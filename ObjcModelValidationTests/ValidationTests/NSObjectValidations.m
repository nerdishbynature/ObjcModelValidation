#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "NSObject+Validations.h"

@interface NSObjectValidationTests : XCTestCase

@end

@implementation NSObjectValidationTests

- (void)testThatItValidatesWithoutDeclaration {
    id obj;
    expect([obj presence]).to.beFalsy();
}

- (void)testThatItValidatesWithNil {
    id obj = nil;
    expect([obj presence]).to.beFalsy();
}

- (void)testThatItValidatesWithInitialization {
    id obj = @"Hello";
    expect([obj presence]).to.beTruthy();
}

@end
