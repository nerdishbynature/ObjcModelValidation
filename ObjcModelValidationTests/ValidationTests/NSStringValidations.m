//
//  NSStringValidations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "NSString+Validations.h"
#import "NSObject+Validations.h"

@interface NSStringValidationTests : XCTestCase

@property (nonatomic) NSString *subjectUnderTest;

@end

@implementation NSStringValidationTests

- (void)setUp {
    [super setUp];
    self.subjectUnderTest = @"Hello Darling!";
}

- (void)testThatItValidatesExclusionWithIncludedString {
    expect([self.subjectUnderTest exclusion:@[@"Darling"]]).to.beFalsy();
}

- (void)testThatItValidatesExclusionWithNotIncludedString {
    expect([self.subjectUnderTest exclusion:@[@"Piet"]]).to.beTruthy();
}

- (void)testThatItValidatesExclusionWithNSNumber {
    expect([self.subjectUnderTest exclusion:@[@4]]).to.beTruthy();
}

- (void)testThatItValidatesInclusionWithIncludedString {
    expect([self.subjectUnderTest inclusion:@[@"Darling"]]).to.beTruthy();
}

- (void)testThatItValidatesInclusionWithNotIncludedString {
    expect([self.subjectUnderTest inclusion:@[@"Piet"]]).to.beFalsy();
}

- (void)testThatItValidatesInclusionWithNSNumber {
    expect([self.subjectUnderTest inclusion:@[@"Piet"]]).to.beFalsy();
}

- (void)testThatItValidatesEmailRegex {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *subjectUnderTest = @"info@nerdishbynature.com";
    expect([subjectUnderTest format:regex]).to.beTruthy();
}

- (void)testThatItValidatesWithNonsenseEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *subjectUnderTest = @"info%nerdishbynaturecom,";
    expect([subjectUnderTest format:regex]).to.beFalsy;
}

- (void)testThatItValidatesMinimumLengthWithCorrectLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthMin:1]).to.beTruthy();
}

- (void)testThatItValidatesMinimumLengthWithWrongLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthMin:10]).to.beFalsy();
}

- (void)testThatItValidatesMaximumLengthWithCorrectLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthMax:10]).to.beTruthy();
}

- (void)testThatItValidatesMaximumLengthWithWrongLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthMax:1]).to.beFalsy();
}

- (void)testThatItValidatesMinAndMaxLengthWithCorrectRange {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthIn:1 and:10]).to.beTruthy();
}

- (void)testThatItValidatesMinAndMaxLengthWithWrongRange {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthIn:10 and:15]).to.beFalsy();
}

- (void)testThatItValidatesLengthWithCorrectLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthIs:5]).to.beTruthy();
}

- (void)testThatItValidatesLengthWithWrongLength {
    NSString *subjectUnderTest = @"Hello";
    expect([subjectUnderTest lengthIs:10]).to.beFalsy();
}

- (void)testThatItValidatesPresenceWithNilString {
    NSString *string;
    expect([string presence]).to.beFalsy();
}

- (void)testThatItValidatesPresenceWithString {
    NSString *string = @"Hello";
    expect([string presence]).to.beTruthy();
}

- (void)testThatItValidatesPresenceWithEmptyString {
    NSString *string = @"";
    expect([string presence]).to.beFalsy();
}

- (void)testThatItValidatesNumericalityWithIntegerString {
    expect([@"5" numericality]).to.beTruthy();
}

- (void)testThatItValidatesNumericalityWithFloatString {
    expect([@"4.5" numericality]).to.beTruthy();
}

- (void)testThatItValidatesNumericalityWithGermanFormattedFloatString {
    expect([@"4,5" numericality]).to.beTruthy();
}

- (void)testThatItValidatesNumericalityWithMalformattedFloatString {
    expect([@"4,5de" numericality]).to.beFalsy();
}

@end
