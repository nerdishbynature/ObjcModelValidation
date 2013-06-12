//
//  NSNumber+Validations.m
//  ObjcModelValidation
//
//  Created by Piet Brauer on 12.06.13.
//  Copyright (c) 2013 Piet Brauer. All rights reserved.
//

#import "NSNumber+Validations.h"

@implementation NSNumber (Validations)

-(BOOL)greaterThan:(NSNumber *)referenceNumber{
    return ([self floatValue] > [referenceNumber floatValue]) ? YES : NO;
}

@end
